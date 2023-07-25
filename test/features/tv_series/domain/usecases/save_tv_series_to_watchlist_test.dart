import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/features/tv_series/domain/usecases/save_tv_series_to_watchlist.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late SaveTvSeriesToWatchlist usecase;
  late MockTvSeriesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockTvSeriesRepository();
    usecase = SaveTvSeriesToWatchlist(mockMovieRepository);
  });

  test('should save tv series to the repository', () async {
    // arrange
    when(mockMovieRepository.saveWatchlist(testSeriesDetail)).thenAnswer(
      (_) async => const Right('Added to Watchlist'),
    );
    // act
    final result = await usecase.execute(testSeriesDetail);
    // assert
    verify(mockMovieRepository.saveWatchlist(testSeriesDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
