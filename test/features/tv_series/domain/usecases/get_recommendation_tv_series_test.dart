import 'package:dartz/dartz.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_recommendation_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetRecommendationTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetRecommendationTvSeries(mockTvSeriesRepository);
  });

  final tListSeries = <TvSeries>[];
  const tSeriesId = 1;

  group('GetRecommendationTvSeries Tests', () {
    group('execute', () {
      test(
        'should get list of tv series from the repository when execute function is called',
        () async {
          // arrange
          when(mockTvSeriesRepository.getTvSeriesRecommendations(tSeriesId))
              .thenAnswer((_) async => Right(tListSeries));
          // act
          final result = await usecase.execute(tSeriesId);
          // assert
          expect(result, Right(tListSeries));
        },
      );
    });
  });
}
