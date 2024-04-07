import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_bar.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_list.dart';
import 'package:my_baseball_record/common/app_text_style.dart';
import 'package:my_baseball_record/common/bottom_navigation_bar.dart';
import 'package:my_baseball_record/page/profile_page.dart';
import 'package:my_baseball_record/page/record_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  final PageController _pageController = PageController();

  void onTabIcon(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 1200),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        trailingIcon: Icon(
          Icons.notifications_none,
          size: 20,
          color: AppColor.textHint,
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: const [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTextList.mainTitle,
                    style: AppTextStyle.h224B,
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
          RecordPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: selectedIndex,
        onTabIcon: onTabIcon,
      ),
    );
  }
}
