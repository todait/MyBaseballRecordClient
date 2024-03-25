import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_style.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final DateTime? timeTitle;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final TextStyle? titleStyle;
  final TextStyle? timeStyle;
  final TabController tabController;
  final List<Widget> tabs;

  const AppBarWidget({
    super.key,
    this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.timeTitle,
    this.titleStyle,
    this.timeStyle,
    required this.tabController,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                trailingIcon != null ? trailingIcon! : const SizedBox(),
              ],
            ),
          ),
          const SizedBox(height: 26),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                leadingIcon != null ? leadingIcon! : const SizedBox(),
                title != null
                    ? Text(
                        title!,
                        style: titleStyle,
                      )
                    : const SizedBox(),
                const SizedBox(width: 16),
                timeTitle != null
                    ? Text(
                        DateFormat('M월 d일 E a h:mm', 'ko_KR')
                            .format(timeTitle!)
                            .replaceAll('AM', '오전')
                            .replaceAll('PM', '오후'),
                        style: timeStyle,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TabBar(
            controller: tabController,
            tabs: tabs,
            indicatorColor: AppColor.textPrimary,
            labelColor: AppColor.textPrimary,
            labelStyle: AppTextStyle.h318B,
            unselectedLabelColor: AppColor.textHint,
            unselectedLabelStyle: AppTextStyle.h418M,
            indicatorWeight: 2,
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: const EdgeInsets.only(bottom: 8),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(165);
}
