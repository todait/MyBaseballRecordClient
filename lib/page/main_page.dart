import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_list.dart';
import 'package:my_baseball_record/common/app_text_style.dart';
import 'package:my_baseball_record/common/bottom_navigation_bar.dart';
import 'package:my_baseball_record/common/empty_card.dart';
import 'package:my_baseball_record/common/game_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late TabController _tabController;

  final List<GameCard> _upcomingGames = [
    GameCard(
      position: '포지션 미정',
      matchPlace: '조안면 체육공원(UA 베이스볼 파크)',
      teamIcon:
          'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
      teamName: '발키리',
      btnTitle: '결과 입력하기',
      btnTitleStyle: AppTextStyle.body315M
          .copyWith(fontSize: 16, color: AppColor.graysWhite),
      matchDate: DateTime(2024, 4, 18),
      startTime: const TimeOfDay(hour: 14, minute: 0),
      endTime: const TimeOfDay(hour: 16, minute: 0),
    ),
    GameCard(
      position: '포지션 미정',
      matchPlace: '조안면 체육공원(UA 베이스볼 파크)',
      teamIcon:
          'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
      teamName: '발키리',
      btnTitle: '결과 입력하기',
      btnTitleStyle: AppTextStyle.body315M
          .copyWith(fontSize: 16, color: AppColor.graysWhite),
      matchDate: DateTime(2024, 4, 18),
      startTime: const TimeOfDay(hour: 16, minute: 0),
      endTime: const TimeOfDay(hour: 18, minute: 0),
    ),
    GameCard(
      matchDate: DateTime(2024, 4, 19),
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 12, minute: 0),
      position: 'position',
      matchPlace: 'matchPlace',
      teamIcon:
          'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
      teamName: 'teamName',
      btnTitle: 'btnTitle',
    ),
    GameCard(
      matchDate: DateTime(2024, 6, 18),
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 12, minute: 0),
      position: 'position',
      matchPlace: 'matchPlace',
      teamIcon:
          'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
      teamName: 'teamName',
      btnTitle: 'btnTitle',
    ),
    GameCard(
      matchDate: DateTime(2024, 12, 18),
      startTime: const TimeOfDay(hour: 16, minute: 0),
      endTime: const TimeOfDay(hour: 18, minute: 0),
      position: 'position',
      matchPlace: 'matchPlace',
      teamIcon:
          'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
      teamName: 'teamName',
      btnTitle: 'btnTitle',
    ),
  ];

  List<GameCard> _getTodayGames(List<GameCard> games) {
    final today = DateTime.now();
    return games
        .where((game) =>
            game.matchDate.year == today.year &&
            game.matchDate.month == today.month &&
            game.matchDate.day == today.day)
        .toList();
  }

  final List<GameCard> _finishedGames = [
    GameCard(
      totalNumber: 20,
      matchDate: DateTime(2024, 4, 20),
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 12, minute: 0),
      position: 'position',
      matchPlace: 'matchPlace',
      teamIcon:
          'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
      teamName: 'teamName',
      btnTitle: 'btnTitle',
    ),
    GameCard(
      matchDate: DateTime(2024, 4, 24),
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 12, minute: 0),
      position: 'position',
      matchPlace: 'matchPlace',
      teamIcon:
          'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
      teamName: 'teamName',
      btnTitle: 'btnTitle',
    ),
  ];

  int _selectedIndex = 0;
  DateTime _currentTime = DateTime.now();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateCurrentTime();
    });
  }

  void _updateCurrentTime() {
    if (mounted) {
      setState(() {
        _currentTime = DateTime.now();
      });
    }
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

  Widget _buildTabLabel(String selectedText, int index) {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 8),
          Text(
            selectedText,
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
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todayGames = _getTodayGames(_upcomingGames);

    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: AppColor.graysWhite,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  expandedHeight: 95,
                  toolbarHeight: 45,
                  collapsedHeight: 45,
                  pinned: true,
                  centerTitle: false,
                  flexibleSpace: FlexibleSpaceBar(
                    title: innerBoxIsScrolled
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat(
                                    'M월 d일 E a h:mm',
                                    'ko_KR',
                                  )
                                      .format(
                                        _currentTime,
                                      )
                                      .replaceAll(
                                        'AM',
                                        '오전',
                                      )
                                      .replaceAll(
                                        'PM',
                                        '오후',
                                      ),
                                  style: AppTextStyle.body315M.copyWith(
                                    color: AppColor.textHint,
                                  ),
                                ),
                                const Icon(
                                  Icons.add,
                                  size: 24,
                                  color: AppColor.textHint,
                                ),
                              ],
                            ),
                          )
                        : null,
                    background: Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                      ),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.add,
                                size: 24,
                                color: AppColor.textHint,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                AppTextList.upcomingMatches,
                                style: AppTextStyle.h224B.copyWith(
                                  color: AppColor.textPrimary,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                DateFormat(
                                  'M월 d일 E a h:mm',
                                  'ko_KR',
                                )
                                    .format(
                                      _currentTime,
                                    )
                                    .replaceAll(
                                      'AM',
                                      '오전',
                                    )
                                    .replaceAll(
                                      'PM',
                                      '오후',
                                    ),
                                style: AppTextStyle.body315M.copyWith(
                                  color: AppColor.textHint,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      controller: _tabController,
                      tabs: [
                        _buildTabLabel(AppTextList.upcoming, 1),
                        _buildTabLabel(AppTextList.finished, 2),
                      ],
                      indicatorColor: AppColor.textPrimary,
                      labelColor: AppColor.textPrimary,
                      labelStyle: AppTextStyle.h318B,
                      unselectedLabelColor: AppColor.textHint,
                      unselectedLabelStyle: AppTextStyle.h418M,
                      indicatorWeight: 2,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding:
                          const EdgeInsets.symmetric(horizontal: 24),
                      labelPadding: const EdgeInsets.only(bottom: 5),
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: _upcomingGames.isEmpty
                      ? 1
                      : todayGames.length +
                          (_upcomingGames.length - todayGames.length) +
                          2,
                  itemBuilder: (context, index) {
                    if (_upcomingGames.isEmpty) {
                      return EmptyCard(
                        text1: AppTextList.hasScheduledGames,
                        text2: AppTextList.addScheduleTitle,
                        text3: AppTextList.addPreMatchSchedule,
                        icon: Image.asset(
                          'assets/icon/group_343.png',
                        ),
                      );
                    } else {
                      if (index == 0) {
                        return todayGames.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(24, 50, 24, 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('오늘의 경기',
                                            style: AppTextStyle.h318B),
                                      ],
                                    ),
                                  ),
                                  ...todayGames.map((game) => game),
                                ],
                              )
                            : Container();
                      } else if (index == todayGames.length + 1) {
                        final futureGames =
                            _upcomingGames.sublist(todayGames.length);
                        return futureGames.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('다음 경기 일정',
                                            style: AppTextStyle.h318B),
                                        Text('${futureGames.length} >',
                                            style: AppTextStyle.body315M),
                                      ],
                                    ),
                                  ),
                                  ...futureGames.map((game) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: game,
                                    );
                                  }),
                                ],
                              )
                            : Container();
                      } else if (index ==
                          todayGames.length +
                              (_upcomingGames.length - todayGames.length) +
                              1) {
                        return EmptyCard(
                          text1: AppTextList.hasScheduledGames,
                          text2: AppTextList.addScheduleTitle,
                          text3: AppTextList.addPreMatchSchedule,
                          icon: Image.asset(
                            'assets/icon/group_343.png',
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }
                  },
                ),
                ListView.builder(
                  itemCount:
                      _finishedGames.isEmpty ? 1 : _finishedGames.length + 1,
                  itemBuilder: (context, index) {
                    if (_finishedGames.isEmpty) {
                      return EmptyCard(
                        text1: AppTextList.hasParticipatedGames,
                        text2: AppTextList.recordGameResultMessage,
                        text3: AppTextList.addPastRecord,
                        icon: Image.asset(
                          'assets/icon/group_341.png',
                        ),
                      );
                    } else {
                      if (index < _finishedGames.length) {
                        return _finishedGames[index];
                      } else {
                        return EmptyCard(
                          text1: AppTextList.hasParticipatedGames,
                          text2: AppTextList.recordGameResultMessage,
                          text3: AppTextList.addPastRecord,
                          icon: Image.asset(
                            'assets/icon/group_341.png',
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        onTabIcon: onTabIcon,
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColor.transparent,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
