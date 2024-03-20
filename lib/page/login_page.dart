import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_list.dart';
import 'package:my_baseball_record/common/app_text_style.dart';
import 'package:my_baseball_record/common/auth_text_input_widget.dart';
import 'package:my_baseball_record/common/sticky_bottom_button.dart';
import 'package:my_baseball_record/common/util/validate.dart';
import 'package:my_baseball_record/page/find_password_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback toggleAuthMode;
  final String? email;

  const LoginPage({
    super.key,
    required this.toggleAuthMode,
    this.email,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 임시로 final 뺌
  TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  bool checkEmail = false;
  bool checkPassword = true;
  bool isInputValid = false;

  FocusNode passwordFocusNode = FocusNode();

  // imsi
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.email ?? '');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void checkEmailStatus() {
    final email = emailController.text;
    if (!validateEmail(email)) {
      setState(() {
        emailError = AppTextList.emailNotFoundErrorMessage;
        checkEmail = false;
      });
    } else {
      setState(() {
        emailError = null;
        checkEmail = true;
        checkPassword = false;
      });
      FocusScope.of(context).requestFocus(passwordFocusNode);
    }
  }

  void checkPasswordStatus() {
    final password = passwordController.text;
    if (!validatePassword(password)) {
      setState(() {
        passwordError = AppTextList.passwordNotFoundErrorMessage;
        checkPassword = false;
        isInputValid = false;
      });
    } else {
      setState(() {
        passwordError = null;
        checkPassword = false;
        isInputValid = true;
      });
    }
  }

  void navigateToFindPasswordPage() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const FindPasswordPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: widget.toggleAuthMode,
                        child: Text(
                          AppTextList.registerText,
                          style: AppTextStyle.h224B
                              .copyWith(color: AppColor.textPrimary20),
                        ),
                      ),
                      Text(
                        AppTextList.divider,
                        style: AppTextStyle.h224B
                            .copyWith(color: AppColor.graysGray),
                      ),
                      Text(
                        AppTextList.loginText,
                        style: AppTextStyle.h224B
                            .copyWith(color: AppColor.textPrimary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  AuthTextInputWidget(
                    textStyle: AppTextStyle.body120M
                        .copyWith(color: AppColor.textPrimary),
                    labelText: AppTextList.emailLabel,
                    hintText: AppTextList.emailLabel,
                    controller: emailController,
                    onClearPressed: () => emailController.clear(),
                    keyboardType: TextInputType.text,
                    onChanged: (String value) {},
                    onEditingComplete: checkEmailStatus,
                    isEmailValid: checkEmail,
                  ),
                  const SizedBox(height: 8),
                  if (emailError != null)
                    Text(
                      emailError!,
                      style: AppTextStyle.caption213R
                          .copyWith(color: AppColor.accentRed100),
                    ),
                  const SizedBox(height: 11),
                  AuthTextInputWidget(
                    focusNode: passwordFocusNode,
                    obscureText: true,
                    textStyle: AppTextStyle.body120M
                        .copyWith(color: AppColor.textPrimary),
                    labelText: AppTextList.passwordText,
                    hintText: AppTextList.passwordText,
                    controller: passwordController,
                    onClearPressed: () => passwordController.clear(),
                    keyboardType: TextInputType.text,
                    onChanged: (String value) {},
                    onEditingComplete: checkPasswordStatus,
                    isEmailValid: checkPassword,
                  ),
                  const SizedBox(height: 8),
                  if (passwordError != null)
                    Text(
                      passwordError!,
                      style: AppTextStyle.caption213R
                          .copyWith(color: AppColor.accentRed100),
                    ),
                  const SizedBox(height: 11),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: navigateToFindPasswordPage,
                        child: Text(
                          AppTextList.passwordFindText,
                          style: AppTextStyle.caption113B1
                              .copyWith(color: AppColor.textHint),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: StickyBottomButton(
                text: AppTextList.loginText,
                onClick: () {},
                enabled: isInputValid,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
