import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_style.dart';
import 'package:my_baseball_record/common/auth_button.dart';

class GameCard extends StatelessWidget {
  final String? sectionTitle;
  final int? totalNumber;
  final String statusChip;
  final String time;
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
    required this.statusChip,
    required this.time,
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

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(statusChip, style: statusChipStyle),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        time,
                        style: timeStyle,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(matchPlace, style: matchPlaceStyle),
                    ],
                  ),
                ],
              ),
              Text(position, style: positionStyle),
            ],
          ),
          const SizedBox(
            height: 26,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeamInfo(teamIcon, teamName),
              const Text('VS'),
              _buildTeamInfo(teamIcon, teamName),
            ],
          ),
          const SizedBox(
            height: 30,
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
          const SizedBox(
            height: 16,
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildTeamInfo(String teamIcon, String teamName) {
    return Column(
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
