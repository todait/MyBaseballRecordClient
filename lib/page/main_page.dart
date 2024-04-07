import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_bar.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_list.dart';
import 'package:my_baseball_record/common/app_text_style.dart';
import 'package:my_baseball_record/common/bottom_navigation_bar.dart';
import 'package:my_baseball_record/common/empty_card.dart';
import 'package:my_baseball_record/page/profile_page.dart';
import 'package:my_baseball_record/page/record_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late TabController _tabController;

  int _selectedIndex = 0;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    startTimer();
    _tabController = TabController(length: 3, vsync: this);
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

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

  Widget _buildTabLabel(String selectedText, String unselectedText, int index) {
    final isSelected = _tabController.index == index;
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 8),
          Text(
            isSelected ? selectedText : unselectedText,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        trailingIcon: const Icon(
          Icons.add,
          size: 24,
          color: AppColor.textHint,
        ),
        title: AppTextList.upcomingMatches,
        titleStyle: AppTextStyle.h224B.copyWith(color: AppColor.textPrimary),
        timeTitle: _currentTime,
        timeStyle: AppTextStyle.body315M.copyWith(color: AppColor.textHint),
        tabController: _tabController,
        tabs: [
          _buildTabLabel(AppTextList.gameOfTheDay, AppTextList.today, 0),
          _buildTabLabel(
              AppTextList.upcomingMatchesTitle, AppTextList.upcoming, 1),
          _buildTabLabel(AppTextList.completedMatches, AppTextList.finished, 2),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              EmptyCard(
                icon: Image.asset('assets/icon/group_342.png'),
                text1: AppTextList.noGamesTodayMessage,
                text2: AppTextList.restForNextScheduleMessage,
                text3: AppTextList.addScheduleButton,
              ),
              EmptyCard(
                icon: Image.asset('assets/icon/group_343.png'),
                text1: AppTextList.hasScheduledGames,
                text2: AppTextList.addScheduleTitle,
                text3: AppTextList.addPreMatchSchedule,
              ),
              EmptyCard(
                icon: Image.asset('assets/icon/group_341.png'),
                text1: AppTextList.hasParticipatedGames,
                text2: AppTextList.recordGameResultMessage,
                text3: AppTextList.addPastRecord,
              ),
            ],
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
