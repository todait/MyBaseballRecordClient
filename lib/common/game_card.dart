import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/auth_button.dart';

class GameCard extends StatelessWidget {
  final String? sectionTitle;
  final int? totalNumber;
  final DateTime matchDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String position;
  final String matchPlace;
  final String teamIcon;
  final String teamName;
  final String btnTitle;

  final TextStyle? sectionTitleStyle;
  final TextStyle? totalNumberStyle;
  final TextStyle? statusChipStyle;
  final TextStyle? timeStyle;
  final TextStyle? positionStyle;
  final TextStyle? matchPlaceStyle;
  final TextStyle? teamNameStyle;
  final TextStyle? btnTitleStyle;

  const GameCard({
    super.key,
    this.sectionTitle,
    this.totalNumber,
    required this.matchDate,
    required this.startTime,
    required this.endTime,
    required this.position,
    required this.matchPlace,
    required this.teamIcon,
    required this.teamName,
    required this.btnTitle,
    this.sectionTitleStyle,
    this.totalNumberStyle,
    this.statusChipStyle,
    this.timeStyle,
    this.positionStyle,
    this.matchPlaceStyle,
    this.teamNameStyle,
    this.btnTitleStyle,
  });

  String getMatchStatus(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final diff = matchDate.difference(today).inDays;

    final matchStartDateTime = DateTime(matchDate.year, matchDate.month,
        matchDate.day, startTime.hour, startTime.minute);
    final matchEndDateTime = DateTime(matchDate.year, matchDate.month,
        matchDate.day, endTime.hour, endTime.minute);

    if (matchDate.isBefore(today)) {
      return '';
    } else if (matchDate == today) {
      if (now.isAfter(matchStartDateTime) && now.isBefore(matchEndDateTime)) {
        return '진행중';
      } else {
        return '${_formatTime(startTime)} 시작';
      }
    } else if (matchDate == tomorrow) {
      return '내일 ${DateFormat('M월 d일 E', 'ko_KR').format(matchDate)} • ${_formatTime(startTime)}';
    } else if (diff <= 100) {
      return 'D-$diff ${DateFormat('M월 d일 E', 'ko_KR').format(matchDate)} • ${_formatTime(startTime)}';
    } else {
      return '${DateFormat('M월 d일 E', 'ko_KR').format(matchDate)} • ${_formatTime(startTime)}';
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour;
    final minute = time.minute;
    final amPm = hour < 12 ? '오전' : '오후';
    final formattedHour = hour > 12 ? hour - 12 : hour;
    final formattedMinute = minute.toString().padLeft(2, '0');
    return '$amPm $formattedHour시 $formattedMinute분';
  }

  @override
  Widget build(BuildContext context) {
    final matchStatus = getMatchStatus(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 36,
        horizontal: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionTitle ?? '', style: sectionTitleStyle),
              Text(
                totalNumber != null ? '$totalNumber >' : '',
                style: totalNumberStyle,
              ),
            ],
          ),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(matchStatus, style: statusChipStyle),
                  const SizedBox(width: 8),
                ],
              ),
              const SizedBox(height: 4),
              Text(matchPlace, style: matchPlaceStyle),
            ],
          ),
          const SizedBox(height: 26),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeamInfo(teamIcon, teamName),
              Text(position, style: positionStyle),
            ],
          ),
          const SizedBox(height: 30),
          AuthButton(
            onClick: () {},
            icon: Container(),
            backgroundColor: AppColor.textSecondary,
            text: btnTitle,
            textStyle: btnTitleStyle,
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

  Widget _buildTeamInfo(String teamIcon, String teamName) {
    return Row(
      children: [
        Image.network(
          teamIcon,
          scale: 1.2,
        ),
        const SizedBox(width: 8),
        Text(teamName, style: teamNameStyle),
      ],
    );
  }
}
