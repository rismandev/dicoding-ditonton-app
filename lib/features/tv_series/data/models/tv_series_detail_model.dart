import 'package:ditonton/features/tv_series/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

import '../../../genre/data/models/genre_model.dart';
import 'season_model.dart';

class TvSeriesDetailModel extends Equatable {
  final int? id;
  final bool? adult;
  final String? backdropPath;
  final String? firstAirDate;
  final List<GenreModel> genres;
  final String? homepage;
  final bool? inProduction;
  final String? lastAirDate;
  final String? name;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<SeasonModel> seasons;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  const TvSeriesDetailModel({
    required this.id,
    required this.adult,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.inProduction,
    required this.lastAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.seasons,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'adult': adult,
      'backdrop_path': backdropPath,
      'first_air_date': firstAirDate,
      'genres': List<dynamic>.from(genres.map((x) => x.toJson())),
      'homepage': homepage,
      'in_production': inProduction,
      'last_air_date': lastAirDate,
      'name': name,
      'number_of_episodes': numberOfEpisodes,
      'number_of_seasons': numberOfSeasons,
      'origin_country': originCountry,
      'original_language': originalLanguage,
      'original_name': originalName,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'seasons': List<dynamic>.from(seasons.map((x) => x.toMap())),
      'status': status,
      'tagline': tagline,
      'type': type,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  factory TvSeriesDetailModel.fromMap(Map<String, dynamic> map) {
    return TvSeriesDetailModel(
      id: map['id'],
      adult: map['adult'],
      backdropPath: map['backdrop_path'],
      firstAirDate: map['first_air_date'],
      genres: List<GenreModel>.from(
        map["genres"].map((x) => GenreModel.fromJson(x)),
      ),
      homepage: map['homepage'],
      inProduction: map['in_production'],
      lastAirDate: map['last_air_date'],
      name: map['name'],
      numberOfEpisodes: map['number_of_episodes'],
      numberOfSeasons: map['number_of_seasons'],
      originCountry: List<String>.from((map['origin_country'])),
      originalLanguage: map['original_language'],
      originalName: map['original_name'],
      overview: map['overview'],
      popularity: map['popularity'],
      posterPath: map['poster_path'],
      seasons: List<SeasonModel>.from(
        map["seasons"].map((x) => SeasonModel.fromMap(x)),
      ),
      status: map['status'],
      tagline: map['tagline'],
      type: map['type'],
      voteAverage: map['vote_average'],
      voteCount: map['vote_count'],
    );
  }

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      id: id ?? 0,
      adult: adult ?? false,
      backdropPath: backdropPath,
      firstAirDate: firstAirDate ?? "",
      genres: genres.map((genre) => genre.toEntity()).toList(),
      lastAirDate: lastAirDate ?? "",
      name: name ?? "",
      numberOfEpisodes: numberOfEpisodes ?? 0,
      numberOfSeasons: numberOfSeasons ?? 0,
      originalLanguage: originalLanguage ?? "",
      originalName: originalName ?? "",
      overview: overview ?? "",
      popularity: popularity ?? 0.0,
      posterPath: posterPath,
      seasons: seasons.map((s) => s.toEntity()).toList(),
      voteAverage: voteAverage ?? 0.0,
      voteCount: voteCount ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        id,
        adult,
        backdropPath,
        firstAirDate,
        genres,
        homepage,
        inProduction,
        lastAirDate,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        seasons,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}
