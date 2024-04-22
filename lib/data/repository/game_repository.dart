import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/game_card.dart';

class GameRepository {
  Future<List<GameCard>> getGames(String game) async {
    return [
      GameCard(
        matchDate: DateTime(2024, 4, 22),
        startTime: const TimeOfDay(hour: 16, minute: 0),
        endTime: const TimeOfDay(hour: 18, minute: 0),
        matchPlace: '조안면 체육공원(UA 베이스볼 파크)',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710광주',
      ),
      GameCard(
        matchPlace: '조안면 체육공원(UA 베이스볼 파크)',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        btnTitle: '결과 입력하기',
        matchDate: DateTime(2024, 4, 22),
        startTime: const TimeOfDay(hour: 22, minute: 0),
        endTime: const TimeOfDay(hour: 24, minute: 0),
        team2Icon:
            'http://file.clubone.kr/symbol/club/20180201202334_368_thumb.jpg',
        team2Name: 'ZeroSevens',
      ),
      GameCard(
        positions: const ['타자', '투수'],
        matchDate: DateTime(2024, 4, 23),
        startTime: const TimeOfDay(hour: 20, minute: 0),
        endTime: const TimeOfDay(hour: 22, minute: 0),
        matchPlace: '조안면 체육공원(UA 베이스볼 파크)',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
      ),
      GameCard(
        matchDate: DateTime(2024, 6, 20),
        startTime: const TimeOfDay(hour: 16, minute: 0),
        endTime: const TimeOfDay(hour: 18, minute: 0),
        matchPlace: '조안면 체육공원(UA 베이스볼 파크)',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
      ),
      GameCard(
        matchDate: DateTime(2024, 6, 22),
        startTime: const TimeOfDay(hour: 10, minute: 0),
        endTime: const TimeOfDay(hour: 12, minute: 0),
        positions: const ['타자'],
        matchPlace: '조안면 체육공원(UA 베이스볼 파크)',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
      ),
      GameCard(
        matchDate: DateTime(2024, 8, 20),
        startTime: const TimeOfDay(hour: 16, minute: 0),
        endTime: const TimeOfDay(hour: 18, minute: 0),
        matchPlace: '조안면 체육공원(UA 베이스볼 파크)',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
      ),
      GameCard(
        matchDate: DateTime(2024, 8, 21),
        startTime: const TimeOfDay(hour: 10, minute: 0),
        endTime: const TimeOfDay(hour: 12, minute: 0),
        positions: const ['투수'],
        matchPlace: '조안면 체육공원(UA 베이스볼 파크)',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
      ),
    ];
  }
}
