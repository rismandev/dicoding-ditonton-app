import 'dart:convert';

import 'package:ditonton/features/movie/data/models/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../json_reader.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  group('test fromJson, toJson and toEntity function', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('features/movie/dummy_data/movie_detail.json'),
      );
      // act
      final result = MovieDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, testMovieDetailResponse);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testMovieDetailResponse.toJson();
      // assert
      final Map<String, dynamic> expectedJsonMap = json.decode(
        readJson('features/movie/dummy_data/movie_detail.json'),
      );
      expect(result, expectedJsonMap);
    });

    test('should be a subclass of TvSeriesDetail entity', () async {
      final result = testMovieDetailResponse.toEntity();
      expect(result, testMovieDetailEntity);
    });
  });
}
