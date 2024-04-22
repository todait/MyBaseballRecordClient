import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_color.dart';

class AppBottomSheet {
  static void show(BuildContext context, Widget text1, Widget text2,
      Widget text3, Widget text4, Widget button1, Widget button2) {
    final modalHeight = MediaQuery.of(context).size.height * 0.46;

    double getHeight(double size) {
      return modalHeight * (size / modalHeight);
    }

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: AppColor.graysWhite,
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(
              24,
            ),
            child: SizedBox(
              height: modalHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getHeight(24),
                  ),
                  text1,
                  SizedBox(
                    height: getHeight(16),
                  ),
                  text2,
                  SizedBox(
                    height: getHeight(40),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.check,
                        color: AppColor.primaryBlue2,
                      ),
                      SizedBox(
                        width: getHeight(8),
                      ),
                      text3,
                      const Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: text4,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getHeight(55),
                  ),
                  button1,
                  SizedBox(
                    height: getHeight(10),
                  ),
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
