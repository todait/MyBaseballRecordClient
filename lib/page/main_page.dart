import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_list.dart';
import 'package:my_baseball_record/common/app_text_style.dart';
import 'package:my_baseball_record/common/bottom_navigation_bar.dart';
import 'package:my_baseball_record/common/const/data.dart';
import 'package:my_baseball_record/common/empty_card.dart';
import 'package:my_baseball_record/common/game_card.dart';
import 'package:my_baseball_record/data/repository/game_model.dart';
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
  List<GameModel> _gameItems = [];

  DateTime _today = DateTime.now();
  List<GameModel> _todayGames = [];
  List<GameModel> _filteredUpcomingGames = [];

  List<GameModel> _finishedGames = [];
  List<GameModel> _todayFinishedGames = [];
  List<GameModel> _pastFinishedGames = [];

  Future<void> _fetchFinishedGames() async {
    final games = await repository.getFinishedGameModels();
    setState(() {
      _finishedGames = games;
      _updateFilteredFinishedGames();
    });
  }

  void _updateFilteredFinishedGames() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    _finishedGames.sort((a, b) => b.matchDate.compareTo(a.matchDate));

    _todayFinishedGames = _finishedGames.where((game) {
      final gameDate = DateTime(
        game.matchDate.year,
        game.matchDate.month,
        game.matchDate.day,
      );
      return gameDate == today;
    }).toList();

    _pastFinishedGames = _finishedGames.where((game) {
      final gameDate = DateTime(
        game.matchDate.year,
        game.matchDate.month,
        game.matchDate.day,
      );
      return gameDate.isBefore(today);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _fetchGames();
    _fetchFinishedGames();
    _startTimer();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  Future<void> _fetchGames() async {
    final games = await repository.getGameModels();
    setState(() {
      _gameItems = games;
      _updateFilteredGames();
      _gameItems.sort((a, b) => a.matchDate.compareTo(b.matchDate));
    });
  }

  void _updateFilteredGames() {
    _today = DateTime.now();

    _gameItems.sort((a, b) => a.matchDate.compareTo(b.matchDate));

    _todayGames = _getTodayGames(_gameItems);
    _filteredUpcomingGames =
        _gameItems.where((game) => game.matchDate.isAfter(_today)).toList();
  }

  List<GameModel> _getTodayGames(gameItems) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return gameItems.where((game) {
      final gameDate = DateTime(
          game.matchDate.year, game.matchDate.month, game.matchDate.day);
      final gameStartDateTime = DateTime(
        game.matchDate.year,
        game.matchDate.month,
        game.matchDate.day,
        game.startTime.hour,
        game.startTime.minute,
      );

      final isGameToday = gameDate == today;
      final isGameInProgress = now.isAfter(gameStartDateTime);
      final isGameUpcoming = gameStartDateTime.isAfter(now);

      return isGameToday && (isGameInProgress || isGameUpcoming);
    }).toList();
  }

  void checkToken() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    print(accessToken);
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

  Widget _buildGameList(List<GameModel> games) {
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
                gameModel: game,
              )
            ],
          );
        },
      ).toList(),
    );
  }

  Widget _buildFinishedGameList(List<GameModel> games, bool isToday) {
    return Column(
      children: games.map(
        (game) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isToday)
                const Padding(
                  padding: EdgeInsets.only(top: 10, left: 24),
                ),
              GameCard(
                gameModel: game,
              )
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
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  forceElevated: true,
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '오늘의 경기',
                                    style: AppTextStyle.h318B.copyWith(
                                      color: AppColor.textPrimary,
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
                                  Text(
                                    '다음 경기 일정',
                                    style: AppTextStyle.h318B.copyWith(
                                      color: AppColor.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    '${_filteredUpcomingGames.length}건  >',
                                    style: AppTextStyle.body413M.copyWith(
                                      color: AppColor.textHint,
                                    ),
                                  ),
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
                        return const SizedBox.shrink();
                      }
                    }
                  },
                ),
                ListView.builder(
                  itemCount: _finishedGames.isEmpty
                      ? 1
                      : (_todayFinishedGames.isNotEmpty ? 1 : 0) +
                          (_pastFinishedGames.isNotEmpty ? 1 : 0) +
                          1,
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
                      if (index == 0 && _todayFinishedGames.isNotEmpty) {
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
                                  Text(
                                    '오늘의 경기',
                                    style: AppTextStyle.h318B.copyWith(
                                      color: AppColor.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildFinishedGameList(_todayFinishedGames, true),
                          ],
                        );
                      } else if ((index == 0 &&
                              _todayFinishedGames.isEmpty &&
                              _pastFinishedGames.isNotEmpty) ||
                          (index == 1 &&
                              _todayFinishedGames.isNotEmpty &&
                              _pastFinishedGames.isNotEmpty)) {
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
                                  Text(
                                    '종료된 경기',
                                    style: AppTextStyle.h318B.copyWith(
                                      color: AppColor.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    '${_pastFinishedGames.length}건  >',
                                    style: AppTextStyle.body413M.copyWith(
                                      color: AppColor.textHint,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildFinishedGameList(_pastFinishedGames, false),
                          ],
                        );
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
      color: AppColor.graysWhite,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
