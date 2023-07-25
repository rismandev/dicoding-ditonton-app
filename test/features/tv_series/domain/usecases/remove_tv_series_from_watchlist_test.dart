import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/features/tv_series/domain/usecases/remove_tv_series_from_watchlist.dart';

import '../../../../helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late RemoveTvSeriesFromWatchlist usecase;
  late MockTvSeriesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockTvSeriesRepository();
    usecase = RemoveTvSeriesFromWatchlist(mockMovieRepository);
  });

  test('should remove tv series from the repository', () async {
    // arrange
    when(mockMovieRepository.removeWatchlist(testSeriesDetail)).thenAnswer(
      (_) async => const Right('Removed from watchlist'),
    );
    // act
    final result = await usecase.execute(testSeriesDetail);
    // assert
    verify(mockMovieRepository.removeWatchlist(testSeriesDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
