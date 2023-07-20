import 'dart:convert';
import 'package:ditonton/features/movie/data/models/movie_model.dart';
import 'package:ditonton/features/movie/data/models/movie_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../json_reader.dart';

void main() {
  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: "/qWQSnedj0LCUjWNp9fLcMtfgadp.jpg",
    genreIds: [28, 12, 878],
    id: 667538,
    originalTitle: "Transformers: Rise of the Beasts",
    overview:
        "When a new threat capable of destroying the entire planet emerges, Optimus Prime and the Autobots must team up with a powerful faction known as the Maximals. With the fate of humanity hanging in the balance, humans Noah and Elena will do whatever it takes to help the Transformers as they engage in the ultimate battle to save Earth.",
    popularity: 8466.323,
    posterPath: "/gPbM0MK8CP8A174rmUwGsADNYKD.jpg",
    releaseDate: "2023-06-06",
    title: "Transformers: Rise of the Beasts",
    video: false,
    voteAverage: 7.3,
    voteCount: 1431,
  );
  final tMovieResponseModel =
      MovieResponse(movieList: <MovieModel>[tMovieModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('features/movie/dummy_data/now_playing.json'));
      // act
      final result = MovieResponse.fromJson(jsonMap);
      // assert
      expect(result, tMovieResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tMovieResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/qWQSnedj0LCUjWNp9fLcMtfgadp.jpg",
            "genre_ids": [28, 12, 878],
            "id": 667538,
            "original_title": "Transformers: Rise of the Beasts",
            "overview":
                "When a new threat capable of destroying the entire planet emerges, Optimus Prime and the Autobots must team up with a powerful faction known as the Maximals. With the fate of humanity hanging in the balance, humans Noah and Elena will do whatever it takes to help the Transformers as they engage in the ultimate battle to save Earth.",
            "popularity": 8466.323,
            "poster_path": "/gPbM0MK8CP8A174rmUwGsADNYKD.jpg",
            "release_date": "2023-06-06",
            "title": "Transformers: Rise of the Beasts",
            "video": false,
            "vote_average": 7.3,
            "vote_count": 1431,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
