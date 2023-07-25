import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_airing_today_tv_series.dart';
import 'package:flutter/cupertino.dart';

class AiringTodayTvSeriesNotifier extends ChangeNotifier {
  final GetAiringTodayTvSeries getAiringTodayTvSeries;

  AiringTodayTvSeriesNotifier({required this.getAiringTodayTvSeries});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<TvSeries> _tvSeries = [];
  List<TvSeries> get tvSeries => _tvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchAiringTodayTvSeries() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getAiringTodayTvSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvSeriesData) {
        _tvSeries = tvSeriesData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
