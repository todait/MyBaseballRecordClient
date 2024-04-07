import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_color.dart';

class AppBottomSheet {
  static void show(BuildContext context, Widget text1, Widget text2,
      Widget text3, Widget text4, Widget button1, Widget button2) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: AppColor.graysWhite,
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              height: 388,
              width: 393,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  text1,
                  const SizedBox(height: 16),
                  text2,
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      const Icon(Icons.check, color: AppColor.primaryBlue2),
                      const SizedBox(width: 8),
                      text3,
                      const Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: text4,
                      ),
                    ],
                  ),
                  const SizedBox(height: 55),
                  button1,
                  const SizedBox(height: 10),
                  button2,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
