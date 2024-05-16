import 'package:flutter/material.dart';

class GameModel {
  final DateTime matchDate;
  final String matchPlace;
  final String team1Name;
  final String? team1Icon;
  final String team2Name;
  final String? team2Icon;
  final List<String>? positions;

  late final int? ourTeamScore;
  late final int? opponentTeamScore;
  late final String? result;
  late final bool isFinished;

  GameModel({
    required this.matchDate,
    required this.matchPlace,
    required this.team1Name,
    this.team1Icon,
    required this.team2Name,
    this.team2Icon,
    this.positions = const ['포지션 미정'],
    this.ourTeamScore,
    this.opponentTeamScore,
    this.result,
    this.isFinished = false,
  });

  TimeOfDay get startTime {
    return TimeOfDay.fromDateTime(matchDate);
  }

  void updateResult(
      {required int ourTeamScore,
      required int opponentTeamScore,
      required String result,
      required bool isFinished}) {
    this.ourTeamScore = ourTeamScore;
    this.opponentTeamScore = opponentTeamScore;
    this.result = result;
    this.isFinished = isFinished;
  }
}
