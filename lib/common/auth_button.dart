import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/pressed_button.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onClick;
  final Widget icon;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;
  final String text;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? textStyle;
  final double? height;

  const AuthButton({
    super.key,
    required this.onClick,
    required this.icon,
    required this.backgroundColor,
    required this.text,
    required this.borderColor,
    required this.textColor,
    required this.iconColor,
    this.borderRadius,
    this.textStyle,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return PressedButton(
      borderColor: borderColor,
      backgroundColor: backgroundColor,
      onTap: onClick,
      borderWidth: 0,
      borderRadius: borderRadius,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 9.0,
        ),
        child: SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconTheme(
                  data: const IconThemeData(
                    color: AppColor.graysBlack,
                  ),
                  child: icon),
              const SizedBox(width: 8),
              Text(
                text,
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
