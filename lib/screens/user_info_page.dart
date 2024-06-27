import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chats_app/utils/app_colors.dart';

class UserInfoPage extends StatelessWidget {
  UserInfoPage({ Key? key, required this.image,x}) : super(key: key);
  final String image;
  List<String> images = [
    'assets/images/Christine.jpg',
    'assets/images/Davis.jpg',
    'assets/images/Johnson.jpg',
    'assets/images/Jones Noa.jpg',
    'assets/images/Parker Bee.jpg',
    'assets/images/Smith.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColors.primaryColor,),
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
              icon: Icon(Icons.more_vert, color: AppColors.primaryColor,),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  margin: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(50)),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.fitWidth,
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
                        Text('Malena Veronica, 23', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: AppColors.secondary)),
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
                    const SizedBox(height: 8,),
                    Text('Fashion Designer at Victoria Secret', style: TextStyle(color: AppColors.secondary, fontSize: 16)),
                    const SizedBox(height: 8,),
                    Text('69m away', style: TextStyle(color: AppColors.secondary, fontSize: 16)),
                    const SizedBox(height: 32,),
                    Text('ABOUT ME', style: TextStyle(color: AppColors.secondary, fontSize: 18, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8,),
                    Text('Hey guys, This is Malena. I’m here to find someone for hookup. I’m not interested in something serious. I would love to hear your adventurous story.', style: TextStyle(color: AppColors.secondary, fontSize: 16, height: 1.5, fontWeight: FontWeight.normal)),
                    const SizedBox(height: 32,),
                    Text('INTERESTS', style: TextStyle(color: AppColors.secondary, fontSize: 18, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8,),
                    Wrap(
                      spacing: 10,
                      children: [
                        _chip(background: AppColors.lightOrange, color: AppColors.brightOrange, title: 'Travel'),
                        _chip(background: AppColors.lightBlue, color: AppColors.brightBlue, title: 'Dance'),
                        _chip(background: AppColors.lightOrange1, color: AppColors.brightOrange1, title: 'Fitness'),
                        _chip(background: AppColors.lightPurple, color: AppColors.brightPurple, title: 'Reading'),
                        _chip(background: AppColors.lightPurple1, color: AppColors.brightPurple1, title: 'Photography'),
                        _chip(background: AppColors.lightGreen, color: AppColors.brightGreen, title: 'Music'),
                        _chip(background: AppColors.lightPink, color: AppColors.brightPink, title: 'Movie'),
                      ],
                    ),
                    const SizedBox(height: 24,),
                    Text('INSTAGRAM PHOTOS', style: TextStyle(color: AppColors.secondary, fontSize: 18, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8,),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 114,
                            height: 114,
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(images[index]),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter,
                                // scale: 1.1,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 100,)
                  ],
                ),
              ),
              ),
            ]
          ),
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
                    onTap: () { },
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
                      child: Icon(Icons.close, color: AppColors.close, size: 32,),
                    ),
                  ),
                  InkWell(
                    onTap: () { },
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
                      child: Icon(Icons.star, color: AppColors.star, size: 32,),
                    ),
                  ),
                  InkWell(
                    onTap: () { },
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
                      child: Icon(Icons.favorite, color: AppColors.favorite, size: 32,),
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
   Widget _chip({required Color background, required Color color, required String title}) {
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