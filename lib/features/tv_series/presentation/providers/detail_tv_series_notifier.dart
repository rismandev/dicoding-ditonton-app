import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_detail_tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_recommendation_tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/remove_tv_series_from_watchlist.dart';
import 'package:ditonton/features/tv_series/domain/usecases/save_tv_series_to_watchlist.dart';
import 'package:flutter/cupertino.dart';

class DetailTvSeriesNotifier extends ChangeNotifier {
  final GetDetailTvSeries getDetailTvSeries;
  final GetRecommendationTvSeries getRecommendationTvSeries;
  final SaveTvSeriesToWatchlist saveTvSeriesToWatchlist;
  final RemoveTvSeriesFromWatchlist removeTvSeriesFromWatchlist;
  final GetWatchlistStatusTvSeries getWatchlistStatusTvSeries;

  DetailTvSeriesNotifier({
    required this.getDetailTvSeries,
    required this.getRecommendationTvSeries,
    required this.saveTvSeriesToWatchlist,
    required this.removeTvSeriesFromWatchlist,
    required this.getWatchlistStatusTvSeries,
  });

  late TvSeriesDetail _tvSeries;
  TvSeriesDetail get tvSeries => _tvSeries;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<TvSeries> _tvSeriesRecommendations = [];
  List<TvSeries> get tvSeriesRecommendations => _tvSeriesRecommendations;

  RequestState _recommendationState = RequestState.empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchDetailTvSeries(int id) async {
    _state = RequestState.loading;
    notifyListeners();

    final detailResult = await getDetailTvSeries.execute(id);
    final recommendationResult = await getRecommendationTvSeries.execute(id);

    detailResult.fold(
      (failure) {
        _state = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _recommendationState = RequestState.loading;
        _tvSeries = tvSeries;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.error;
            _message = failure.message;
          },
          (tvSeriesData) {
            _recommendationState = RequestState.loaded;
            _tvSeriesRecommendations = tvSeriesData;
          },
        );
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  Future<void> addWatchlist(TvSeriesDetail tvSeries) async {
    final result = await saveTvSeriesToWatchlist.execute(tvSeries);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeries.id);
  }

  Future<void> removeFromWatchlist(TvSeriesDetail tvSeries) async {
    final result = await removeTvSeriesFromWatchlist.execute(tvSeries);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeries.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchlistStatusTvSeries.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
