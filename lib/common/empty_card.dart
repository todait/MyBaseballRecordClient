import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_style.dart';
import 'package:my_baseball_record/common/auth_button.dart';

class EmptyCard extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final Widget icon;

  const EmptyCard({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 144),
      child: Column(
        children: [
          icon,
          const SizedBox(height: 20),
          Text(
            text1,
            style: AppTextStyle.h418M.copyWith(color: AppColor.textSecondary),
          ),
          const SizedBox(height: 10),
          Text(
            text2,
            style: AppTextStyle.body315M.copyWith(color: AppColor.textHint),
          ),
          const SizedBox(height: 48),
          AuthButton(
            onClick: () {},
            icon: Container(),
            backgroundColor: AppColor.primaryBlue3,
            text: text3,
            borderColor: AppColor.primaryBlue3,
            textStyle: AppTextStyle.body315M
                .copyWith(fontSize: 16, color: AppColor.primaryBlue2),
            textColor: AppColor.primaryBlue2,
            iconColor: AppColor.transparent,
            height: 36,
            borderRadius: BorderRadius.circular(16),
          ),
        ],
      ),
    );
  }
}
