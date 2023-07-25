import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/search_tv_series.dart';
import 'package:ditonton/features/tv_series/presentation/providers/search_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_tv_series_notifier_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late MockSearchTvSeries mockSearchTvSeries;
  late SearchTvSeriesNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvSeries = MockSearchTvSeries();
    provider = SearchTvSeriesNotifier(
      searchTvSeries: mockSearchTvSeries,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  const tQuery = 'Spiderman';
  final tSeriesList = <TvSeries>[testSeries];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockSearchTvSeries.execute(tQuery)).thenAnswer(
      (_) async => Right(tSeriesList),
    );
    // act
    provider.fetchSearchTvSeries(tQuery);
    // assert
    expect(provider.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv series data when data is gotten successfully',
      () async {
    // arrange
    when(mockSearchTvSeries.execute(tQuery)).thenAnswer(
      (_) async => Right(tSeriesList),
    );
    // act
    await provider.fetchSearchTvSeries(tQuery);
    // assert
    expect(provider.state, RequestState.loaded);
    expect(provider.tvSeries, tSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockSearchTvSeries.execute(tQuery)).thenAnswer(
      (_) async => const Left(ServerFailure('Server Failure')),
    );
    // act
    await provider.fetchSearchTvSeries(tQuery);
    // assert
    expect(provider.state, RequestState.error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
