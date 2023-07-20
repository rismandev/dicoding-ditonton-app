import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_series.dart';
import '../../domain/entities/tv_series_detail.dart';

class TvSeriesTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;
  final String? firstAirDate;

  TvSeriesTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
    required this.firstAirDate,
  });

  factory TvSeriesTable.fromEntity(TvSeriesDetail tvSeries) => TvSeriesTable(
        id: tvSeries.id,
        name: tvSeries.name,
        posterPath: tvSeries.posterPath,
        overview: tvSeries.overview,
        firstAirDate: tvSeries.firstAirDate,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'posterPath': posterPath,
      'overview': overview,
      'firstAirDate': firstAirDate,
    };
  }

  factory TvSeriesTable.fromMap(Map<String, dynamic> map) {
    return TvSeriesTable(
      id: map['id'],
      name: map['name'],
      posterPath: map['posterPath'],
      overview: map['overview'],
      firstAirDate: map['firstAirDate'],
    );
  }

  TvSeries toEntity() => TvSeries.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
        firstAirDate: firstAirDate,
      );

  @override
  List<Object?> get props => [id, name, posterPath, overview, firstAirDate];
}
