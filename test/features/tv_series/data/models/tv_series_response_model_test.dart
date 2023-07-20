import 'dart:convert';

import 'package:ditonton/features/tv_series/data/models/tv_series_model.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../json_reader.dart';

void main() {
  final tSeriesModel = TvSeriesModel(
    backdropPath: "/aWPhMZ0P2DyfWB7k5NXhGHSZHGC.jpg",
    firstAirDate: "2023-05-08",
    genreIds: [18, 80, 10766],
    id: 209265,
    name: "Terra e Paixão",
    originCountry: ["BR"],
    originalLanguage: "pt",
    originalName: "Terra e Paixão",
    overview: "",
    popularity: 3267.393,
    posterPath: "/voaKRrYExZNkf1E4FZExU7fTd8w.jpg",
    voteAverage: 5.7,
    voteCount: 43,
  );

  final tSeriesResponseModel = TvSeriesResponse(
    tvSeriesList: <TvSeriesModel>[tSeriesModel],
  );

  group('fromJson', () {
    test(
      'should return a valid model from JSON',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          readJson('features/tv_series/dummy_data/tv_series_airing_today.json'),
        );
        // act
        final result = TvSeriesResponse.fromMap(jsonMap);
        // assert
        expect(result, tSeriesResponseModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing proper data',
      () async {
        // arrange

        // act
        final result = tSeriesResponseModel.toMap();
        // assert
        final expectedJsonMap = {
          "results": [
            {
              "backdrop_path": "/aWPhMZ0P2DyfWB7k5NXhGHSZHGC.jpg",
              "first_air_date": "2023-05-08",
              "genre_ids": [18, 80, 10766],
              "id": 209265,
              "name": "Terra e Paixão",
              "origin_country": ["BR"],
              "original_language": "pt",
              "original_name": "Terra e Paixão",
              "overview": "",
              "popularity": 3267.393,
              "poster_path": "/voaKRrYExZNkf1E4FZExU7fTd8w.jpg",
              "vote_average": 5.7,
              "vote_count": 43
            }
          ],
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
