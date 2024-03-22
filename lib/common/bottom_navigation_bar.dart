import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_list.dart';
import 'package:my_baseball_record/common/app_text_style.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabIcon;

  const BottomNavigationBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onTabIcon,
  });

  @override
  Widget build(BuildContext context) {
    const Color selectedColor = AppColor.textPrimary;
    const Color unselectedColor = AppColor.textHint;

    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: AppColor.graysWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.graysGray),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.sports_baseball),
                  onPressed: () => onTabIcon(0),
                  color: selectedIndex == 0 ? selectedColor : unselectedColor,
                ),
                Text(
                  AppTextList.mainTitle,
                  style: AppTextStyle.body413M.copyWith(
                      height: 0.2,
                      color:
                          selectedIndex == 0 ? selectedColor : unselectedColor),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.sticky_note_2),
                  onPressed: () => onTabIcon(1),
                  color: selectedIndex == 1 ? selectedColor : unselectedColor,
                ),
                Text(
                  AppTextList.recordTitle,
                  style: AppTextStyle.body413M.copyWith(
                      height: 0.2,
                      color:
                          selectedIndex == 1 ? selectedColor : unselectedColor),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.account_circle),
                  onPressed: () => onTabIcon(2),
                  color: selectedIndex == 2 ? selectedColor : unselectedColor,
                ),
                Text(
                  AppTextList.profileTitle,
                  style: AppTextStyle.body413M.copyWith(
                      height: 0.2,
                      color:
                          selectedIndex == 2 ? selectedColor : unselectedColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
