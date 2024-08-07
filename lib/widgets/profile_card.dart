import 'package:flutter/material.dart';
import 'package:flutter_chats_app/screens/user_info_page.dart';
import 'package:flutter_chats_app/utils/app_colors.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.age,
  });

  final String id;
  final String image;
  final String name;
  final String description;
  final String age;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserInfoPage(image: image, id: id),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 0,
            child: Container(
              height: 104,
              width: MediaQuery.of(context).size.width / 1.2,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$name, $age',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
