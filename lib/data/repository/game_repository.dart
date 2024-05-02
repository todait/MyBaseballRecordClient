import 'package:flutter/material.dart';
import 'package:my_baseball_record/common/game_card.dart';
import 'package:my_baseball_record/common/match_status_widget.dart';

class GameRepository {
  Future<List<GameCard>> getGames() async {
    return [
      GameCard(
        matchDate: DateTime(2024, 4, 27),
        startTime: const TimeOfDay(hour: 16, minute: 0),
        matchPlace: '맥도 생태공원',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '용병',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710광주',
      ),
      GameCard(
        matchDate: DateTime(2024, 5, 2),
        startTime: const TimeOfDay(hour: 07, minute: 30),
        matchPlace: '맥도 생태공원',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '용병',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710광주',
        positions: const ['타자', '투수'],
      ),
      GameCard(
        matchPlace: '화명 A구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '용병',
        btnTitle: '결과 입력하기',
        matchDate: DateTime(2024, 5, 5),
        startTime: const TimeOfDay(hour: 08, minute: 0),
        team2Icon:
            'http://file.clubone.kr/symbol/club/20180201202334_368_thumb.jpg',
        team2Name: 'ZeroSevens',
      ),
      GameCard(
        positions: const ['타자', '투수'],
        matchDate: DateTime(2024, 5, 6),
        startTime: const TimeOfDay(hour: 10, minute: 0),
        matchPlace: '화명 B구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '용병',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
      ),
      GameCard(
        matchDate: DateTime(2024, 5, 11),
        startTime: const TimeOfDay(hour: 10, minute: 0),
        matchPlace: '화명 B구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '용병',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
      ),
      GameCard(
        matchDate: DateTime(2024, 5, 19),
        startTime: const TimeOfDay(hour: 10, minute: 0),
        positions: const ['타자'],
        matchPlace: '화명 A구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '용병',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
      ),
      GameCard(
        matchDate: DateTime(2024, 5, 26),
        startTime: const TimeOfDay(hour: 10, minute: 0),
        positions: const ['타자'],
        matchPlace: '화명 A구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '용병',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
      ),
      GameCard(
        matchDate: DateTime(2024, 6, 2),
        startTime: const TimeOfDay(hour: 08, minute: 0),
        positions: const ['타자'],
        matchPlace: '화명 A구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '용병',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
      ),
      GameCard(
        matchDate: DateTime(2024, 6, 16),
        startTime: const TimeOfDay(hour: 07, minute: 30),
        matchPlace: '화명 B구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '용병',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
      ),
      GameCard(
        matchDate: DateTime(2024, 6, 23),
        startTime: const TimeOfDay(hour: 10, minute: 0),
        positions: const ['투수'],
        matchPlace: '삼락 A구장',
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

  Future<List<GameCard>> getFinishedGames() async {
    return [
      GameCard(
        matchDate: DateTime(2024, 2, 4),
        startTime: const TimeOfDay(hour: 11, minute: 0),
        matchPlace: '화명 B구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
        finishedMatchStatus: FinishedMatchStatus.win,
      ),
      GameCard(
        matchDate: DateTime(2024, 2, 18),
        startTime: const TimeOfDay(hour: 08, minute: 0),
        matchPlace: '화명 A구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
        finishedMatchStatus: FinishedMatchStatus.lose,
      ),
      GameCard(
        matchDate: DateTime(2024, 2, 25),
        startTime: const TimeOfDay(hour: 11, minute: 0),
        matchPlace: '화명 B구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
        finishedMatchStatus: FinishedMatchStatus.unknown,
      ),
      GameCard(
        matchDate: DateTime(2024, 3, 10),
        startTime: const TimeOfDay(hour: 10, minute: 30),
        matchPlace: '화명 A구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
        finishedMatchStatus: FinishedMatchStatus.unknown,
      ),
      GameCard(
        matchDate: DateTime(2024, 3, 31),
        startTime: const TimeOfDay(hour: 08, minute: 0),
        matchPlace: '화명 B구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
        finishedMatchStatus: FinishedMatchStatus.unknown,
      ),
      GameCard(
        matchDate: DateTime(2024, 4, 7),
        startTime: const TimeOfDay(hour: 09, minute: 40),
        matchPlace: '삼락 A구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        btnTitle: '결과 입력하기',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
        finishedMatchStatus: FinishedMatchStatus.unknown,
      ),
    ];
  }
}
