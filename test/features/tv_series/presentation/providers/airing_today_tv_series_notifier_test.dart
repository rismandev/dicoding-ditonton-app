import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_airing_today_tv_series.dart';
import 'package:ditonton/features/tv_series/presentation/providers/airing_today_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([GetAiringTodayTvSeries])
void main() {
  late MockGetAiringTodayTvSeries mockGetAiringTodayTvSeries;
  late AiringTodayTvSeriesNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetAiringTodayTvSeries = MockGetAiringTodayTvSeries();
    provider = AiringTodayTvSeriesNotifier(
      getAiringTodayTvSeries: mockGetAiringTodayTvSeries,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  final tSeriesList = <TvSeries>[testSeries];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetAiringTodayTvSeries.execute()).thenAnswer(
      (_) async => Right(tSeriesList),
    );
    // act
    provider.fetchAiringTodayTvSeries();
    // assert
    expect(provider.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv series data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetAiringTodayTvSeries.execute()).thenAnswer(
      (_) async => Right(tSeriesList),
    );
    // act
    await provider.fetchAiringTodayTvSeries();
    // assert
    expect(provider.state, RequestState.loaded);
    expect(provider.tvSeries, tSeriesList);
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
    expect(provider.state, RequestState.error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
