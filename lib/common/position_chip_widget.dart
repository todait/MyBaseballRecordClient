import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_style.dart';

class PositionChipWidget extends StatelessWidget {
  final List<String> positions;

  const PositionChipWidget({
    super.key,
    required this.positions,
  });

  Widget _buildPositionChip(String position) {
    if (position == '포지션 미정') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: AppColor.textHint,
            width: 0.2,
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.emergency,
              color: AppColor.accentRed100,
              size: 10,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              '포지션 미정',
              style: AppTextStyle.body413M.copyWith(
                color: AppColor.textHint,
              ),
            ),
          ],
        ),
      );
    } else {
      Color chipColor;
      String chipText;
      TextStyle textStyle;

      switch (position) {
        case '타자':
          chipColor = AppColor.additionalPurple10;
          chipText = '타자';
          textStyle = AppTextStyle.caption113B1
              .copyWith(color: AppColor.additionalPurple100);
          break;
        case '투수':
          chipColor = AppColor.additionalOrange10;
          chipText = '투수';
          textStyle = AppTextStyle.caption113B1
              .copyWith(color: AppColor.additionalOrange100);
          break;
        default:
          chipColor = AppColor.textHint;
          chipText = position;
          textStyle =
              AppTextStyle.caption113B1.copyWith(color: AppColor.textHint);
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        margin: const EdgeInsets.only(right: 4),
        decoration: BoxDecoration(
          color: chipColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          chipText,
          style: textStyle,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: positions.map(_buildPositionChip).toList(),
    );
  }
}
