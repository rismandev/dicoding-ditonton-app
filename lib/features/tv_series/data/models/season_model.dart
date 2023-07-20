import 'package:ditonton/features/tv_series/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  final String? airDate;
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;

  SeasonModel({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
    this.voteAverage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'air_date': airDate,
      'episode_count': episodeCount,
      'id': id,
      'name': name,
      'overview': overview,
      'poster_path': posterPath,
      'season_number': seasonNumber,
      'vote_average': voteAverage,
    };
  }

  factory SeasonModel.fromMap(Map<String, dynamic> map) {
    return SeasonModel(
      airDate: map['air_date'],
      episodeCount: map['episode_count'],
      id: map['id'],
      name: map['name'],
      overview: map['overview'],
      posterPath: map['poster_path'],
      seasonNumber: map['season_number'],
      voteAverage: map['vote_average'],
    );
  }

  Season toEntity() {
    return Season(
      airDate: airDate ?? "",
      episodeCount: episodeCount ?? 0,
      id: id ?? 0,
      name: name ?? "",
      overview: overview ?? "",
      posterPath: posterPath,
      seasonNumber: seasonNumber ?? 0,
      voteAverage: voteAverage ?? 0.0,
    );
  }

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
        voteAverage,
      ];
}
