import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_detail_model.dart';
import 'package:http/http.dart' as http;

import '../models/tv_series_model.dart';
import '../models/tv_series_response.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getAiringTodayTvSeries();
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<List<TvSeriesModel>> getTopRatedTvSeries();
  Future<TvSeriesDetailModel> getTvSeriesDetail(int id);
  Future<List<TvSeriesModel>> getTvSeriesRecommendations(int id);
  Future<List<TvSeriesModel>> searchTvSeries(String query);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  static const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const baseUrl = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getAiringTodayTvSeries() async {
    final response = await client.get(
      Uri.parse('$baseUrl/tv/airing_today?$apiKey'),
    );

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromMap(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    final response = await client.get(
      Uri.parse('$baseUrl/tv/popular?$apiKey'),
    );

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromMap(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    final response = await client.get(
      Uri.parse('$baseUrl/tv/top_rated?$apiKey'),
    );

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromMap(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailModel> getTvSeriesDetail(int id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/tv/$id?$apiKey'),
    );

    if (response.statusCode == 200) {
      return TvSeriesDetailModel.fromMap(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvSeriesRecommendations(int id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'),
    );

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromMap(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    final response = await client.get(
      Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'),
    );

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromMap(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }
}
