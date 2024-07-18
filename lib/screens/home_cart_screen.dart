import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chats_app/utils/app_colors.dart';
import 'package:flutter_chats_app/widgets/profile_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeCartScreen extends StatefulWidget {
  const HomeCartScreen({super.key});

  @override
  State<HomeCartScreen> createState() => _HomeCartState();
}

class _HomeCartState extends State<HomeCartScreen> {
  List<ProfileCard> profile = [];

  Future<void> _fetchMembers() async {
    try {
      final response = await http.get(Uri.parse(
          'https://destiny-match.azurewebsites.net/api/member?pagesize=20'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data'];
        for (var member in data) {
          String id = member['id'];
          String imageUrl =
              member['url-path'] != null && member['url-path'].isNotEmpty
                  ? member['url-path'][0]
                  : 'assets/images/Smith.jpg';
          String name = member['fullname'] ?? 'No Name';
          String description = member['introduce'] ?? 'No Description';
          String age = member['dob'] ?? '23';

          profile.add(ProfileCard(
            id: id,
            image: imageUrl,
            name: name,
            description: description,
            age: age,
          ));
        }
        setState(() {}); // Refresh UI after data is fetched
      } else {
        throw Exception('Failed to load member data');
      }
    } catch (e) {
      print('Error fetching member data: $e');
      // Handle error gracefully
    }
  }

  Future<void> _sendFavorite(String memberId) async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    try {
      final response = await http.post(
        Uri.parse('https://destiny-match.azurewebsites.net/api/matching'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Add authorization header here
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
  void initState() {
    super.initState();
    _fetchMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'For You',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.person,
            color: AppColors.primaryColor,
          ),
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton.icon(
              icon: Icon(
                Icons.arrow_drop_down,
                color: AppColors.primaryColor,
              ),
              label: Text(
                "Filter",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "filter options",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const TextField(
                            decoration: InputDecoration(
                              labelText: "Option 2",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Xử lý khi nhấn nút "Apply"
                            },
                            child: const Text("Apply"),
                          ),
                        ],
                      ),
                    );
                  },
                );
                // Xử lý sự kiện khi nhấn nút "Filter"
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 130, top: 16),
            child: AppinioSwiper(
              cardCount: profile.length,
              cardBuilder: (BuildContext context, int index) {
                return profile[index];
              },
            ),
          ),
          Positioned(
            bottom: 50,
            right: 0,
            left: 0,
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
                    if (profile.isNotEmpty) {
                      _sendFavorite(profile[0].id);
                    }
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
        ],
      ),
    );
  }
}
