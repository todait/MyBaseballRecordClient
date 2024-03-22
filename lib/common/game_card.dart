import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_color.dart';

class GameCard extends StatelessWidget {
  final String title;
  final int count;
  final String countTitle;
  final Widget icon;
  final String subTitle;
  final String btnTitle;
  final TextStyle? titleTextStyle;
  final TextStyle? subTextStyle;
  final TextStyle? btnTextStyle;
  final TextStyle? countTextStyle;

  const GameCard({
    super.key,
    required this.title,
    required this.count,
    required this.countTitle,
    required this.icon,
    required this.subTitle,
    required this.btnTitle,
    this.titleTextStyle,
    this.subTextStyle,
    this.btnTextStyle,
    this.countTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(title, style: titleTextStyle),
              const SizedBox(width: 203),
              Text('$count$countTitle  >', style: countTextStyle),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              icon,
              const SizedBox(width: 16),
              Text(subTitle, style: subTextStyle),
              const SizedBox(width: 71),
              Container(
                decoration: const BoxDecoration(
                  color: AppColor.primaryBlue3,
                ),
                child: Text(btnTitle, style: btnTextStyle),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
