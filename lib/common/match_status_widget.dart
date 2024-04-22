import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_style.dart';

enum MatchStatus {
  notStarted,
  inProgress,
  startToday,
  tomorrow,
  upcoming,
  future,
}

class MatchStatusWidget extends StatelessWidget {
  final MatchStatus status;
  final DateTime matchDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const MatchStatusWidget({
    super.key,
    required this.status,
    required this.matchDate,
    required this.startTime,
    required this.endTime,
  });

  Widget _buildInProgressWidget() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColor.primaryBlue3,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Icon(
                  Icons.circle,
                  color: AppColor.primaryBlue1,
                  size: 10,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  '진행중',
                  style: AppTextStyle.caption113B1.copyWith(
                    color: AppColor.primaryBlue1,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          _formatTime(startTime),
          style: AppTextStyle.body315M.copyWith(
            fontSize: 16,
            color: AppColor.primaryBlue1,
          ),
        ),
      ],
    );
  }

  Widget _buildStartTodayWidget() {
    return Text(
      '${_formatTime(startTime)} 시작',
      style: AppTextStyle.body315M.copyWith(
        fontSize: 16,
        color: AppColor.primaryBlue1,
      ),
    );
  }

  Widget _buildTomorrowWidget() {
    final formattedDate = DateFormat('M월 d일 E', 'ko_KR').format(matchDate);
    final formattedTime = _formatTime(startTime);

    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColor.accentRed10,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              '내일',
              style: AppTextStyle.caption113B1.copyWith(
                color: AppColor.accentRed100,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text('$formattedDate • $formattedTime'),
      ],
    );
  }

  Widget _buildUpcomingWidget() {
    final diff = matchDate.difference(DateTime.now()).inDays;
    final formattedDate = DateFormat('M월 d일 E', 'ko_KR').format(matchDate);
    final formattedTime = _formatTime(startTime);

    if (diff >= 2 && diff <= 14) {
      return Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.accentRed10,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'D-$diff',
                style: AppTextStyle.caption113B1.copyWith(
                  color: AppColor.accentRed100,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text('$formattedDate • $formattedTime'),
        ],
      );
    } else if (diff >= 15 && diff <= 100) {
      return Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.primaryBlue3,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'D-$diff',
                style: AppTextStyle.caption113B1.copyWith(
                  color: AppColor.primaryBlue2,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text('$formattedDate • $formattedTime'),
        ],
      );
    } else {
      return Row(
        children: [
          Text('$formattedDate • $formattedTime'),
        ],
      );
    }
  }

  Widget _buildFutureWidget() {
    final formattedDate = DateFormat('M월 d일 E', 'ko_KR').format(matchDate);
    final formattedTime = _formatTime(startTime);

    return Row(
      children: [
        Text('$formattedDate • $formattedTime'),
      ],
    );
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour;
    final minute = time.minute;
    final amPm = hour < 12 ? '오전' : '오후';
    final formattedHour = hour > 12 ? hour - 12 : hour;
    final formattedMinute = minute.toString().padLeft(2, '0');
    return '$amPm $formattedHour시 $formattedMinute분';
  }

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case MatchStatus.notStarted:
        return const SizedBox.shrink();
      case MatchStatus.inProgress:
        return _buildInProgressWidget();
      case MatchStatus.startToday:
        return _buildStartTodayWidget();
      case MatchStatus.tomorrow:
        return _buildTomorrowWidget();
      case MatchStatus.upcoming:
        return _buildUpcomingWidget();
      case MatchStatus.future:
        return _buildFutureWidget();
    }
  }
}
