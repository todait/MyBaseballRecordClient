import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_list.dart';
import 'package:my_baseball_record/common/app_text_style.dart';
import 'package:my_baseball_record/common/auth_button.dart';
import 'package:my_baseball_record/page/email_auth_page.dart';

class AuthDialog extends StatelessWidget {
  final String email;

  const AuthDialog({
    super.key,
    required this.email,
  });

  void navigateToLoginPage(BuildContext context, bool isRegistering) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EmailAuthPage(
              isRegistering: isRegistering,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.background246,
      insetPadding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
      child: Container(
        height: 306,
        decoration: BoxDecoration(
          color: AppColor.background246,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.only(top: 32, left: 24, right: 24, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppTextList.passwordResetSentMessage,
              style: AppTextStyle.h318B.copyWith(color: AppColor.textPrimary),
            ),
            const SizedBox(height: 32),
            Text(
              AppTextList.checkInboxAndLoginImmediatelyAfterPasswordChange,
              style: AppTextStyle.body315M.copyWith(
                fontSize: 16,
                color: AppColor.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              email,
              style: AppTextStyle.body315M
                  .copyWith(fontSize: 16, color: AppColor.primaryBlue2),
            ),
            const SizedBox(height: 24),
            AuthButton(
              onClick: () {
                navigateToLoginPage(context, false);
              },
              icon: Container(),
              backgroundColor: AppColor.primaryBlue2,
              text: AppTextList.loginAgain,
              borderColor: AppColor.background246,
              textColor: AppColor.graysWhite,
              iconColor: AppColor.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            AuthButton(
              onClick: () {
                navigateToLoginPage(context, false);
              },
              icon: Container(),
              backgroundColor: AppColor.background246,
              text: AppTextList.resendEmail,
              borderColor: AppColor.background246,
              textColor: AppColor.textHint,
              iconColor: AppColor.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
      ),
    );
  }
}
