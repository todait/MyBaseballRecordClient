import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_list.dart';
import 'package:my_baseball_record/common/app_text_style.dart';
import 'package:my_baseball_record/common/auth_text_input_widget.dart';
import 'package:my_baseball_record/common/util/validate.dart';
import 'package:my_baseball_record/page/main_page.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback toggleAuthMode;

  const RegisterPage({
    super.key,
    required this.toggleAuthMode,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  bool showPasswordInput = false;
  bool showPasswordCheckInput = false;
  bool showConfirmPasswordInput = false;
  bool showFinalPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void updateEmailStatus() {
    final email = emailController.text;
    if (!validateEmail(email)) {
      setState(() {
        emailError = AppTextList.criticalAlertEmailText;
        showPasswordInput = false;
      });
    } else {
      setState(() {
        emailError = null;
        showPasswordInput = true;
      });
      FocusScope.of(context).nextFocus();
    }
  }

  void updatePasswordStatus() {
    final password = passwordController.text;
    if (!validatePassword(password)) {
      setState(() {
        passwordError = AppTextList.passwordValidationText;
        showConfirmPasswordInput = false;
      });
    } else {
      setState(() {
        passwordError = null;
        showConfirmPasswordInput = true;
      });
      FocusScope.of(context).nextFocus();
    }
  }

  void updateConfirmPasswordStatus() {
    final confirmPassword = confirmPasswordController.text;
    if (confirmPassword != passwordController.text) {
      setState(() {
        confirmPasswordError = AppTextList.passwordConfirmationPrompt;
        showPasswordCheckInput = false;
      });
    } else {
      setState(() {
        confirmPasswordError = null;
        showPasswordCheckInput = true;
      });
      FocusScope.of(context).nextFocus();
      registerUser();
      navigateToMainPage();
    }
  }

  void navigateToMainPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const MainPage()));
  }

  void registerUser() async {
    final dio = Dio();

    const emulatorIp = '10.0.2.2:4000';
    const simulatorIp = '127.0.0.1:4000';

    final ip = Platform.isIOS ? simulatorIp : emulatorIp;

    final email = emailController.text;
    final password = passwordController.text;

    final response = await dio.post(
      'http://$ip/api/register',
      data: {
        'email': email,
        'password': password,
      },
    );

    print(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        AppTextList.registerText,
                        style: AppTextStyle.h224B
                            .copyWith(color: AppColor.textPrimary),
                      ),
                      Text(
                        AppTextList.divider,
                        style: AppTextStyle.h224B
                            .copyWith(color: AppColor.graysGray),
                      ),
                      GestureDetector(
                        onTap: widget.toggleAuthMode,
                        child: Text(
                          AppTextList.loginText,
                          style: AppTextStyle.h224B
                              .copyWith(color: AppColor.textPrimary20),
                        ),
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
                    onEditingComplete: updateEmailStatus,
                    isEmailValid: showPasswordInput,
                  ),
                  const SizedBox(height: 8),
                  if (emailError != null)
                    Text(
                      emailError!,
                      style: AppTextStyle.caption213R
                          .copyWith(color: AppColor.accentRed100),
                    ),
                  if (emailError == null && !showPasswordInput)
                    Text(
                      AppTextList.importantNotificationEmailText,
                      style: AppTextStyle.caption213R
                          .copyWith(color: AppColor.textHint),
                    ),
                  const Visibility(
                    visible: true,
                    child: SizedBox(height: 8),
                  ),
                  if (showPasswordInput)
                    AuthTextInputWidget(
                      obscureText: true,
                      textStyle: AppTextStyle.body120M
                          .copyWith(color: AppColor.textPrimary),
                      labelText: AppTextList.passwordSetupText,
                      hintText: AppTextList.passwordText,
                      controller: passwordController,
                      onClearPressed: () => passwordController.clear(),
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {},
                      onEditingComplete: updatePasswordStatus,
                      isEmailValid: showConfirmPasswordInput,
                    ),
                  const SizedBox(height: 8),
                  if (passwordError != null)
                    Text(
                      passwordError!,
                      style: AppTextStyle.caption213R
                          .copyWith(color: AppColor.accentRed100),
                    ),
                  if (passwordError == null &&
                      showPasswordInput &&
                      !showConfirmPasswordInput)
                    Text(
                      AppTextList.passwordRequirementsText,
                      style: AppTextStyle.caption213R
                          .copyWith(color: AppColor.textHint),
                    ),
                  const Visibility(
                    visible: true,
                    child: SizedBox(height: 8),
                  ),
                  if (showConfirmPasswordInput)
                    AuthTextInputWidget(
                      obscureText: true,
                      textStyle: AppTextStyle.body120M
                          .copyWith(color: AppColor.textPrimary),
                      labelText: AppTextList.passwordConfirmationText,
                      hintText: AppTextList.passwordText,
                      controller: confirmPasswordController,
                      onClearPressed: () => confirmPasswordController.clear(),
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {},
                      onEditingComplete: updateConfirmPasswordStatus,
                      isEmailValid: showFinalPassword,
                    ),
                  const SizedBox(height: 8),
                  if (confirmPasswordError != null)
                    Text(
                      confirmPasswordError!,
                      style: AppTextStyle.caption213R
                          .copyWith(color: AppColor.accentRed100),
                    ),
                  if (confirmPasswordError == null &&
                      showConfirmPasswordInput &&
                      !showPasswordCheckInput)
                    Text(
                      AppTextList.passwordRequirementsText,
                      style: AppTextStyle.caption213R
                          .copyWith(color: AppColor.textHint),
                    ),
                  if (passwordController.text ==
                          confirmPasswordController.text &&
                      confirmPasswordError == null &&
                      confirmPasswordController.text.isNotEmpty)
                    Text(
                      AppTextList.passwordConfirmationSuccessText,
                      style: AppTextStyle.caption213R
                          .copyWith(color: AppColor.accentGreen100),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
