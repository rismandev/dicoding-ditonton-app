import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/features/tv_series/domain/repositories/tv_series_repository.dart';

class SaveTvSeriesToWatchlist {
  final TvSeriesRepository repository;

  SaveTvSeriesToWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries) {
    return repository.saveWatchlist(tvSeries);
  }
}
