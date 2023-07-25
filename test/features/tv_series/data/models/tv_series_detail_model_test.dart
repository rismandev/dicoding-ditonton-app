import 'dart:convert';
import 'package:ditonton/features/tv_series/data/models/tv_series_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../json_reader.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  group('test fromMap, toMap and toEntity function', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('features/tv_series/dummy_data/tv_series_detail.json'),
      );
      // act
      final result = TvSeriesDetailModel.fromMap(jsonMap);
      // assert
      expect(result, testSeriesDetailModel);
    });

    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testSeriesDetailModel.toMap();
      // assert
      final Map<String, dynamic> expectedJsonMap = json.decode(
        readJson('features/tv_series/dummy_data/tv_series_detail.json'),
      );
      expect(result, expectedJsonMap);
    });

    test('should be a subclass of TvSeriesDetail entity', () async {
      final result = testSeriesDetailModel.toEntity();
      expect(result, testSeriesDetail);
    });
  });
}
