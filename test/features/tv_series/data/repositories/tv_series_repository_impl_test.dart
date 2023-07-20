import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_model.dart';
import 'package:ditonton/features/tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepository repository;
  late MockTvSeriesRemoteDataSource mockTvSeriesRemoteDataSource;
  late MockTvSeriesLocalDataSource mockTvSeriesLocalDataSource;

  setUp(() {
    mockTvSeriesRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockTvSeriesLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockTvSeriesRemoteDataSource,
      localDataSource: mockTvSeriesLocalDataSource,
    );
  });

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
  final tSeries = TvSeries(
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

  final tSeriesModelList = <TvSeriesModel>[tSeriesModel];
  final tSeriesList = <TvSeries>[tSeries];

  group('Now Playing Movies', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          mockTvSeriesRemoteDataSource.getAiringTodayTvSeries(),
        ).thenAnswer((_) async => tSeriesModelList);
        // act
        final result = await repository.getAiringTodayTvSeries();
        // assert
        verify(
          mockTvSeriesRemoteDataSource.getAiringTodayTvSeries(),
        );
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tSeriesList);
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(
          mockTvSeriesRemoteDataSource.getAiringTodayTvSeries(),
        ).thenThrow(ServerException());
        // act
        final result = await repository.getAiringTodayTvSeries();
        // assert
        verify(
          mockTvSeriesRemoteDataSource.getAiringTodayTvSeries(),
        );
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected to internet',
      () async {
        // arrange
        when(
          mockTvSeriesRemoteDataSource.getAiringTodayTvSeries(),
        ).thenThrow(
          SocketException('Failed to connect to the network'),
        );
        // act
        final result = await repository.getAiringTodayTvSeries();
        // assert
        verify(
          mockTvSeriesRemoteDataSource.getAiringTodayTvSeries(),
        );
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });
}
