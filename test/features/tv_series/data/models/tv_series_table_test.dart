import 'package:ditonton/features/tv_series/data/models/tv_series_table.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  group('test fromMap, toMap, fromEntity and toEntity function', () {
    test('fromMap', () async {
      // arrange

      // act
      final result = TvSeriesTable.fromMap(testTvSeriesMap);
      // assert
      expect(result, equals(testTvSeriesTable));
    });
    test('toMap', () async {
      // arrange

      // act
      final result = testTvSeriesTable.toMap();
      // assert
      expect(result, equals(testTvSeriesMap));
    });
    test('fromEntity', () async {
      // arrange

      // act
      final result = TvSeriesTable.fromEntity(testSeriesDetail);
      // assert
      expect(result, equals(testTvSeriesTable));
    });
    test('toEntity', () async {
      // arrange

      // act
      final result = testTvSeriesTable.toEntity();
      // assert
      expect(result, equals(testWatchlistSeries));
    });
  });
}
