import 'package:equatable/equatable.dart';

import 'tv_series_model.dart';

class TvSeriesResponse extends Equatable {
  final List<TvSeriesModel> tvSeriesList;

  const TvSeriesResponse({required this.tvSeriesList});

  factory TvSeriesResponse.fromMap(Map<String, dynamic> map) {
    final List<dynamic> resultList = map['results'] ?? [];

    return TvSeriesResponse(
      tvSeriesList: List<TvSeriesModel>.from(
        resultList
            .map((x) => TvSeriesModel.fromMap(x))
            .where((element) => element.posterPath != null),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        "results": List<dynamic>.from(tvSeriesList.map((x) => x.toMap())),
      };

  @override
  List<Object> get props => [tvSeriesList];
}
