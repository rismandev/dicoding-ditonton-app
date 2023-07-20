import 'package:equatable/equatable.dart';

import '../../../genre/domain/entities/genre.dart';
import 'season.dart';

class TvSeriesDetail extends Equatable {
  final int id;
  final bool adult;
  final String? backdropPath;
  final String firstAirDate;
  final List<Genre> genres;
  final String lastAirDate;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<Season> seasons;
  final double voteAverage;
  final int voteCount;

  TvSeriesDetail({
    required this.id,
    required this.adult,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.lastAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.seasons,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        id,
        adult,
        backdropPath,
        firstAirDate,
        genres,
        lastAirDate,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        seasons,
        voteAverage,
        voteCount,
      ];
}
