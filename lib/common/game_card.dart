import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_list.dart';
import 'package:my_baseball_record/common/app_text_style.dart';
import 'package:my_baseball_record/common/auth_button.dart';
import 'package:my_baseball_record/common/match_status_widget.dart';
import 'package:my_baseball_record/common/position_chip_widget.dart';
import 'package:my_baseball_record/page/game_result_page.dart';

class GameCard extends StatefulWidget {
  final int? totalNumber;
  final DateTime matchDate;
  final TimeOfDay startTime;
  final int? ourTeamScore;
  final int? opponentTeamScore;
  final String? result;

  final List<String> positions;
  final String matchPlace;
  final String? team1Icon;
  final String team1Name;
  final String? team2Icon;
  final String team2Name;
  final String btnTitle;
  final FinishedMatchStatus? finishedMatchStatus;

  final TextStyle? totalNumberStyle;
  final TextStyle? statusChipStyle;
  final TextStyle? timeStyle;
  final TextStyle? positionStyle;
  final TextStyle? matchPlaceStyle;
  final TextStyle? teamNameStyle;
  final TextStyle? btnTitleStyle;

  const GameCard({
    super.key,
    this.totalNumber,
    required this.matchDate,
    required this.startTime,
    this.positions = const ['포지션 미정'],
    required this.matchPlace,
    this.team1Icon,
    required this.team1Name,
    this.team2Icon,
    required this.team2Name,
    required this.btnTitle,
    this.totalNumberStyle,
    this.statusChipStyle,
    this.timeStyle,
    this.positionStyle,
    this.matchPlaceStyle,
    this.teamNameStyle,
    this.btnTitleStyle,
    this.finishedMatchStatus,
    this.ourTeamScore,
    this.opponentTeamScore,
    this.result,
  });

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  int? _ourTeamScore;
  int? _opponentTeamScore;
  String? _result;

  void _navigateToGameResultPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameResultPage(gameCard: widget),
      ),
    );

    if (result != null) {
      setState(() {
        _ourTeamScore = result['ourTeamScore'];
        _opponentTeamScore = result['opponentTeamScore'];
        _result = result['result'];
      });
    }
  }

  Color _getResultColor(String result) {
    switch (result) {
      case '승':
        return AppColor.accentGreen100;
      case '무':
        return AppColor.textHint;
      case '패':
        return AppColor.accentRed100;
      default:
        return AppColor.textHint;
    }
  }

  MatchStatus _getMatchStatus() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final diff = widget.matchDate.difference(today).inDays;
    final matchStartDateTime = DateTime(
        widget.matchDate.year,
        widget.matchDate.month,
        widget.matchDate.day,
        widget.startTime.hour,
        widget.startTime.minute);
    final matchEndDateTime = matchStartDateTime.add(const Duration(hours: 2));

    if (widget.matchDate.isBefore(today)) {
      return MatchStatus.notStarted;
    } else if (widget.matchDate == today &&
        now.isAfter(matchStartDateTime) &&
        now.isBefore(matchEndDateTime)) {
      return MatchStatus.inProgress;
    } else if (diff == 0) {
      return MatchStatus.startToday;
    } else if (diff == 1) {
      return MatchStatus.tomorrow;
    } else if (diff <= 100) {
      return MatchStatus.upcoming;
    } else {
      return MatchStatus.future;
    }
  }

  Widget _buildTeamIcon(String? iconUrl) {
    return (iconUrl == null || iconUrl.isEmpty)
        ? Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: AppColor.graysGray,
              borderRadius: BorderRadius.circular(8),
            ),
          )
        : Image.network(
            iconUrl,
            width: 150,
            height: 150,
          );
  }

  Widget _buildTeamIconSection(String? teamIcon) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTeamIcon(teamIcon),
          SizedBox(
            width: 100,
            child: Text(
              widget.team1Name,
              style: AppTextStyle.body413M.copyWith(
                color: AppColor.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _result == null
              ? Container()
              : Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.accentRed10,
                      ),
                      child: Text(
                        _ourTeamScore != null ? _ourTeamScore.toString() : '',
                        style: AppTextStyle.h224B.copyWith(
                          color: AppColor.accentRed100,
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final matchStatus = _getMatchStatus();
    final isMatchStarted = matchStatus == MatchStatus.inProgress ||
        matchStatus == MatchStatus.startToday;
    final isMatchFinished = widget.finishedMatchStatus != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: widget.finishedMatchStatus != null
                        ? Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _result != null
                                      ? _getResultColor(_result!)
                                      : AppColor.textHint,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  _result ?? AppTextList.finished,
                                  style: AppTextStyle.caption113B1.copyWith(
                                    color: AppColor.graysWhite,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${widget.matchDate.month}월 ${widget.matchDate.day}일 ${DateFormat('E', 'ko_KR').format(widget.matchDate)} ${DateFormat('HH:mm').format(DateTime(0, 0, 0, widget.startTime.hour, widget.startTime.minute))}',
                                style: AppTextStyle.body315M.copyWith(
                                  color: AppColor.textPrimary,
                                ),
                              ),
                            ],
                          )
                        : MatchStatusWidget(
                            status: _getMatchStatus(),
                            matchDate: widget.matchDate,
                            startTime: widget.startTime,
                          ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: AppColor.textHint,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        widget.matchPlace,
                        style: AppTextStyle.body413M.copyWith(
                          color: AppColor.textHint,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              PositionChipWidget(positions: widget.positions),
            ],
          ),
          const SizedBox(height: 26),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeamIconSection(widget.team1Icon),
              Text(
                'VS',
                style: AppTextStyle.body120M.copyWith(
                  color: AppColor.textHint,
                ),
              ),
              _buildTeamIconSection(widget.team2Icon),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          if (isMatchStarted || isMatchFinished)
            AuthButton(
              onClick: () => _navigateToGameResultPage(context),
              icon: Container(),
              backgroundColor: AppColor.textSecondary,
              text: widget.btnTitle,
              textStyle: AppTextStyle.body315M
                  .copyWith(fontSize: 16, color: AppColor.graysWhite),
              borderColor: AppColor.textSecondary,
              textColor: AppColor.graysWhite,
              iconColor: AppColor.transparent,
              borderRadius: BorderRadius.circular(12),
              height: 36,
            ),
          const SizedBox(height: 16),
          const Divider(),
        ],
      ),
    );
  }
}
