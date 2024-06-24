import 'package:destinymatch/models/Member.dart';
import 'package:destinymatch/services/ConversationService.dart';
import 'package:flutter/material.dart';

class Conversationcard extends StatelessWidget {
  Conversationcard({super.key});

  final Conversationservice _memberService = Conversationservice();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Member>>(
      future: _memberService.getListMember(),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ChatMemberCard(
                Mem: snapshot.data![index],
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ChatMemberCard extends StatelessWidget {
  final Member Mem;

  ChatMemberCard({super.key, required this.Mem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: Mem.pictures.isNotEmpty
            ?NetworkImage(Mem.pictures[0].urlPath.toString())
            : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
      ),
      title: Text(Mem.fullname.toString()),
      subtitle: Text(Mem.introduce.toString()),
      onTap: () {
        
      },
    );
  }
}
