import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_list.dart';
import 'package:my_baseball_record/common/app_text_style.dart';
import 'package:my_baseball_record/common/auth_text_input_widget.dart';
import 'package:my_baseball_record/common/sticky_bottom_button.dart';
import 'package:my_baseball_record/common/util/validate.dart';
import 'package:my_baseball_record/page/find_password_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback toggleAuthMode;
  final String? email;
  final bool showToast;

  const LoginPage({
    super.key,
    required this.toggleAuthMode,
    this.email,
    this.showToast = false,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _emailError = "";
  String _passwordError = "";

  bool _checkEmail = false;
  bool _checkPassword = true;
  bool _isInputValid = false;

  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.email);
    if (widget.showToast) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showToast(context);
      });
    }
  }

  void showToast(BuildContext context) {
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
      width: 350,
      padding: const EdgeInsets.symmetric(vertical: 24.5, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColor.textPrimary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check,
            color: AppColor.accentGreen100,
          ),
          const SizedBox(width: 16),
          Text(
            AppTextList.passwordResetEmailResent,
            style: AppTextStyle.body315M.copyWith(color: AppColor.graysWhite),
          ),
        ],
      ),
    );

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            bottom: keyboardHeight + 320,
            left: 16,
            right: 16,
            child: child,
          );
        });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _checkEmailStatus() {
    final email = _emailController.text;
    setState(() {
      _emailError =
          validateEmail(email) ? "" : AppTextList.emailNotFoundErrorMessage;
      _checkEmail = _emailError.isEmpty;
      _checkPassword = !_checkEmail;
    });
    if (_checkEmail) {
      FocusScope.of(context).requestFocus(_passwordFocusNode);
    }
  }

  void _checkPasswordStatus() {
    final password = _passwordController.text;
    setState(() {
      _passwordError = validatePassword(password)
          ? ""
          : AppTextList.passwordNotFoundErrorMessage;
      _checkPassword = _passwordError.isEmpty;
      _isInputValid = _checkPassword;
    });
  }

  void _navigateToFindPasswordPage() {
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
                    controller: _emailController,
                    onClearPressed: () => _emailController.clear(),
                    keyboardType: TextInputType.text,
                    onChanged: (String value) {},
                    onEditingComplete: _checkEmailStatus,
                    isEmailValid: _checkEmail,
                  ),
                  const SizedBox(height: 8),
                  if (_emailError.isNotEmpty)
                    Text(
                      _emailError,
                      style: AppTextStyle.caption213R
                          .copyWith(color: AppColor.accentRed100),
                    ),
                  const SizedBox(height: 11),
                  AuthTextInputWidget(
                    focusNode: _passwordFocusNode,
                    obscureText: true,
                    textStyle: AppTextStyle.body120M
                        .copyWith(color: AppColor.textPrimary),
                    labelText: AppTextList.passwordText,
                    hintText: AppTextList.passwordText,
                    controller: _passwordController,
                    onClearPressed: () => _passwordController.clear(),
                    keyboardType: TextInputType.text,
                    onChanged: (String value) {},
                    onEditingComplete: _checkPasswordStatus,
                    isEmailValid: _checkPassword,
                  ),
                  const SizedBox(height: 8),
                  if (_passwordError.isNotEmpty)
                    Text(
                      _passwordError,
                      style: AppTextStyle.caption213R
                          .copyWith(color: AppColor.accentRed100),
                    ),
                  const SizedBox(height: 11),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: _navigateToFindPasswordPage,
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
                enabled: _isInputValid,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
