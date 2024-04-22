import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_bottom_sheet.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_list.dart';
import 'package:my_baseball_record/common/app_text_style.dart';
import 'package:my_baseball_record/common/auth_button.dart';
import 'package:my_baseball_record/common/auth_text_input_widget.dart';
import 'package:my_baseball_record/common/const/data.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _emailError = "";
  String _passwordError = "";
  String _confirmPasswordError = "";

  bool _showPasswordInput = false;
  bool _showPasswordCheckInput = false;
  bool _showConfirmPasswordInput = false;
  bool _showFinalPassword = false;

  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _navigateToMainPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
    );
  }

  void _updateFinalPasswordStatus(String value) {
    setState(() {
      _showFinalPassword = value == _passwordController.text;
    });
  }

  bool _shouldShowImportantNotificationEmail() {
    return _emailError.isEmpty && !_showPasswordInput;
  }

  bool _shouldShowPasswordRequirements() {
    return _passwordError.isEmpty &&
        _showPasswordInput &&
        !_showConfirmPasswordInput;
  }

  bool _shouldShowConfirmPasswordError() {
    return _confirmPasswordError.isNotEmpty && !_showFinalPassword;
  }

  bool _shouldShowReenterPasswordPrompt() {
    return _confirmPasswordError.isEmpty &&
        _showConfirmPasswordInput &&
        !_showPasswordCheckInput &&
        !_showFinalPassword;
  }

  bool _isAllInputValid() {
    return _confirmPasswordError.isEmpty &&
        _emailError.isEmpty &&
        _passwordError.isEmpty;
  }

  Widget _buildEmailInfoText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _emailError.isNotEmpty
            ? Text(
                _emailError,
                style: AppTextStyle.caption213R.copyWith(
                  color: AppColor.accentRed100,
                ),
              )
            : _shouldShowImportantNotificationEmail()
                ? Text(
                    AppTextList.importantNotificationEmailText,
                    style: AppTextStyle.caption213R.copyWith(
                      color: AppColor.textHint,
                    ),
                  )
                : const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildPasswordInfoText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _passwordError.isNotEmpty
            ? Text(
                _passwordError,
                style: AppTextStyle.caption213R.copyWith(
                  color: AppColor.accentRed100,
                ),
              )
            : _shouldShowPasswordRequirements()
                ? Text(
                    AppTextList.passwordRequirementsText,
                    style: AppTextStyle.caption213R.copyWith(
                      color: AppColor.textHint,
                    ),
                  )
                : const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildConfirmPasswordInfoText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _shouldShowConfirmPasswordError()
            ? Text(
                _confirmPasswordError,
                style: AppTextStyle.caption213R.copyWith(
                  color: AppColor.accentRed100,
                ),
              )
            : _shouldShowReenterPasswordPrompt()
                ? Text(
                    AppTextList.reenterPasswordPrompt,
                    style: AppTextStyle.caption213R.copyWith(
                      color: AppColor.textHint,
                    ),
                  )
                : _showFinalPassword
                    ? Text(
                        AppTextList.passwordConfirmationSuccessText,
                        style: AppTextStyle.caption213R.copyWith(
                          color: AppColor.accentGreen100,
                        ),
                      )
                    : const SizedBox.shrink(),
      ],
    );
  }

  void _updateEmailStatus() {
    final email = _emailController.text;
    setState(() {
      _emailError =
          validateEmail(email) ? "" : AppTextList.criticalAlertEmailText;
      if (!_showPasswordInput && validateEmail(email)) {
        _showPasswordInput = true;
      }
    });
    _focusPasswordInputIfNeeded();
  }

  void _focusPasswordInputIfNeeded() {
    if (_showPasswordInput && _emailError.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      });
    }
  }

  void _updatePasswordStatus() {
    final password = _passwordController.text;
    setState(() {
      _passwordError =
          validatePassword(password) ? "" : AppTextList.passwordValidationText;
      if (!_showConfirmPasswordInput && _passwordError.isEmpty) {
        _showConfirmPasswordInput = true;
      }
    });
    _focusConfirmPasswordInputIfNeeded();
  }

  void _focusConfirmPasswordInputIfNeeded() {
    if (_showConfirmPasswordInput && _passwordError.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
      });
    }
  }

  void _updateConfirmPasswordStatus() {
    final confirmPassword = _confirmPasswordController.text;
    setState(() {
      _confirmPasswordError = confirmPassword != _passwordController.text
          ? AppTextList.passwordConfirmationPrompt
          : "";
      _showPasswordCheckInput = _confirmPasswordError.isEmpty;
    });
    if (_isAllInputValid()) {
      registerUser();
      _showModelSheet();
    }
  }

  void _showModelSheet() {
    AppBottomSheet.show(
      context,
      Text(
        AppTextList.lastStepMessage,
        style: AppTextStyle.h224B.copyWith(
          color: AppColor.textPrimary,
        ),
      ),
      Text(
        AppTextList.agreementNotice,
        style: AppTextStyle.body315M.copyWith(
          fontSize: 16,
          height: 1.5,
          color: AppColor.textSecondary,
        ),
      ),
      Text(
        AppTextList.personalInfoAgreement,
        style: AppTextStyle.body315M.copyWith(
          fontSize: 16,
          color: AppColor.textSecondary,
        ),
      ),
      Text(
        AppTextList.viewText,
        style: AppTextStyle.body315M.copyWith(
          color: AppColor.textHint,
          decoration: TextDecoration.underline,
          decorationColor: AppColor.textHint,
        ),
      ),
      AuthButton(
        height: 40,
        textStyle: AppTextStyle.body315M.copyWith(
          fontSize: 16,
          color: AppColor.textHint,
        ),
        onClick: () {
          Navigator.pop(context);
        },
        icon: Container(),
        backgroundColor: AppColor.background246,
        text: AppTextList.closeText,
        borderColor: AppColor.background246,
        textColor: AppColor.textHint,
        iconColor: AppColor.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      AuthButton(
        height: 40,
        textStyle: AppTextStyle.body315M.copyWith(
          fontSize: 16,
          color: AppColor.graysWhite,
        ),
        onClick: () {
          _navigateToMainPage();
        },
        icon: Container(),
        backgroundColor: AppColor.textPrimary,
        text: AppTextList.agreeAndSignUp,
        borderColor: AppColor.background246,
        textColor: AppColor.graysWhite,
        iconColor: AppColor.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  void registerUser() async {
    final dio = Dio();

    const emulatorIp = '10.0.2.2:4000';
    const simulatorIp = '127.0.0.1:4000';

    final ip = Platform.isIOS ? simulatorIp : emulatorIp;

    final email = _emailController.text;
    final password = _passwordController.text;

    final response = await dio.post(
      'http://$ip/api/register',
      data: {
        'email': email,
        'password': password,
      },
    );

    print(response.data);

    final accessToken = response.data['access_token'];
    await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                          style: AppTextStyle.h224B.copyWith(
                            color: AppColor.textPrimary,
                          ),
                        ),
                        Text(
                          AppTextList.divider,
                          style: AppTextStyle.h224B.copyWith(
                            color: AppColor.graysGray,
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.toggleAuthMode,
                          child: Text(
                            AppTextList.loginText,
                            style: AppTextStyle.h224B.copyWith(
                              color: AppColor.textPrimary20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    AuthTextInputWidget(
                      textStyle: AppTextStyle.body120M.copyWith(
                        color: AppColor.textPrimary,
                      ),
                      labelText: AppTextList.emailLabel,
                      hintText: AppTextList.emailLabel,
                      controller: _emailController,
                      onClearPressed: () => _emailController.clear(),
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {},
                      onEditingComplete: _updateEmailStatus,
                      isEmailValid: _showPasswordInput,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    _buildEmailInfoText(),
                    const SizedBox(
                      height: 8,
                    ),
                    if (_showPasswordInput)
                      AuthTextInputWidget(
                        focusNode: _passwordFocusNode,
                        obscureText: true,
                        textStyle: AppTextStyle.body120M.copyWith(
                          color: AppColor.textPrimary,
                        ),
                        labelText: AppTextList.passwordSetupText,
                        hintText: AppTextList.passwordText,
                        controller: _passwordController,
                        onClearPressed: () => _passwordController.clear(),
                        keyboardType: TextInputType.text,
                        onChanged: (String value) {},
                        onEditingComplete: _updatePasswordStatus,
                        isEmailValid: _showConfirmPasswordInput,
                      ),
                    const SizedBox(
                      height: 8,
                    ),
                    _buildPasswordInfoText(),
                    const SizedBox(
                      height: 8,
                    ),
                    if (_showConfirmPasswordInput)
                      AuthTextInputWidget(
                        focusNode: _confirmPasswordFocusNode,
                        obscureText: true,
                        textStyle: AppTextStyle.body120M.copyWith(
                          color: AppColor.textPrimary,
                        ),
                        labelText: AppTextList.passwordConfirmationText,
                        hintText: AppTextList.passwordText,
                        controller: _confirmPasswordController,
                        onClearPressed: () =>
                            _confirmPasswordController.clear(),
                        keyboardType: TextInputType.text,
                        onChanged: _updateFinalPasswordStatus,
                        onEditingComplete: _updateConfirmPasswordStatus,
                        isEmailValid: false,
                      ),
                    const SizedBox(
                      height: 8,
                    ),
                    _buildConfirmPasswordInfoText(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
