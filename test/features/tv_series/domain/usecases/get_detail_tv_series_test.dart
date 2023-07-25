import 'package:dartz/dartz.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_detail_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late GetDetailTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetDetailTvSeries(mockTvSeriesRepository);
  });

  const tSeriesId = 1;

  group('GetDetailTvSeries Tests', () {
    group('execute', () {
      test(
        'should get detail of tv series from the repository when execute function is called',
        () async {
          // arrange
          when(mockTvSeriesRepository.getTvSeriesDetail(tSeriesId)).thenAnswer(
            (_) async => const Right(testSeriesDetail),
          );
          // act
          final result = await usecase.execute(tSeriesId);
          // assert
          expect(result, const Right(testSeriesDetail));
        },
      );
    });
  });
}
