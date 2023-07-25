import 'package:ditonton/features/tv_series/data/models/season_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  group('test fromMap, toMap and toEntity function', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = {
        "air_date": "2023-05-08",
        "episode_count": 100,
        "id": 1,
        "name": "Season 1",
        "overview": "season pertama",
        "poster_path": "/path.jpg",
        "season_number": 1,
        "vote_average": 8.0
      };
      // act
      final result = SeasonModel.fromMap(jsonMap);
      // assert
      expect(result, testSeasonModel);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testSeasonModel.toMap();
      // assert
      final Map<String, dynamic> expectedJsonMap = {
        "air_date": "2023-05-08",
        "episode_count": 100,
        "id": 1,
        "name": "Season 1",
        "overview": "season pertama",
        "poster_path": "/path.jpg",
        "season_number": 1,
        "vote_average": 8.0
      };
      expect(result, expectedJsonMap);
    });

    test('should be a subclass of TvSeriesDetail entity', () async {
      final result = testSeasonModel.toEntity();
      expect(result, testSeason);
    });
  });
}
