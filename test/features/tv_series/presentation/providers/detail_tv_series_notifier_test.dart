import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_detail_tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_recommendation_tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/remove_tv_series_from_watchlist.dart';
import 'package:ditonton/features/tv_series/domain/usecases/save_tv_series_to_watchlist.dart';
import 'package:ditonton/features/tv_series/presentation/providers/detail_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_tv_series_notifier_test.mocks.dart';

@GenerateMocks([
  GetDetailTvSeries,
  GetRecommendationTvSeries,
  SaveTvSeriesToWatchlist,
  RemoveTvSeriesFromWatchlist,
  GetWatchlistTvSeries,
  GetWatchlistStatusTvSeries,
])
void main() {
  late MockGetDetailTvSeries mockGetDetailTvSeries;
  late MockGetRecommendationTvSeries mockGetRecommendationTvSeries;
  late MockSaveTvSeriesToWatchlist mockSaveTvSeriesToWatchlist;
  late MockRemoveTvSeriesFromWatchlist mockRemoveTvSeriesFromWatchlist;
  late MockGetWatchlistStatusTvSeries mockGetWatchlistStatusTvSeries;
  late DetailTvSeriesNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetDetailTvSeries = MockGetDetailTvSeries();
    mockGetRecommendationTvSeries = MockGetRecommendationTvSeries();
    mockSaveTvSeriesToWatchlist = MockSaveTvSeriesToWatchlist();
    mockRemoveTvSeriesFromWatchlist = MockRemoveTvSeriesFromWatchlist();
    mockGetWatchlistStatusTvSeries = MockGetWatchlistStatusTvSeries();
    provider = DetailTvSeriesNotifier(
      getDetailTvSeries: mockGetDetailTvSeries,
      getRecommendationTvSeries: mockGetRecommendationTvSeries,
      saveTvSeriesToWatchlist: mockSaveTvSeriesToWatchlist,
      removeTvSeriesFromWatchlist: mockRemoveTvSeriesFromWatchlist,
      getWatchlistStatusTvSeries: mockGetWatchlistStatusTvSeries,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  const tId = 1;
  final tSeriesList = <TvSeries>[testSeries];

  void arrangeUsecase() {
    when(mockGetDetailTvSeries.execute(tId))
        .thenAnswer((_) async => const Right(testSeriesDetail));
    when(mockGetRecommendationTvSeries.execute(tId))
        .thenAnswer((_) async => Right(tSeriesList));
  }

  group('Get TV Series Detail Tests', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchDetailTvSeries(tId);
      // assert
      verify(mockGetDetailTvSeries.execute(tId));
      verify(mockGetRecommendationTvSeries.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      arrangeUsecase();
      // act
      provider.fetchDetailTvSeries(tId);
      // assert
      expect(provider.state, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchDetailTvSeries(tId);
      // assert
      expect(provider.state, RequestState.loaded);
      expect(provider.tvSeries, testSeriesDetail);
      expect(listenerCallCount, 3);
    });

    test('should update error message when request in failure', () async {
      // arrange
      when(mockGetDetailTvSeries.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      when(mockGetRecommendationTvSeries.execute(tId))
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await provider.fetchDetailTvSeries(tId);
      // assert
      expect(provider.state, RequestState.error);
      expect(provider.message, 'Failed');
    });
  });

  group('Get TV Series Recommendations Tests', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchDetailTvSeries(tId);
      // assert
      verify(mockGetRecommendationTvSeries.execute(tId));
      expect(provider.tvSeriesRecommendations, tSeriesList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchDetailTvSeries(tId);
      // assert
      expect(provider.recommendationState, RequestState.loaded);
      expect(provider.tvSeriesRecommendations, tSeriesList);
      expect(listenerCallCount, 3);
    });

    test('should update error message when request in failure', () async {
      // arrange
      when(mockGetDetailTvSeries.execute(tId))
          .thenAnswer((_) async => const Right(testSeriesDetail));
      when(mockGetRecommendationTvSeries.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await provider.fetchDetailTvSeries(tId);
      // assert
      expect(provider.recommendationState, RequestState.error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatusTvSeries.execute(1)).thenAnswer(
        (_) async => true,
      );
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveTvSeriesToWatchlist.execute(testSeriesDetail)).thenAnswer(
        (_) async => const Right('Success'),
      );
      when(mockGetWatchlistStatusTvSeries.execute(testSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testSeriesDetail);
      // assert
      verify(mockSaveTvSeriesToWatchlist.execute(testSeriesDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveTvSeriesFromWatchlist.execute(testSeriesDetail))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetWatchlistStatusTvSeries.execute(testSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testSeriesDetail);
      // assert
      verify(mockRemoveTvSeriesFromWatchlist.execute(testSeriesDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveTvSeriesToWatchlist.execute(testSeriesDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchlistStatusTvSeries.execute(testSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testSeriesDetail);
      // assert
      verify(mockGetWatchlistStatusTvSeries.execute(testSeriesDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveTvSeriesToWatchlist.execute(testSeriesDetail)).thenAnswer(
        (_) async => const Left(DatabaseFailure('Failed')),
      );
      when(mockGetWatchlistStatusTvSeries.execute(testSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testSeriesDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
    test('should update watchlist status when remove watchlist success',
        () async {
      // arrange
      when(
        mockRemoveTvSeriesFromWatchlist.execute(testSeriesDetail),
      ).thenAnswer(
        (_) async => const Right('Removed from Watchlist'),
      );
      when(
        mockGetWatchlistStatusTvSeries.execute(testSeriesDetail.id),
      ).thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testSeriesDetail);
      // assert
      verify(mockGetWatchlistStatusTvSeries.execute(testSeriesDetail.id));
      expect(provider.isAddedToWatchlist, false);
      expect(provider.watchlistMessage, 'Removed from Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when removed watchlist failed',
        () async {
      // arrange
      when(
        mockRemoveTvSeriesFromWatchlist.execute(testSeriesDetail),
      ).thenAnswer(
        (_) async => const Left(DatabaseFailure('Failed')),
      );
      when(
        mockGetWatchlistStatusTvSeries.execute(testSeriesDetail.id),
      ).thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testSeriesDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });
}
