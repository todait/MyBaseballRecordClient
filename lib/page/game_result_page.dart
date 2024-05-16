import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_list.dart';
import 'package:my_baseball_record/common/app_text_style.dart';

class GameResultPage extends StatelessWidget {
  const GameResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.close),
                    Text(
                      AppTextList.saveData,
                      style: AppTextStyle.body315M.copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 21,
                ),
                Text(
                  AppTextList.matchResult,
                  style: AppTextStyle.h224B.copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),
                const SizedBox(
                  height: 31,
                ),
                Text(
                  '5월 5일 일 • 오전 9시 40분',
                  style: AppTextStyle.body315M.copyWith(
                    fontSize: 16,
                    color: AppColor.textSecondary,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '화명 A 구장',
                  style: AppTextStyle.body413M.copyWith(
                    color: AppColor.textHint,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  color: AppColor.textHint,
                  thickness: 0.5,
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      AppTextList.ourTeam,
                      style: AppTextStyle.caption113B1.copyWith(
                        color: AppColor.primaryBlue1,
                      ),
                    ),
                    const Text(
                      '경기결과(승 / 무 / 패)',
                    ),
                    Text(
                      AppTextList.opponentTeam,
                      style: AppTextStyle.body413M.copyWith(
                        color: AppColor.textHint,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50.25,
                        vertical: 16,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColor.background246,
                      ),
                      child: Text(
                        '7',
                        style: AppTextStyle.hero48BB.copyWith(
                          color: AppColor.textPrimary,
                        ),
                      ),
                    ),
                    Text(
                      ':',
                      style: AppTextStyle.hero48BB.copyWith(
                        color: AppColor.textPrimary10,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50.25,
                        vertical: 16,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColor.graysWhite,
                      ),
                      child: Text(
                        '0',
                        style: AppTextStyle.hero48BB.copyWith(
                          color: AppColor.textPrimary10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      '팀이름',
                      style: AppTextStyle.body315M.copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                    Text(
                      '팀이름',
                      style: AppTextStyle.body315M.copyWith(
                        color: AppColor.textPrimary10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
