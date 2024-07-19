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
  final TextEditingController minAgeController = TextEditingController();
  final TextEditingController maxAgeController = TextEditingController();
  final AppinioSwiperController swiperController = AppinioSwiperController();
  int currentIndex = 0; // Track the current card index

  Future<void> _fetchMembers({int minAge = 0, int maxAge = 100}) async {
    try {
      final response = await http.get(Uri.parse(
          'https://destiny-match.azurewebsites.net/api/member?minAge=$minAge&maxAge=$maxAge&pagesize=22'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data'];
        List<ProfileCard> fetchedProfiles = [];
        for (var member in data) {
          String id = member['id'];
          String imageUrl =
              member['url-path'] != null && member['url-path'].isNotEmpty
                  ? member['url-path'][0]
                  : 'assets/images/Smith.jpg';
          String name = member['fullname'] ?? 'No Name';
          String description = member['introduce'] ?? 'No Description';
          String age = _calculateAge(member['dob'] ?? '2000-01-01').toString();

          fetchedProfiles.add(ProfileCard(
            id: id,
            image: imageUrl,
            name: name,
            description: description,
            age: age,
          ));
        }
        setState(() {
          profile = fetchedProfiles;
        });
      } else {
        throw Exception('Failed to load member data');
      }
    } catch (e) {
      print('Error fetching member data: $e');
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

  void _showTopSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 50,
        left: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    overlay?.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
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
                            "Filter options",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: minAgeController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: "Min Age",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextField(
                                  controller: maxAgeController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: "Max Age",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              if (minAgeController.text.isNotEmpty &&
                                  maxAgeController.text.isNotEmpty) {
                                int minAge = int.parse(minAgeController.text);
                                int maxAge = int.parse(maxAgeController.text);
                                _fetchMembers(minAge: minAge, maxAge: maxAge);
                                Navigator.pop(context);
                              } else {
                                _showTopSnackBar(
                                  context,
                                  'Both fields are required',
                                );
                              }
                            },
                            child: const Text("Apply"),
                          ),
                        ],
                      ),
                    );
                  },
                );
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
              controller: swiperController, // Add the controller here
              cardCount: profile.length,
              cardBuilder: (BuildContext context, int index) {
                return profile[index];
              },
              onSwipeEnd: (int index, int direction, SwiperActivity activity) {
                setState(() {
                  currentIndex = index + 1;
                });
              },
              onEnd: () {
                setState(() {
                  currentIndex = 0;
                });
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
                    if (profile.isNotEmpty && currentIndex < profile.length) {
                      _sendFavorite(profile[currentIndex].id);
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
