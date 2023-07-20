import 'package:ditonton/common/exception.dart';
import 'package:ditonton/features/tv_series/data/datasources/db/database_helper.dart';
import 'package:ditonton/features/tv_series/data/datasources/tv_series_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late TvSeriesLocalDataSource dataSource;
  late TvSeriesDBHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockTvSeriesDBHelper();
    dataSource = TvSeriesLocalDataSourceImpl(
      databaseHelper: mockDatabaseHelper,
    );
  });

  group('save watchlist', () {
    test(
      'should return success message when insert to database is success',
      () async {
        // arrange
        when(
          mockDatabaseHelper.insertWatchlist(testTvSeriesTable),
        ).thenAnswer((_) async => 1);
        // act
        final result = await dataSource.insertWatchlist(testTvSeriesTable);
        // assert
        expect(result, 'Added to Watchlist');
      },
    );

    test(
      'should throw DatabaseException when insert to database is failed',
      () async {
        // arrange
        when(
          mockDatabaseHelper.insertWatchlist(testTvSeriesTable),
        ).thenThrow(Exception());
        // act
        final call = dataSource.insertWatchlist(testTvSeriesTable);
        // assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      },
    );
  });

  group('remove watchlist', () {
    test(
      'should return success message when remove from database is success',
      () async {
        // arrange
        when(
          mockDatabaseHelper.removeWatchlist(testTvSeriesTable),
        ).thenAnswer((_) async => 1);
        // act
        final result = await dataSource.removeWatchlist(testTvSeriesTable);
        // assert
        expect(result, 'Removed from Watchlist');
      },
    );

    test(
      'should throw DatabaseException when remove from database is failed',
      () async {
        // arrange
        when(
          mockDatabaseHelper.removeWatchlist(testTvSeriesTable),
        ).thenThrow(Exception());
        // act
        final call = dataSource.removeWatchlist(testTvSeriesTable);
        // assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      },
    );
  });

  group('Get TV Series Detail By Id', () {
    final tId = 1;

    test(
      'should return TV Series Detail Table when data is found',
      () async {
        // arrange
        when(
          mockDatabaseHelper.getTvSeriesById(tId),
        ).thenAnswer((_) async => testTvSeriesMap);
        // act
        final result = await dataSource.getTvSeriesById(tId);
        // assert
        expect(result, testTvSeriesTable);
      },
    );

    test(
      'should return null when data is not found',
      () async {
        // arrange
        when(
          mockDatabaseHelper.getTvSeriesById(tId),
        ).thenAnswer((_) async => null);
        // act
        final result = await dataSource.getTvSeriesById(tId);
        // assert
        expect(result, null);
      },
    );
  });

  group('get watchlist tv series', () {
    test(
      'should return list of TvSeriesTable from database',
      () async {
        // arrange
        when(
          mockDatabaseHelper.getWatchlistTvSeries(),
        ).thenAnswer((_) async => [testTvSeriesMap]);
        // act
        final result = await dataSource.getWatchlistTvSeries();
        // assert
        expect(result, [testTvSeriesTable]);
      },
    );
  });
}
