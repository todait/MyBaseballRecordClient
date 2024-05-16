import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_style.dart';
import 'package:my_baseball_record/common/auth_button.dart';
import 'package:my_baseball_record/common/match_status_widget.dart';

class GameCard extends StatelessWidget {
  final int? totalNumber;
  final DateTime matchDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<String> positions;
  final String matchPlace;
  final String team1Icon;
  final String team1Name;
  final String team2Icon;
  final String team2Name;
  final String btnTitle;

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
    required this.endTime,
    this.positions = const ['포지션 미정'],
    required this.matchPlace,
    required this.team1Icon,
    required this.team1Name,
    required this.team2Icon,
    required this.team2Name,
    required this.btnTitle,
    this.totalNumberStyle,
    this.statusChipStyle,
    this.timeStyle,
    this.positionStyle,
    this.matchPlaceStyle,
    this.teamNameStyle,
    this.btnTitleStyle,
  });

  MatchStatus _getMatchStatus() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final diff = matchDate.difference(today).inDays;
    final matchStartDateTime = DateTime(matchDate.year, matchDate.month,
        matchDate.day, startTime.hour, startTime.minute);
    final matchEndDateTime = DateTime(matchDate.year, matchDate.month,
        matchDate.day, endTime.hour, endTime.minute);

    if (matchDate.isBefore(today)) {
      return MatchStatus.notStarted;
    } else if (matchDate == today &&
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

  List<Widget> _getPositionChips(List<String> positions) {
    return positions.map((position) {
      if (position == "포지션 미정") {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: AppColor.textHint,
              width: 0.2,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.emergency,
                color: AppColor.accentRed100,
                size: 10,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                "포지션 미정",
                style: AppTextStyle.body413M.copyWith(
                  color: AppColor.textHint,
                ),
              ),
            ],
          ),
        );
      } else {
        Color chipColor;
        String chipText;
        TextStyle textStyle;

        switch (position) {
          case "타자":
            chipColor = AppColor.additionalPurple10;
            chipText = "타자";
            textStyle = AppTextStyle.caption113B1
                .copyWith(color: AppColor.additionalPurple100);
            break;
          case "투수":
            chipColor = AppColor.additionalOrange10;
            chipText = "투수";
            textStyle = AppTextStyle.caption113B1
                .copyWith(color: AppColor.additionalOrange100);
            break;
          default:
            chipColor = AppColor.textHint;
            chipText = position;
            textStyle =
                AppTextStyle.caption113B1.copyWith(color: AppColor.textHint);
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            color: chipColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            chipText,
            style: textStyle,
          ),
        );
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final matchStatus = _getMatchStatus();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      MatchStatusWidget(
                        status: matchStatus,
                        matchDate: matchDate,
                        startTime: startTime,
                        endTime: endTime,
                      ),
                    ],
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
                        matchPlace,
                        style: AppTextStyle.body413M.copyWith(
                          color: AppColor.textHint,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Wrap(
                children: _getPositionChips(positions),
              )
            ],
          ),
          const SizedBox(height: 26),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/icon/Polygon 2.png'),
                  Image.network(
                    team1Icon,
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    team1Name,
                    style: AppTextStyle.body413M.copyWith(
                      color: AppColor.textSecondary,
                    ),
                  ),
                ],
              ),
              Text(
                'VS',
                style: AppTextStyle.body120M.copyWith(
                  color: AppColor.textHint,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/icon/Polygon 1.png'),
                  Image.network(
                    team2Icon,
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    team2Name,
                    style: AppTextStyle.body413M.copyWith(
                      color: AppColor.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          AuthButton(
            onClick: () {},
            icon: Container(),
            backgroundColor: AppColor.textSecondary,
            text: btnTitle,
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
