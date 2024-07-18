import 'package:flutter/material.dart';
import 'package:flutter_chats_app/models/Hobby.dart';
import 'package:flutter_chats_app/models/Major.dart';
import 'package:flutter_chats_app/models/MemberRequest%20.dart';
import 'package:flutter_chats_app/models/University.dart';
import 'package:flutter_chats_app/services/RegisterMemberService.dart'; // Thay thế bằng RegisterMemberService
import 'package:flutter_chats_app/screens/home_screen.dart';
import 'package:flutter_chats_app/utils/app_colors.dart';
import 'package:flutter_chats_app/widgets/date_of_birth.dart';
import 'package:flutter_chats_app/widgets/round_gradient_button.dart';
import 'package:flutter_chats_app/widgets/round_text_field.dart';

class RegisterMemberScreen extends StatefulWidget {
  final String? accountId;

  const RegisterMemberScreen({required this.accountId, super.key});

  @override
  State<RegisterMemberScreen> createState() => _RegisterMemberScreenState();
}

class _RegisterMemberScreenState extends State<RegisterMemberScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _introduceController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _gender;
  String? _selectedUniversityId;
  String? _selectedMajorId;

  List<Major> _majorOptions = [];
  List<University> _universityOptions = [];
  bool _isLoadingMajors = true;
  bool _isLoadingUniversities = true;
  List<Hobby> _hobbyOptions = [];
List<String> _selectedHobbyIds = [];
bool _isLoadingHobbies = true;

  @override
  void initState() {
    super.initState();
    _fetchUniversities();
    _fetchMajors();
    _fetchHobbies();

  }

  Future<void> _fetchHobbies() async {
  try {
    final service = RegisterMemberService();
    final hobbies = await service.fetchHobbies();
    setState(() {
      _hobbyOptions = hobbies;
      _isLoadingHobbies = false;
    });
  } catch (e) {
    print('Error fetching hobbies: $e');
    setState(() {
      _isLoadingHobbies = false;
    });
  }
}
  Future<void> _fetchUniversities() async {
    try {
      final service = RegisterMemberService();
      final universities = await service.fetchUniversities();
      setState(() {
        _universityOptions = universities;
        _isLoadingUniversities = false;
      });
    } catch (e) {
      print('Error fetching universities: $e');
      setState(() {
        _isLoadingUniversities = false;
      });
    }
  }

  Future<void> _fetchMajors() async {
    try {
      final service = RegisterMemberService();
      final majors = await service.fetchMajors();
      setState(() {
        _majorOptions = majors;
        _isLoadingMajors = false;
      });
    } catch (e) {
      print('Error fetching majors: $e');
      setState(() {
        _isLoadingMajors = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: media.height * 0.1),
                  const Text(
                    "Register Member",
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: media.height * 0.05),
                  RoundTextField(
                    textEditingController: _fullNameController,
                    hintText: "Full Name",
                    icon: "assets/icons/user_icon.png",
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your full name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: media.height * 0.02),
                  RoundTextField(
                    textEditingController: _introduceController,
                    hintText: "Introduce",
                    icon: "assets/icons/introduce.png",
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your introduction";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: media.height * 0.02),
                  DateOfBirthField(
                    textEditingController: _dobController,
                    hintText: "Date of Birth (YYYY-MM-DD)",
                    icon: "assets/icons/calendar_icon.png",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your date of birth";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: media.height * 0.02),
                  RoundTextField(
                    textEditingController: _addressController,
                    hintText: "Address",
                    icon: "assets/icons/address1.png",
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your address";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: media.height * 0.02),
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    hint: const Text("Select University"),
                    items: _isLoadingUniversities
                        ? [DropdownMenuItem(value: null, child: Text('Loading...'))]
                        : _universityOptions.map((University university) {
                            return DropdownMenuItem<String>(
                              value: university.id,
                              child: Text(university.name ?? 'No Name'),
                            );
                          }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedUniversityId = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Please select your university";
                      }
                      return null;
                    },
                  ),
                  
                   SizedBox(height: media.height * 0.02),
                  DropdownButtonFormField<String>(
                    hint: const Text("Select Major"),
                    items: _isLoadingMajors
                        ? [DropdownMenuItem(value: null, child: Text('Loading...'))]
                        : _majorOptions.map((Major major) {
                            return DropdownMenuItem<String>(
                              value: major.id,
                              child: Text(major.name ?? 'No Name'),
                            );
                          }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedMajorId = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Please select your major";
                      }
                      return null;
                    },
                  ),


                  SizedBox(height: media.height * 0.02),
                  Container(
                    color: Colors.white,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text("Male"),
                          value: 'Male',
                          groupValue: _gender,
                          onChanged: (String? value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                          tileColor: Colors.grey[200],
                          activeColor: AppColors.primaryColor,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text("Female"),
                          value: 'Female',
                          groupValue: _gender,
                          onChanged: (String? value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                          tileColor: Colors.grey[200],
                          activeColor: AppColors.primaryColor,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                  

                  ),

                  SizedBox(height: media.height * 0.02),
                const Text(
                  "Select Hobbies",
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: media.height * 0.02),
                _isLoadingHobbies
                    ? const CircularProgressIndicator()
                    : Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _hobbyOptions.map((hobby) {
                          final isSelected = _selectedHobbyIds.contains(hobby.id);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  _selectedHobbyIds.remove(hobby.id);
                                } else {
                                  _selectedHobbyIds.add(hobby.id);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.blue : Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                hobby.name ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                  SizedBox(height: media.height * 0.05),
                  RoundGradientButton(
                    title: "Register",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _register();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _register() async {
  final registerMemberService = RegisterMemberService();
  final universityId = _selectedUniversityId ?? '';
  final majorId = _selectedMajorId ?? '';

  final registrationRequest = MemberRequest(
    fullname: _fullNameController.text,
    introduce: _introduceController.text,
    dob: _dobController.text, // Đảm bảo là chuỗi ngày (YYYY-MM-DD)
    gender: _gender == 'Male' ? true : (_gender == 'Female' ? false : null),
    address: _addressController.text,
    surplus: 0,
    status: "string",
    accountId: widget.accountId,
    universityId: universityId,
    majorId: majorId,
  );

  try {
    final success = await registerMemberService.register(registrationRequest);
    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // Hiển thị thông báo lỗi
      print("Registration failed");
    }
  } catch (e) {
    // Hiển thị thông báo lỗi
    print("Exception occurred: $e");
  }
}

}
