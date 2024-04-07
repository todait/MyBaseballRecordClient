import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_style.dart';

class AuthTextInputWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final VoidCallback onClearPressed;

  final TextInputType keyboardType;
  final bool obscureText;
  final TextStyle? textStyle;
  final Function(String) onChanged;
  final VoidCallback onEditingComplete;
  final bool isEmailValid;

  const AuthTextInputWidget({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.onClearPressed,
    required this.keyboardType,
    this.obscureText = false,
    this.textStyle,
    required this.onChanged,
    required this.onEditingComplete,
    required this.isEmailValid,
  });

  @override
  Widget build(BuildContext context) {
    Color labelTextColor =
        isEmailValid ? AppColor.textPrimary : AppColor.primaryBlue1;

    return Container(
      height: 86,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColor.background246,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Text(
              labelText,
              style: AppTextStyle.body413M.copyWith(color: labelTextColor),
            ),
          ),
          Positioned(
            top: 16,
            bottom: -10,
            left: 0,
            right: -15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    onEditingComplete: onEditingComplete,
                    textInputAction: TextInputAction.next,
                    autocorrect: false,
                    cursorHeight: 24,
                    style: textStyle,
                    keyboardType: keyboardType,
                    obscureText: obscureText,
                    controller: controller,
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: AppTextStyle.body120M
                          .copyWith(color: AppColor.textPrimary20),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onClearPressed,
                  icon: const Icon(
                    Icons.cancel,
                    size: 20,
                    color: AppColor.textHint,
                  ),
                  splashColor: AppColor.transparent,
                  highlightColor: AppColor.transparent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
