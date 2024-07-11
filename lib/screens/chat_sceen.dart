import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chats_app/utils/app_colors.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:flutter_chats_app/services/MessageService.dart';
import 'package:flutter_chats_app/widgets/bottom_chat_sheet.dart';
import 'package:flutter_chats_app/widgets/chat_message_sample.dart';

class ChatScreen extends StatefulWidget {
  final String matchingId, matchingName, matchingImage;

  const ChatScreen({super.key, required this.matchingId, required this.matchingName, required this.matchingImage});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Messageservice messageservice = Messageservice();
  late HubConnection _hubConnection;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  List<dynamic> messages = [];
  String senderId = "";

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchConversation();
    _connectToHub();
    _listenForMessages();
  }

  @override
  void dispose() {
    _scrollController
        .dispose();
    super.dispose();
  }

  Future<void> fetchConversation() async {
    try {
      var token = await _storage.read(key: "token");
      if (token == null) {
        throw Exception("No token found, please login again");
      }
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token.toString());
      var memberId = decodedToken["memberid"];
      var data = await messageservice.getMessages(widget.matchingId);
      setState(() {
        messages = data;
        senderId = memberId;
      });
    } catch (e) {
      print("Error fetching conversation: $e");
    }
  }

  Future<void> _connectToHub() async {
    try {
      _hubConnection = HubConnectionBuilder()
          .withUrl('https://localhost:7215/chatHub')
          .build();

      await _hubConnection.start();
      await _hubConnection
          .invoke('JoinGroup', args: [senderId, widget.matchingId]);
    } catch (e) {
      print("Error connecting to hub: $e");
    }
  }

  void _listenForMessages() {
  try {
    _hubConnection.on('ReceiveMessage', (args) {
      if (args != null && args.isNotEmpty) {
        var message = {
          "sender-id": args[0],
          "content": args[1],
        };
        setState(() {
          messages.add(message);
        });
        _scrollToBottom();
      }
    });
  } catch (e) {
    print("Error listening for messages: $e");
  }
}

void _scrollToBottom() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          padding: const EdgeInsets.only(top: 5),
          margin: EdgeInsets.zero,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                spreadRadius: 2,
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            leadingWidth: 40,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  CupertinoIcons.arrow_left,
                  size: 25,
                  color: AppColors.primaryColor2,
                ),
              ),
            ),
            title: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        widget.matchingImage,
                      ),
                      minRadius: 25,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2.5),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.5),
                        ),
                        child: const Icon(
                          Icons.brightness_1,
                          size: 8,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.matchingName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Active Now",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ChatMessageSample(
                  isMeChatting: message["sender-id"] == senderId,
                  messageBody: message["content"],
                );
              },
            ),
          ),
          BottomChatSheet(
            matchingId: widget.matchingId,
            senderId: senderId,
            hubConnection: _hubConnection,
          ),
        ],
      ),
    );
  }
}
