import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_airing_today_tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/features/tv_series/presentation/providers/tv_series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetAiringTodayTvSeries,
  GetPopularTvSeries,
  GetTopRatedTvSeries,
])
void main() {
  late TvSeriesListNotifier provider;
  late MockGetAiringTodayTvSeries mockGetAiringTodayTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetAiringTodayTvSeries = MockGetAiringTodayTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    provider = TvSeriesListNotifier(
      getAiringTodayTvSeries: mockGetAiringTodayTvSeries,
      getPopularTvSeries: mockGetPopularTvSeries,
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  final tSeriesList = <TvSeries>[testSeries];

  group('get airing today tv series tests', () {
    test('initialState should be Empty', () {
      expect(provider.airingTodayState, equals(RequestState.empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetAiringTodayTvSeries.execute()).thenAnswer(
        (_) async => Right(tSeriesList),
      );
      // act
      provider.fetchAiringTodayTvSeries();
      // assert
      verify(mockGetAiringTodayTvSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetAiringTodayTvSeries.execute()).thenAnswer(
        (_) async => Right(tSeriesList),
      );
      // act
      provider.fetchAiringTodayTvSeries();
      // assert
      expect(provider.airingTodayState, RequestState.loading);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      when(mockGetAiringTodayTvSeries.execute()).thenAnswer(
        (_) async => Right(tSeriesList),
      );
      // act
      await provider.fetchAiringTodayTvSeries();
      // assert
      expect(provider.airingTodayState, RequestState.loaded);
      expect(provider.airingTodayTvSeries, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetAiringTodayTvSeries.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      // act
      await provider.fetchAiringTodayTvSeries();
      // assert
      expect(provider.airingTodayState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('get popular tv series tests', () {
    test('initialState should be Empty', () {
      expect(provider.popularTvSeriesState, equals(RequestState.empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetPopularTvSeries.execute()).thenAnswer(
        (_) async => Right(tSeriesList),
      );
      // act
      provider.fetchPopularTvSeries();
      // assert
      verify(mockGetPopularTvSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetPopularTvSeries.execute()).thenAnswer(
        (_) async => Right(tSeriesList),
      );
      // act
      provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularTvSeriesState, RequestState.loading);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      when(mockGetPopularTvSeries.execute()).thenAnswer(
        (_) async => Right(tSeriesList),
      );
      // act
      await provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularTvSeriesState, RequestState.loaded);
      expect(provider.popularTvSeries, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvSeries.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      // act
      await provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularTvSeriesState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('get top rated tv series tests', () {
    test('initialState should be Empty', () {
      expect(provider.topRatedTvSeriesState, equals(RequestState.empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute()).thenAnswer(
        (_) async => Right(tSeriesList),
      );
      // act
      provider.fetchTopRatedTvSeries();
      // assert
      verify(mockGetTopRatedTvSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetTopRatedTvSeries.execute()).thenAnswer(
        (_) async => Right(tSeriesList),
      );
      // act
      provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.topRatedTvSeriesState, RequestState.loading);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute()).thenAnswer(
        (_) async => Right(tSeriesList),
      );
      // act
      await provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.topRatedTvSeriesState, RequestState.loaded);
      expect(provider.topRatedTvSeries, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      // act
      await provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.topRatedTvSeriesState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
