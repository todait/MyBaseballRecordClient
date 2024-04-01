import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_style.dart';
import 'package:my_baseball_record/common/pressed_button.dart';

class StickyBottomButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final bool enabled;

  const StickyBottomButton({
    super.key,
    required this.text,
    required this.onClick,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    const greyBtnColor = AppColor.textPrimary20;

    Color buttonColor = enabled ? AppColor.textPrimary : greyBtnColor;

    return PressedButton(
      borderRadius: BorderRadius.circular(0),
      borderColor: AppColor.graysWhite,
      backgroundColor: buttonColor,
      onTap: enabled ? onClick : () {},
      borderWidth: 0,
      child: Container(
        height: 62,
        alignment: Alignment.center,
        child: Text(
          text,
          style: AppTextStyle.body315M.copyWith(
            color: AppColor.graysWhite,
          ),
        ),
      ),
    );
  }
}
