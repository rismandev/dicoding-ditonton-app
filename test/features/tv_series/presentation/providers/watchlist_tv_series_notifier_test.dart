import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/features/tv_series/presentation/providers/watchlist_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late WatchlistTvSeriesNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    provider = WatchlistTvSeriesNotifier(
      getWatchlistTvSeries: mockGetWatchlistTvSeries,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  group('Get Watchlist TV Series Tests', () {
    test('should change tv series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetWatchlistTvSeries.execute()).thenAnswer(
        (_) async => Right([testWatchlistSeries]),
      );
      // act
      await provider.fetchWatchlistTvSeries();
      // assert
      expect(provider.watchlistState, RequestState.loaded);
      expect(provider.watchlistTvSeries, [testWatchlistSeries]);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetWatchlistTvSeries.execute()).thenAnswer(
        (_) async => const Left(DatabaseFailure("Can't get data")),
      );
      // act
      await provider.fetchWatchlistTvSeries();
      // assert
      expect(provider.watchlistState, RequestState.error);
      expect(provider.message, "Can't get data");
      expect(listenerCallCount, 2);
    });
  });
}
