import 'dart:convert';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/features/tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_detail_model.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';
import '../../../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Airing Today TV Series', () {
    final tMovieList = TvSeriesResponse.fromMap(
      json.decode(readJson(
          'features/tv_series/dummy_data/tv_series_airing_today.json')),
    ).tvSeriesList;

    test(
      'should return list of Tv Series Model when the response code is 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')),
        ).thenAnswer(
          (_) async => http.Response(
            readJson(
                'features/tv_series/dummy_data/tv_series_airing_today.json'),
            200,
          ),
        );
        // act
        final result = await dataSource.getAiringTodayTvSeries();
        // assert
        expect(result, equals(tMovieList));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getAiringTodayTvSeries();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get Popular TV Series', () {
    final tMovieList = TvSeriesResponse.fromMap(
      json.decode(
          readJson('features/tv_series/dummy_data/tv_series_popular.json')),
    ).tvSeriesList;

    test(
      'should return list of tv series when response is success (200)',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')),
        ).thenAnswer(
          (_) async => http.Response(
            readJson('features/tv_series/dummy_data/tv_series_popular.json'),
            200,
          ),
        );
        // act
        final result = await dataSource.getPopularTvSeries();
        // assert
        expect(result, tMovieList);
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getPopularTvSeries();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get Top Rated TV Series', () {
    final tMovieList = TvSeriesResponse.fromMap(json.decode(
      readJson('features/tv_series/dummy_data/tv_series_top_rated.json'),
    )).tvSeriesList;

    test(
      'should return list of tv series when response code is 200 ',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')),
        ).thenAnswer(
          (_) async => http.Response(
            readJson('features/tv_series/dummy_data/tv_series_top_rated.json'),
            200,
          ),
        );
        // act
        final result = await dataSource.getTopRatedTvSeries();
        // assert
        expect(result, tMovieList);
      },
    );

    test(
      'should throw ServerException when response code is other than 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTopRatedTvSeries();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get TV Series detail', () {
    const tId = 1;
    final tvSeriesDetail = TvSeriesDetailModel.fromMap(
      json.decode(
        readJson('features/tv_series/dummy_data/tv_series_detail.json'),
      ),
    );

    test(
      'should return tv series detail when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse('$baseUrl/tv/$tId?$apiKey'),
        )).thenAnswer(
          (_) async => http.Response(
            readJson('features/tv_series/dummy_data/tv_series_detail.json'),
            200,
          ),
        );
        // act
        final result = await dataSource.getTvSeriesDetail(tId);
        // assert
        expect(result, equals(tvSeriesDetail));
      },
    );

    test(
      'should throw Server Exception when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTvSeriesDetail(tId);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get tv series recommendations', () {
    const tId = 1;
    final tSeriesList = TvSeriesResponse.fromMap(json.decode(
      readJson('features/tv_series/dummy_data/tv_series_recommendations.json'),
    )).tvSeriesList;

    test(
      'should return list of tv series Model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey'),
        )).thenAnswer(
          (_) async => http.Response(
            readJson(
              'features/tv_series/dummy_data/tv_series_recommendations.json',
            ),
            200,
          ),
        );
        // act
        final result = await dataSource.getTvSeriesRecommendations(tId);
        // assert
        expect(result, equals(tSeriesList));
      },
    );

    test(
      'should throw Server Exception when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey'),
        )).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTvSeriesRecommendations(tId);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('search tv series', () {
    const tQuery = 'Spiderman';
    final tSearchResult = TvSeriesResponse.fromMap(json.decode(
      readJson('features/tv_series/dummy_data/tv_series_search.json'),
    )).tvSeriesList;

    test(
      'should return list of tv series when response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery'),
        )).thenAnswer(
          (_) async => http.Response(
            readJson('features/tv_series/dummy_data/tv_series_search.json'),
            200,
          ),
        );
        // act
        final result = await dataSource.searchTvSeries(tQuery);
        // assert
        expect(result, tSearchResult);
      },
    );

    test(
      'should throw ServerException when response code is other than 200',
      () async {
        // arrange
        when(mockHttpClient.get(
          Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery'),
        )).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.searchTvSeries(tQuery);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
