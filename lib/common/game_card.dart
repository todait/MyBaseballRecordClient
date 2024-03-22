import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_color.dart';

class GameCard extends StatelessWidget {
  final String title;
  final int count;
  final String countTitle;

  final String subTitle;
  final String btnTitle;

  final TextStyle? titleTextStyle;
  final TextStyle? subTitleStyle;
  final TextStyle? btnTitleStyle;
  final TextStyle? countTitleStyle;

  const GameCard({
    super.key,
    required this.title,
    required this.count,
    required this.countTitle,
    required this.subTitle,
    required this.btnTitle,
    this.titleTextStyle,
    this.subTitleStyle,
    this.btnTitleStyle,
    this.countTitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: titleTextStyle),
              Text('$count$countTitle  >', style: countTitleStyle),
            ],
          ),
          const SizedBox(height: 34),
          Column(
            children: [
              Text(
                subTitle,
                style: subTitleStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              Container(
                height: 44,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.primaryBlue3,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    btnTitle,
                    style: btnTitleStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
