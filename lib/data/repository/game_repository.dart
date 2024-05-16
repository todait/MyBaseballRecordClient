import 'package:my_baseball_record/data/repository/game_model.dart';

class GameRepository {
  Future<List<GameModel>> getGameModels() async {
    return [
      GameModel(
        matchDate: DateTime(2024, 4, 27),
        matchPlace: '맥도 생태공원',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '용병',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710광주',
      ),
      GameModel(
        matchDate: DateTime(2024, 5, 2),
        matchPlace: '맥도 생태공원',
        team1Name: '용병',
        team2Name: '용병',
        positions: const ['타자', '투수'],
      ),
      GameModel(
        matchPlace: '화명 A구장',
        team1Name: '용병',
        matchDate: DateTime(2024, 5, 5),
        team2Icon:
            'http://file.clubone.kr/symbol/club/20180201202334_368_thumb.jpg',
        team2Name: 'ZeroSevens',
      ),
      GameModel(
        positions: const ['타자', '투수'],
        matchDate: DateTime(2024, 5, 6),
        matchPlace: '화명 B구장',
        team1Name: '용병',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
      ),
      GameModel(
        matchDate: DateTime(2024, 5, 11),
        matchPlace: '화명 B구장',
        team1Name: '용병',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
      ),
      GameModel(
        matchDate: DateTime(2024, 5, 19),
        positions: const ['타자'],
        matchPlace: '화명 A구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '용병',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
      ),
      GameModel(
        matchDate: DateTime(2024, 5, 26),
        positions: const ['타자'],
        matchPlace: '화명 A구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '용병',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
      ),
      GameModel(
        matchDate: DateTime(2024, 6, 2),
        positions: const ['타자'],
        matchPlace: '화명 A구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '용병',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
      ),
      GameModel(
        matchDate: DateTime(2024, 6, 16),
        matchPlace: '화명 B구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '용병',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
      ),
      GameModel(
        matchDate: DateTime(2024, 6, 23),
        positions: const ['투수'],
        matchPlace: '삼락 A구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
      ),
    ];
  }

  Future<List<GameModel>> getFinishedGameModels() async {
    return [
      GameModel(
        matchDate: DateTime(2024, 2, 4),
        matchPlace: '화명 B구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
        isFinished: true,
      ),
      GameModel(
        matchDate: DateTime(2024, 2, 18),
        matchPlace: '화명 A구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
        isFinished: true,
      ),
      GameModel(
        matchDate: DateTime(2024, 2, 25),
        matchPlace: '화명 B구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
        isFinished: true,
      ),
      GameModel(
        matchDate: DateTime(2024, 3, 10),
        matchPlace: '화명 A구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
        isFinished: true,
      ),
      GameModel(
        matchDate: DateTime(2024, 3, 31),
        matchPlace: '화명 B구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
        isFinished: true,
      ),
      GameModel(
        matchDate: DateTime(2024, 4, 7),
        matchPlace: '삼락 A구장',
        team1Icon:
            'http://file.clubone.kr/symbol/club/20220216162949_239_thumb.jpg',
        team1Name: '발키리',
        team2Icon:
            'http://file.clubone.kr/symbol/club/20231221132509_525_thumb.png',
        team2Name: '국제로타리3710지구',
        isFinished: true,
      ),
      GameModel(
        matchDate: DateTime(2024, 5, 5),
        matchPlace: '화명 A구장',
        team1Name: '용병',
        team2Name: '용병',
        positions: const ['타자'],
        isFinished: true,
      ),
    ];
  }
}
