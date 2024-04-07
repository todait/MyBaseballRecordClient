import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_bar.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_list.dart';
import 'package:my_baseball_record/common/app_text_style.dart';
import 'package:my_baseball_record/common/bottom_navigation_bar.dart';
import 'package:my_baseball_record/common/game_card.dart';
import 'package:my_baseball_record/page/profile_page.dart';
import 'package:my_baseball_record/page/record_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void onTabIcon(int index) {
    setState(() {
      _selectedIndex = index;
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
            _selectedIndex = index;
          });
        },
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    AppTextList.mainTitle,
                    style: AppTextStyle.h224B,
                  ),
                  const SizedBox(height: 30),
                  GameCard(
                    title: AppTextList.recentMatchesTitle,
                    titleTextStyle: AppTextStyle.h318B
                        .copyWith(color: AppColor.textPrimary),
                    count: 0,
                    countTitle: AppTextList.countMatchesTitle,
                    countTextStyle: AppTextStyle.body413M
                        .copyWith(color: AppColor.textHint),
                    icon: Image.asset('assets/icon/Frame 18.png'),
                    subTitle: AppTextList.addPastRecordTitle,
                    subTextStyle: AppTextStyle.body315M
                        .copyWith(color: AppColor.textHint),
                    btnTitle: AppTextList.addResultTitle,
                    btnTextStyle: AppTextStyle.body315M
                        .copyWith(color: AppColor.primaryBlue2),
                  ),
                ],
              ),
            ),
          ),
          const RecordPage(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        onTabIcon: onTabIcon,
      ),
    );
  }
}
