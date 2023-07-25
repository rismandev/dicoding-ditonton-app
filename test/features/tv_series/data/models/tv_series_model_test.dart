import 'package:ditonton/features/tv_series/data/models/tv_series_model.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSeriesModel = TvSeriesModel(
    backdropPath: "/path.jpg",
    firstAirDate: "2023-07-20",
    genreIds: [1, 2, 3],
    id: 1,
    name: "Test 1",
    originCountry: ["id"],
    originalLanguage: "id",
    originalName: "Test 1",
    overview: "Coba 1",
    popularity: 9.2,
    posterPath: "/path.png",
    voteAverage: 7.5,
    voteCount: 16,
  );

  final tSeries = TvSeries(
    backdropPath: "/path.jpg",
    firstAirDate: "2023-07-20",
    genreIds: const [1, 2, 3],
    id: 1,
    name: "Test 1",
    originCountry: const ["id"],
    originalLanguage: "id",
    originalName: "Test 1",
    overview: "Coba 1",
    popularity: 9.2,
    posterPath: "/path.png",
    voteAverage: 7.5,
    voteCount: 16,
  );

  test('should be a subclass of tSeries entity', () async {
    final result = tSeriesModel.toEntity();
    expect(result, tSeries);
  });
}
