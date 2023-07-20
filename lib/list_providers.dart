import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

import 'features/movie/presentation/provider/movie_detail_notifier.dart';
import 'features/movie/presentation/provider/movie_list_notifier.dart';
import 'features/movie/presentation/provider/movie_search_notifier.dart';
import 'features/movie/presentation/provider/popular_movies_notifier.dart';
import 'features/movie/presentation/provider/top_rated_movies_notifier.dart';
import 'features/movie/presentation/provider/watchlist_movie_notifier.dart';

List<ChangeNotifierProvider> listProviders = [
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
];
