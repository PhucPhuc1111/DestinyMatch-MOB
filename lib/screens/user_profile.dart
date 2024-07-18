import 'package:flutter/material.dart';
import 'package:flutter_chats_app/screens/login_screen.dart';
import 'package:flutter_chats_app/screens/personal_data_screen.dart';
import 'package:flutter_chats_app/services/AccountService.dart';
import 'package:flutter_chats_app/services/EditMemberService.dart';
import 'package:flutter_chats_app/utils/app_colors.dart';
import 'package:flutter_chats_app/widgets/round_gradient_button.dart';
import 'package:flutter_chats_app/widgets/setting_row.dart';
import 'package:flutter_chats_app/widgets/title_subtitle_cell.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String _accountId = "";
  String _fullname = "Loading...";
  bool _isLoading = true;
  Accountservice accountservice = Accountservice();
  @override
  void initState() {
    super.initState();
    _loadAccountId();
  }

  Future<void> _loadAccountId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    if (userId != null) {
      setState(() {
        _accountId = userId;
      });
      _fetchMemberData();
    }
  }

  Future<void> _fetchMemberData() async {
    try {
      final service = EditMemberService();
      final member = await service.getMemberByAccountId(_accountId);
      if (member != null) {
        setState(() {
          _fullname = member.fullname ?? 'No name';
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching member data: $e');
      setState(() {
        _fullname = 'Error loading name';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    "",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // Ảnh đã tải xong
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return Center(
                        child: Icon(Icons.account_circle,
                            size: 50, color: Colors.grey),
                      ); // Placeholder nếu ảnh không tải được
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              "Dear $_fullname",
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                      const SizedBox(height: 8),
                      const Text(
                        "YouTuber",
                        style: TextStyle(
                          color: AppColors.grayColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 70,
                  height: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: AppColors.primaryG,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: MaterialButton(
                      minWidth: double.maxFinite,
                      height: 50,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PersonalDataScreen(accountId: _accountId),
                          ),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      textColor: AppColors.primaryColor1,
                      child: const Text(
                        "Edit",
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Row(
              children: [
                Expanded(
                  child: TitleSubtitleCell(title: "456", subtitle: "Friends"),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: TitleSubtitleCell(title: "456", subtitle: "followers"),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: TitleSubtitleCell(title: "456", subtitle: "Likes"),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Account",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SettingRow(
                    icon: "assets/icons/p_personal.png",
                    title: "Personal Data",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PersonalDataScreen(accountId: _accountId),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Other",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SettingRow(
                    icon: "assets/icons/p_contact.png",
                    title: "Contact Us",
                    onPressed: () {},
                  ),
                  SettingRow(
                    icon: "assets/icons/p_privacy.png",
                    title: "privacy Policy",
                    onPressed: () {},
                  ),
                  SettingRow(
                    icon: "assets/icons/p_setting.png",
                    title: "Settings",
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            RoundGradientButton(
                title: "Log Out",
                onPressed: () {
                  accountservice.logOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
