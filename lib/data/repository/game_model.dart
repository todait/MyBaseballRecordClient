import 'package:flutter/material.dart';

class GameModel {
  final DateTime matchDate;
  final String matchPlace;
  final String team1Name;
  final String? team1Icon;
  final String team2Name;
  final String? team2Icon;
  final List<String>? positions;

  GameModel({
    required this.matchDate,
    required this.matchPlace,
    required this.team1Name,
    this.team1Icon,
    required this.team2Name,
    this.team2Icon,
    this.positions = const ['포지션 미정'],
  });

  TimeOfDay get startTime {
    return TimeOfDay.fromDateTime(matchDate);
  }
}
