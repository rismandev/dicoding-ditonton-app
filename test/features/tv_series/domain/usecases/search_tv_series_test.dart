import 'package:dartz/dartz.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SearchTvSeries(mockTvSeriesRepository);
  });

  final tListSeries = <TvSeries>[];
  const tQuery = 'Spiderman';

  group('SearchTvSeries Tests', () {
    group('execute', () {
      test(
        'should get list of tv series from the repository when execute function is called',
        () async {
          // arrange
          when(mockTvSeriesRepository.searchTvSeries(tQuery)).thenAnswer(
            (_) async => Right(tListSeries),
          );
          // act
          final result = await usecase.execute(tQuery);
          // assert
          expect(result, Right(tListSeries));
        },
      );
    });
  });
}
