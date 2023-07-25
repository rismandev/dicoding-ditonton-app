import 'package:ditonton/features/tv_series/presentation/providers/tv_series_list_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

import 'features/movie/presentation/provider/movie_detail_notifier.dart';
import 'features/movie/presentation/provider/movie_list_notifier.dart';
import 'features/movie/presentation/provider/movie_search_notifier.dart';
import 'features/movie/presentation/provider/popular_movies_notifier.dart';
import 'features/movie/presentation/provider/top_rated_movies_notifier.dart';
import 'features/movie/presentation/provider/watchlist_movie_notifier.dart';
import 'features/tv_series/presentation/providers/airing_today_tv_series_notifier.dart';
import 'features/tv_series/presentation/providers/detail_tv_series_notifier.dart';
import 'features/tv_series/presentation/providers/popular_tv_series_notifier.dart';
import 'features/tv_series/presentation/providers/search_tv_series_notifier.dart';
import 'features/tv_series/presentation/providers/top_rated_tv_series_notifier.dart';
import 'features/tv_series/presentation/providers/watchlist_tv_series_notifier.dart';

class InitProviderWidget extends StatelessWidget {
  const InitProviderWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<DetailTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SearchTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<AiringTodayTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvSeriesNotifier>(),
        ),
      ],
      child: child,
    );
  }
}
