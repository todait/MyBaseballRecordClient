import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_list.dart';
import 'package:my_baseball_record/common/app_text_style.dart';
import 'package:my_baseball_record/common/bottom_navigation_bar.dart';
import 'package:my_baseball_record/common/empty_card.dart';
import 'package:my_baseball_record/common/game_card.dart';
import 'package:my_baseball_record/data/repository/game_repository.dart';

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
  late Timer _timer;

  final repository = GameRepository();
  List<GameCard> _gameItems = [];

  DateTime _today = DateTime.now();
  List<GameCard> _todayGames = [];
  List<GameCard> _filteredUpcomingGames = [];

  final List<GameCard> _finishedGames = [
    GameCard(
      matchDate: DateTime(2024, 4, 17),
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 12, minute: 0),
      matchPlace: '조안면 체육공원(UA 베이스볼 파크)',
      team1Icon:
          'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
      team1Name: 'teamName',
      btnTitle: '결과 입력하기',
      team2Icon:
          'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
      team2Name: 'teamName',
    ),
    GameCard(
      matchDate: DateTime(2024, 4, 17),
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 12, minute: 0),
      matchPlace: '조안면 체육공원(UA 베이스볼 파크)',
      team1Icon:
          'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
      team1Name: 'teamName',
      btnTitle: '결과 입력하기',
      team2Icon:
          'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
      team2Name: 'teamName',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fetchGames();
    _startTimer();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  Future<void> _fetchGames() async {
    final games = await repository.getGames('game');
    setState(() {
      _gameItems = games;
      _updateFilteredGames();
    });
  }

  void _updateFilteredGames() {
    _today = DateTime.now();
    _todayGames = _getTodayGames(_gameItems);
    _filteredUpcomingGames =
        _gameItems.where((game) => game.matchDate.isAfter(_today)).toList();
  }

  List<GameCard> _getTodayGames(gameItems) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    return gameItems.where((game) {
      final gameStartDateTime = DateTime(
        game.matchDate.year,
        game.matchDate.month,
        game.matchDate.day,
        game.startTime.hour,
        game.startTime.minute,
      );
      final gameEndDateTime = DateTime(
        game.matchDate.year,
        game.matchDate.month,
        game.matchDate.day,
        game.endTime.hour,
        game.endTime.minute,
      );

      final isGameInProgress =
          now.isAfter(gameStartDateTime) && now.isBefore(gameEndDateTime);
      final isGameUpcoming = gameStartDateTime.isAfter(now) &&
          gameStartDateTime.isBefore(tomorrow);

      return isGameInProgress || isGameUpcoming;
    }).toList();
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

  Widget _buildGameList(List<GameCard> games) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: games.map(
        (game) {
          final isFirstCard = games.indexOf(game) == 0;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isFirstCard) const SizedBox(height: 16),
              GameCard(
                matchDate: game.matchDate,
                startTime: game.startTime,
                endTime: game.endTime,
                positions: game.positions,
                matchPlace: game.matchPlace,
                team1Icon: game.team1Icon,
                team1Name: game.team1Name,
                btnTitle: game.btnTitle,
                team2Icon: game.team2Icon,
                team2Name: game.team2Name,
              ),
            ],
          );
        },
      ).toList(),
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
                  itemCount: _gameItems.isEmpty
                      ? 1
                      : _todayGames.length +
                          (_filteredUpcomingGames.isNotEmpty ? 2 : 1),
                  itemBuilder: (context, index) {
                    if (_gameItems.isEmpty) {
                      return EmptyCard(
                        text1: AppTextList.hasScheduledGames,
                        text2: AppTextList.addScheduleTitle,
                        text3: AppTextList.addPreMatchSchedule,
                        icon: Image.asset(
                          'assets/icon/group_343.png',
                        ),
                      );
                    } else {
                      if (index == 0 && _todayGames.isNotEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(24, 16, 24, 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '오늘의 경기',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildGameList(_todayGames),
                          ],
                        );
                      } else if (index == (_todayGames.isNotEmpty ? 1 : 0) &&
                          _filteredUpcomingGames.isNotEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('다음 경기 일정',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Text('${_filteredUpcomingGames.length} >',
                                      style: const TextStyle(fontSize: 14)),
                                ],
                              ),
                            ),
                            _buildGameList(_filteredUpcomingGames),
                          ],
                        );
                      } else if (index ==
                          _todayGames.length +
                              (_filteredUpcomingGames.isNotEmpty ? 1 : 0)) {
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
