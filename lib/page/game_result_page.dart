import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/common/app_text_list.dart';
import 'package:my_baseball_record/common/app_text_style.dart';
import 'package:my_baseball_record/common/game_card.dart';

class GameResultPage extends StatefulWidget {
  final GameCard gameCard;

  const GameResultPage({
    super.key,
    required this.gameCard,
  });

  @override
  State<GameResultPage> createState() => _GameResultPageState();
}

class _GameResultPageState extends State<GameResultPage> {
  int _ourTeamScore = 0;
  int _opponentTeamScore = 0;
  String _result = '';
  Color _resultColor = AppColor.graysWhite;

  final _ourTeamScoreController = TextEditingController();
  final _opponentTeamScoreController = TextEditingController();
  final _ourTeamScoreFocusNode = FocusNode();
  final _opponentTeamScoreFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _ourTeamScoreFocusNode.requestFocus();
    _ourTeamScoreController.addListener(_onOurTeamScoreChanged);
    _opponentTeamScoreController.addListener(_onOpponentTeamScoreChanged);
  }

  void _onOurTeamScoreChanged() {
    final text = _ourTeamScoreController.text;
    if (text.isNotEmpty) {
      if (text.length > 2) {
        _ourTeamScoreController.value = TextEditingValue(
          text: text.substring(0, 2),
          selection: const TextSelection.collapsed(offset: 2),
        );
      } else if (text == '0') {
        _ourTeamScoreController.value = const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        );
      }
    }
    _updateResult();
  }

  void _onOpponentTeamScoreChanged() {
    final text = _opponentTeamScoreController.text;
    if (text.isNotEmpty) {
      if (text.length > 2) {
        _opponentTeamScoreController.value = TextEditingValue(
          text: text.substring(0, 2),
          selection: const TextSelection.collapsed(offset: 2),
        );
      } else if (text == '0') {
        _opponentTeamScoreController.value = const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        );
      }
    }
    _updateResult();
  }

  void _updateResult() {
    setState(() {
      _ourTeamScore = int.tryParse(_ourTeamScoreController.text) ?? 0;
      _opponentTeamScore = int.tryParse(_opponentTeamScoreController.text) ?? 0;

      if (_ourTeamScore > _opponentTeamScore) {
        _result = '승';
        _resultColor = AppColor.accentGreen100;
      } else if (_ourTeamScore < _opponentTeamScore) {
        _result = '패';
        _resultColor = AppColor.accentRed100;
      } else if (_ourTeamScore == _opponentTeamScore) {
        _result = '무';
        _resultColor = AppColor.textHint;
      }
    });
  }

  @override
  void dispose() {
    _ourTeamScoreController.removeListener(_updateResult);
    _opponentTeamScoreController.removeListener(_updateResult);
    _ourTeamScoreController.dispose();
    _opponentTeamScoreController.dispose();
    _ourTeamScoreFocusNode.dispose();
    _opponentTeamScoreFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('M월 d일 E', 'ko_KR').format(widget.gameCard.matchDate);
    final formattedTime = DateFormat('HH:mm').format(DateTime(
      0,
      0,
      0,
      widget.gameCard.startTime.hour,
      widget.gameCard.startTime.minute,
    ));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.close),
                    Text(
                      AppTextList.saveData,
                      style: AppTextStyle.body315M.copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 21,
                ),
                Text(
                  AppTextList.matchResult,
                  style: AppTextStyle.h224B.copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),
                const SizedBox(
                  height: 31,
                ),
                Text(
                  '$formattedDate • $formattedTime',
                  style: AppTextStyle.body315M.copyWith(
                    fontSize: 16,
                    color: AppColor.textSecondary,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.gameCard.matchPlace,
                  style: AppTextStyle.body413M.copyWith(
                    color: AppColor.textHint,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  color: AppColor.textHint,
                  thickness: 0.5,
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      AppTextList.ourTeam,
                      style: AppTextStyle.caption113B1.copyWith(
                        color: AppColor.primaryBlue1,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: _resultColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _result,
                        style: AppTextStyle.body315M.copyWith(
                          color: AppColor.graysWhite,
                        ),
                      ),
                    ),
                    Text(
                      AppTextList.opponentTeam,
                      style: AppTextStyle.body413M.copyWith(
                        color: AppColor.textHint,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 16,
                        ),
                        decoration: const BoxDecoration(
                          color: AppColor.background246,
                        ),
                        child: TextField(
                          controller: _ourTeamScoreController,
                          focusNode: _ourTeamScoreFocusNode,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.hero48BB.copyWith(
                            color: AppColor.textPrimary,
                          ),
                          onSubmitted: (_) {
                            _opponentTeamScoreFocusNode.requestFocus();
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      ':',
                      style: AppTextStyle.hero48BB.copyWith(
                        color: AppColor.textPrimary10,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 16,
                        ),
                        decoration: const BoxDecoration(
                          color: AppColor.graysWhite,
                        ),
                        child: TextField(
                          controller: _opponentTeamScoreController,
                          focusNode: _opponentTeamScoreFocusNode,
                          textInputAction: TextInputAction.done,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.hero48BB.copyWith(
                            color: AppColor.textPrimary10,
                          ),
                          onSubmitted: (_) {
                            _updateResult();
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        widget.gameCard.team1Name,
                        style: AppTextStyle.body315M.copyWith(
                          color: AppColor.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        widget.gameCard.team2Name,
                        style: AppTextStyle.body315M.copyWith(
                          color: AppColor.textPrimary10,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
