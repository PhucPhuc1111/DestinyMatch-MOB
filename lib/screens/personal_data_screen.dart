import 'package:flutter/material.dart';
import 'package:flutter_chats_app/services/EditMemberService.dart';
import 'package:flutter_chats_app/utils/app_colors.dart';
import 'package:flutter_chats_app/screens/edit_member_screen.dart'; // Đảm bảo đã import màn hình EditMemberScreen

class PersonalDataScreen extends StatefulWidget {
  final String accountId;

  const PersonalDataScreen({required this.accountId, super.key});

  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _introduceController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? _gender;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMemberData();
  }

  Future<void> _fetchMemberData() async {
    try {
      final service = EditMemberService();
      final member = await service.getMemberByAccountId(widget.accountId);
      if (member != null) {
        setState(() {
          _fullNameController.text = member.fullname ?? '';
          _introduceController.text = member.introduce ?? '';
          _dobController.text = member.dob?.toLocal().toString().split(' ')[0] ?? '';
          _addressController.text = member.address ?? '';
          _gender = member.gender == true ? 'Male' : (member.gender == false ? 'Female' : null);
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching member data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Personal Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/images/Smith.jpg"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 35,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/profile_icon.png",
                            height: 18,
                            width: 18,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            "${_fullNameController.text}",
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/profile_icon.png",
                            height: 18,
                            width: 18,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            _introduceController.text,
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/address1.png",
                            height: 18,
                            width: 18,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            _addressController.text,
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/gender_icon.png",
                            height: 18,
                            width: 18,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            _gender ?? 'Not specified',
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/calendar_icon.png",
                            height: 18,
                            width: 18,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            _dobController.text,
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: AppColors.secondaryG,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            // TODO: Add functionality for changing password
                          },
                          minWidth: double.maxFinite,
                          height: 50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          textColor: AppColors.primaryColor1,
                          child: const Text(
                            "Change Password",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
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
                              color: Colors.black26,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditMemberScreen(accountId: widget.accountId),
                              ),
                            );
                          },
                          minWidth: double.maxFinite,
                          height: 50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          textColor: AppColors.primaryColor1,
                          child: const Text(
                            "Edit Personal Data",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}