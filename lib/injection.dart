import 'package:ditonton/common/db_helper.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'features/movie/data/datasources/db/database_helper.dart';
import 'features/movie/data/datasources/movie_local_data_source.dart';
import 'features/movie/data/datasources/movie_remote_data_source.dart';
import 'features/movie/data/repositories/movie_repository_impl.dart';
import 'features/movie/domain/repositories/movie_repository.dart';
import 'features/movie/domain/usecases/get_movie_detail.dart';
import 'features/movie/domain/usecases/get_movie_recommendations.dart';
import 'features/movie/domain/usecases/get_now_playing_movies.dart';
import 'features/movie/domain/usecases/get_popular_movies.dart';
import 'features/movie/domain/usecases/get_top_rated_movies.dart';
import 'features/movie/domain/usecases/get_watchlist_movies.dart';
import 'features/movie/domain/usecases/get_watchlist_status.dart';
import 'features/movie/domain/usecases/remove_watchlist.dart';
import 'features/movie/domain/usecases/save_watchlist.dart';
import 'features/movie/domain/usecases/search_movies.dart';
import 'features/movie/presentation/provider/movie_detail_notifier.dart';
import 'features/movie/presentation/provider/movie_list_notifier.dart';
import 'features/movie/presentation/provider/movie_search_notifier.dart';
import 'features/movie/presentation/provider/popular_movies_notifier.dart';
import 'features/movie/presentation/provider/top_rated_movies_notifier.dart';
import 'features/movie/presentation/provider/watchlist_movie_notifier.dart';
import 'features/tv_series/data/datasources/db/database_helper.dart';
import 'features/tv_series/data/repositories/tv_series_repository_impl.dart';
import 'features/tv_series/data/datasources/tv_series_local_data_source.dart';
import 'features/tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'features/tv_series/domain/repositories/tv_series_repository.dart';
import 'features/tv_series/domain/usecases/get_airing_today_tv_series.dart';
import 'features/tv_series/domain/usecases/get_detail_tv_series.dart';
import 'features/tv_series/domain/usecases/get_popular_tv_series.dart';
import 'features/tv_series/domain/usecases/get_recommendation_tv_series.dart';
import 'features/tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'features/tv_series/domain/usecases/get_watchlist_status_tv_series.dart';
import 'features/tv_series/domain/usecases/remove_tv_series_from_watchlist.dart';
import 'features/tv_series/domain/usecases/save_tv_series_to_watchlist.dart';
import 'features/tv_series/domain/usecases/get_watchlist_tv_series.dart';
import 'features/tv_series/domain/usecases/search_tv_series.dart';
import 'features/tv_series/presentation/providers/airing_today_tv_series_notifier.dart';
import 'features/tv_series/presentation/providers/detail_tv_series_notifier.dart';
import 'features/tv_series/presentation/providers/popular_tv_series_notifier.dart';
import 'features/tv_series/presentation/providers/search_tv_series_notifier.dart';
import 'features/tv_series/presentation/providers/top_rated_tv_series_notifier.dart';
import 'features/tv_series/presentation/providers/tv_series_list_notifier.dart';
import 'features/tv_series/presentation/providers/watchlist_tv_series_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider movies
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  // provider tv series
  locator.registerFactory(
    () => TvSeriesListNotifier(
      getAiringTodayTvSeries: locator(),
      getPopularTvSeries: locator(),
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => DetailTvSeriesNotifier(
      getDetailTvSeries: locator(),
      getRecommendationTvSeries: locator(),
      saveTvSeriesToWatchlist: locator(),
      removeTvSeriesFromWatchlist: locator(),
      getWatchlistStatusTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTvSeriesNotifier(
      searchTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvSeriesNotifier(
      getPopularTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvSeriesNotifier(
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => AiringTodayTvSeriesNotifier(
      getAiringTodayTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvSeriesNotifier(
      getWatchlistTvSeries: locator(),
    ),
  );

  // use case movies
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  // use case tv series
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetAiringTodayTvSeries(locator()));
  locator.registerLazySingleton(() => GetDetailTvSeries(locator()));
  locator.registerLazySingleton(() => GetRecommendationTvSeries(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => SaveTvSeriesToWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvSeriesFromWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistStatusTvSeries(locator()));

  // repository movies
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  // repository tv series
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources movies
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(databaseHelper: locator()),
  );
  // data sources tv series
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
    () => TvSeriesRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
    () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()),
  );

  // helper db
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  // helper movies
  locator.registerLazySingleton<MovieDBHelper>(() => MovieDBHelper(locator()));
  // helper tv series
  locator.registerLazySingleton<TvSeriesDBHelper>(
    () => TvSeriesDBHelper(locator()),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
