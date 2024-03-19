import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_baseball_record/common/app_text_list.dart';
import 'package:my_baseball_record/common/app_text_style.dart';
import 'package:my_baseball_record/common/auth_button.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/page/email_auth_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.graysBlack,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 67),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTextList.mainText,
                  style: AppTextStyle.hero48BB
                      .copyWith(color: AppColor.graysWhite),
                ),
                Text(AppTextList.subText,
                    style: AppTextStyle.h418M
                        .copyWith(color: AppColor.graysWhite)),
                const SizedBox(height: 233),
                AuthButton(
                  onClick: () {},
                  icon: const FaIcon(FontAwesomeIcons.apple),
                  backgroundColor: AppColor.graysWhite,
                  text: AppTextList.appleText,
                  borderColor: AppColor.transparent,
                  textColor: AppColor.graysBlack,
                  iconColor: AppColor.transparent,
                ),
                const SizedBox(height: 16),
                AuthButton(
                  onClick: () {},
                  icon: Image.asset('assets/icon/kakao_logo.png'),
                  backgroundColor: AppColor.yellowColor,
                  text: AppTextList.kakaoText,
                  borderColor: AppColor.transparent,
                  textColor: AppColor.graysBlack,
                  iconColor: AppColor.transparent,
                ),
                const SizedBox(height: 16),
                AuthButton(
                  onClick: () {},
                  icon: Image.asset('assets/icon/naver_logo.png'),
                  backgroundColor: AppColor.greenColor,
                  text: AppTextList.naverText,
                  textColor: AppColor.graysWhite,
                  borderColor: AppColor.graysWhite,
                  iconColor: AppColor.transparent,
                ),
                const SizedBox(height: 16),
                AuthButton(
                  onClick: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const EmailAuthPage(
                              isRegistering: true,
                            )));
                  },
                  icon: Image.asset(
                    'assets/icon/at_logo.png',
                    scale: 0.9,
                  ),
                  backgroundColor: AppColor.graysBlack,
                  borderColor: AppColor.graysWhite,
                  text: AppTextList.emailText,
                  textColor: AppColor.graysWhite,
                  iconColor: AppColor.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
