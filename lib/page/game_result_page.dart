import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_color.dart';
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.close),
                    Text('저장'),
                  ],
                ),
                const SizedBox(
                  height: 21,
                ),
                const Text(
                  '경기 득점 결과',
                ),
                const SizedBox(
                  height: 31,
                ),
                const Text(
                  '날짜',
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '위치',
                ),
                const SizedBox(
                  height: 60,
                ),
                const Row(
                  children: [
                    Text(
                      '우리팀',
                    ),
                    Text(
                      '경기결과(승 / 무 / 패)',
                    ),
                    Text(
                      '상대팀',
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
