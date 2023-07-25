import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_model.dart';
import 'package:ditonton/features/tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
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

  final tSeriesModelList = <TvSeriesModel>[testSeriesModel];
  final tSeriesList = <TvSeries>[testSeries];

  group('Airing Today TV Series Tests', () {
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
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected to internet',
      () async {
        // arrange
        when(
          mockTvSeriesRemoteDataSource.getAiringTodayTvSeries(),
        ).thenThrow(
          const SocketException('Failed to connect to the network'),
        );
        // act
        final result = await repository.getAiringTodayTvSeries();
        // assert
        verify(
          mockTvSeriesRemoteDataSource.getAiringTodayTvSeries(),
        );
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('Popular TV Series Tests', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          mockTvSeriesRemoteDataSource.getPopularTvSeries(),
        ).thenAnswer((_) async => tSeriesModelList);
        // act
        final result = await repository.getPopularTvSeries();
        // assert
        verify(
          mockTvSeriesRemoteDataSource.getPopularTvSeries(),
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
          mockTvSeriesRemoteDataSource.getPopularTvSeries(),
        ).thenThrow(ServerException());
        // act
        final result = await repository.getPopularTvSeries();
        // assert
        verify(
          mockTvSeriesRemoteDataSource.getPopularTvSeries(),
        );
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected to internet',
      () async {
        // arrange
        when(
          mockTvSeriesRemoteDataSource.getPopularTvSeries(),
        ).thenThrow(
          const SocketException('Failed to connect to the network'),
        );
        // act
        final result = await repository.getPopularTvSeries();
        // assert
        verify(
          mockTvSeriesRemoteDataSource.getPopularTvSeries(),
        );
        expect(
          result,
          equals(
            const Left(ConnectionFailure('Failed to connect to the network')),
          ),
        );
      },
    );
  });

  group('Top Rated TV Series Tests', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          mockTvSeriesRemoteDataSource.getTopRatedTvSeries(),
        ).thenAnswer((_) async => tSeriesModelList);
        // act
        final result = await repository.getTopRatedTvSeries();
        // assert
        verify(
          mockTvSeriesRemoteDataSource.getTopRatedTvSeries(),
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
          mockTvSeriesRemoteDataSource.getTopRatedTvSeries(),
        ).thenThrow(ServerException());
        // act
        final result = await repository.getTopRatedTvSeries();
        // assert
        verify(
          mockTvSeriesRemoteDataSource.getTopRatedTvSeries(),
        );
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected to internet',
      () async {
        // arrange
        when(
          mockTvSeriesRemoteDataSource.getTopRatedTvSeries(),
        ).thenThrow(
          const SocketException('Failed to connect to the network'),
        );
        // act
        final result = await repository.getTopRatedTvSeries();
        // assert
        verify(
          mockTvSeriesRemoteDataSource.getTopRatedTvSeries(),
        );
        expect(
          result,
          equals(
            const Left(ConnectionFailure('Failed to connect to the network')),
          ),
        );
      },
    );
  });

  group('Detail TV Series Tests', () {
    const tId = 1;
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          mockTvSeriesRemoteDataSource.getTvSeriesDetail(tId),
        ).thenAnswer((_) async => testSeriesDetailModel);
        // act
        final result = await repository.getTvSeriesDetail(tId);
        // assert
        verify(
          mockTvSeriesRemoteDataSource.getTvSeriesDetail(tId),
        );
        expect(result, equals(const Right(testSeriesDetail)));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(
          mockTvSeriesRemoteDataSource.getTvSeriesDetail(tId),
        ).thenThrow(ServerException());
        // act
        final result = await repository.getTvSeriesDetail(tId);
        // assert
        verify(
          mockTvSeriesRemoteDataSource.getTvSeriesDetail(tId),
        );
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected to internet',
      () async {
        // arrange
        when(
          mockTvSeriesRemoteDataSource.getTvSeriesDetail(tId),
        ).thenThrow(
          const SocketException('Failed to connect to the network'),
        );
        // act
        final result = await repository.getTvSeriesDetail(tId);
        // assert
        verify(
          mockTvSeriesRemoteDataSource.getTvSeriesDetail(tId),
        );
        expect(
          result,
          equals(
            const Left(ConnectionFailure('Failed to connect to the network')),
          ),
        );
      },
    );
  });

  group('Recommendations TV Series Tests', () {
    const tId = 1;
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          mockTvSeriesRemoteDataSource.getTvSeriesRecommendations(tId),
        ).thenAnswer((_) async => tSeriesModelList);
        // act
        final result = await repository.getTvSeriesRecommendations(tId);
        // assert
        verify(
          mockTvSeriesRemoteDataSource.getTvSeriesRecommendations(tId),
        );
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, equals(tSeriesList));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(
          mockTvSeriesRemoteDataSource.getTvSeriesRecommendations(tId),
        ).thenThrow(ServerException());
        // act
        final result = await repository.getTvSeriesRecommendations(tId);
        // assert
        verify(
          mockTvSeriesRemoteDataSource.getTvSeriesRecommendations(tId),
        );
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected to internet',
      () async {
        // arrange
        when(
          mockTvSeriesRemoteDataSource.getTvSeriesRecommendations(tId),
        ).thenThrow(
          const SocketException('Failed to connect to the network'),
        );
        // act
        final result = await repository.getTvSeriesRecommendations(tId);
        // assert
        verify(
          mockTvSeriesRemoteDataSource.getTvSeriesRecommendations(tId),
        );
        expect(
          result,
          equals(
            const Left(ConnectionFailure('Failed to connect to the network')),
          ),
        );
      },
    );
  });

  group('Seach TV Series Tests', () {
    const tQuery = 'Spiderman';

    test('should return tv series list when call to data source is successful',
        () async {
      // arrange
      when(
        mockTvSeriesRemoteDataSource.searchTvSeries(tQuery),
      ).thenAnswer((_) async => tSeriesModelList);
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tSeriesList));
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(
        mockTvSeriesRemoteDataSource.searchTvSeries(tQuery),
      ).thenThrow(ServerException());
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(
        mockTvSeriesRemoteDataSource.searchTvSeries(tQuery),
      ).thenThrow(
        const SocketException('Failed to connect to the network'),
      );
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(
        result,
        const Left(
          ConnectionFailure('Failed to connect to the network'),
        ),
      );
    });
  });

  group('Save TV Series to watchlist Tests', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(
        mockTvSeriesLocalDataSource.insertWatchlist(testTvSeriesTable),
      ).thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testSeriesDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(
        mockTvSeriesLocalDataSource.insertWatchlist(testTvSeriesTable),
      ).thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testSeriesDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove TV Series from watchlist Tests', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(
        mockTvSeriesLocalDataSource.removeWatchlist(testTvSeriesTable),
      ).thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testSeriesDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(
        mockTvSeriesLocalDataSource.removeWatchlist(testTvSeriesTable),
      ).thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testSeriesDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('Get watchlist status Tests', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(
        mockTvSeriesLocalDataSource.getTvSeriesById(tId),
      ).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('Get watchlist TV Series Tests', () {
    test('should return list of TV Series', () async {
      // arrange
      when(
        mockTvSeriesLocalDataSource.getWatchlistTvSeries(),
      ).thenAnswer((_) async => [testTvSeriesTable]);
      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals([testWatchlistSeries]));
    });
  });
}
