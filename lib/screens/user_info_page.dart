import 'package:flutter/material.dart';
import 'package:flutter_chats_app/utils/app_colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserInfoPage extends StatefulWidget {
  final String id;
  final String image;

  UserInfoPage({super.key, required this.image, required this.id});

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  Map<String, dynamic>? memberData;
  bool isLoading = true;

  List<String> images = [
    'assets/images/Christine.jpg',
    'assets/images/Davis.jpg',
    'assets/images/Johnson.jpg',
    'assets/images/Jones Noa.jpg',
    'assets/images/Parker Bee.jpg',
    'assets/images/Smith.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _fetchMemberById();
  }

  Future<void> _fetchMemberById() async {
    try {
      final response = await http.get(Uri.parse(
          'https://destiny-match.azurewebsites.net/api/member/${widget.id}'));
      if (response.statusCode == 200) {
        setState(() {
          memberData = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load member data');
      }
    } catch (e) {
      print('Error fetching member data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  int _calculateAge(String dob) {
    DateTime birthDate = DateTime.parse(dob);
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  Future<void> _sendFavorite(String memberId) async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    try {
      final response = await http.post(
        Uri.parse('https://destiny-match.azurewebsites.net/api/matching'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'to-member-id': memberId}),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to send favorite');
      }
    } catch (e) {
      print('Error sending favorite: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: IconButton(
              icon: Icon(
                Icons.more_vert,
                color: AppColors.primaryColor,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                CustomScrollView(slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50)),
                        image: DecorationImage(
                          image: NetworkImage(
                              memberData!['url-path'][0] ?? widget.image),
                          fit: BoxFit.fill,
                          alignment: Alignment.topCenter,
                          scale: 1.1,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                  '${memberData!['fullname']}, ${_calculateAge(memberData!['dob'])}',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.secondary)),
                              const SizedBox(width: 10),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: AppColors.active,
                                  shape: BoxShape.circle,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                              'Gender: ${memberData!['gender'] ? 'Male' : 'Female'}',
                              style: TextStyle(
                                  color: AppColors.secondary, fontSize: 16)),
                          const SizedBox(
                            height: 8,
                          ),
                          Text('Address: ${memberData!['address']}',
                              style: TextStyle(
                                  color: AppColors.secondary, fontSize: 16)),
                          const SizedBox(
                            height: 32,
                          ),
                          Text('ABOUT ME',
                              style: TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(
                            height: 8,
                          ),
                          Text('${memberData!['introduce']}',
                              style: TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 16,
                                  height: 1.5,
                                  fontWeight: FontWeight.normal)),
                          const SizedBox(
                            height: 32,
                          ),
                          Text('INTERESTS',
                              style: TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(
                            height: 8,
                          ),
                          Wrap(
                            spacing: 10,
                            children: memberData!['hobbies']
                                .map<Widget>((hobby) => _chip(
                                    background: AppColors.lightOrange,
                                    color: AppColors.brightOrange,
                                    title: hobby))
                                .toList(),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text('All PHOTOS',
                              style: TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: memberData!['url-path'].length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 114,
                                  height: 114,
                                  margin: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          memberData!['url-path'][index]),
                                      fit: BoxFit.fill,
                                      alignment: Alignment.topCenter,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 50),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.white,
                          Colors.white,
                          Colors.white.withOpacity(0.6),
                          Colors.white.withOpacity(0),
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.close,
                              color: AppColors.close,
                              size: 32,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.star,
                              color: AppColors.star,
                              size: 32,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _sendFavorite(widget.id);
                          },
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.favorite,
                              color: AppColors.favorite,
                              size: 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }

  Widget _chip(
      {required Color background,
      required Color color,
      required String title}) {
    return Chip(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      label: Text(title, style: TextStyle(color: color)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      backgroundColor: background,
    );
  }
}
