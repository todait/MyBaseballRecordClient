import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_list.dart';
import 'package:my_baseball_record/common/app_text_style.dart';
import 'package:my_baseball_record/common/auth_button.dart';
import 'package:my_baseball_record/common/match_status_widget.dart';
import 'package:my_baseball_record/common/position_chip_widget.dart';
import 'package:my_baseball_record/data/repository/game_model.dart';
import 'package:my_baseball_record/page/game_result_page.dart';

class GameCard extends StatefulWidget {
  final GameModel gameModel;

  const GameCard({
    super.key,
    required this.gameModel,
  });

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  void _navigateToGameResultPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameResultPage(gameModel: widget.gameModel),
      ),
    );

    if (result != null) {
      setState(() {
        widget.gameModel.updateResult(
          ourTeamScore: result['ourTeamScore'],
          opponentTeamScore: result['opponentTeamScore'],
          result: result['result'],
          isFinished: true,
        );
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
    final diff = widget.gameModel.matchDate.difference(today).inDays;
    final matchStartDateTime = DateTime(
        widget.gameModel.matchDate.year,
        widget.gameModel.matchDate.month,
        widget.gameModel.matchDate.day,
        widget.gameModel.startTime.hour,
        widget.gameModel.startTime.minute);
    final matchEndDateTime = matchStartDateTime.add(const Duration(hours: 2));

    if (widget.gameModel.matchDate.isBefore(today)) {
      return MatchStatus.notStarted;
    } else if (widget.gameModel.matchDate == today &&
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

  Widget _buildTeamIconSection(String teamName, String? teamIcon, int? score) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTeamIcon(teamIcon),
          SizedBox(
            width: 100,
            child: Text(
              teamName,
              style: AppTextStyle.body413M.copyWith(
                color: AppColor.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (widget.gameModel.isFinished && score != null)
            Column(
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
                    score.toString(),
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
    final isMatchFinished = widget.gameModel.isFinished;

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
                    child: widget.gameModel.isFinished
                        ? Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getResultColor(
                                      widget.gameModel.result ?? ''),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  widget.gameModel.result ??
                                      AppTextList.finished,
                                  style: AppTextStyle.caption113B1.copyWith(
                                    color: AppColor.graysWhite,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${widget.gameModel.matchDate.month}월 ${widget.gameModel.matchDate.day}일 ${DateFormat('E', 'ko_KR').format(widget.gameModel.matchDate)} ${widget.gameModel.startTime.format(context)}',
                                style: AppTextStyle.body315M.copyWith(
                                  color: AppColor.textPrimary,
                                ),
                              ),
                            ],
                          )
                        : MatchStatusWidget(
                            status: _getMatchStatus(),
                            matchDate: widget.gameModel.matchDate,
                            startTime: widget.gameModel.startTime,
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
                        widget.gameModel.matchPlace,
                        style: AppTextStyle.body413M.copyWith(
                          color: AppColor.textHint,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              PositionChipWidget(
                  positions: widget.gameModel.positions ?? ['포지션 미정']),
            ],
          ),
          const SizedBox(height: 26),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeamIconSection(
                widget.gameModel.team1Name,
                widget.gameModel.team1Icon,
                widget.gameModel.ourTeamScore,
              ),
              Text(
                'VS',
                style: AppTextStyle.body120M.copyWith(
                  color: AppColor.textHint,
                ),
              ),
              _buildTeamIconSection(
                widget.gameModel.team2Name,
                widget.gameModel.team2Icon,
                widget.gameModel.opponentTeamScore,
              ),
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
              text: AppTextList.putResult,
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
