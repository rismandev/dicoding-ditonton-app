import 'package:ditonton/features/tv_series/presentation/pages/detail_tv_series_page.dart';
import 'package:ditonton/features/tv_series/presentation/pages/home_tv_series_page.dart';
import 'package:ditonton/features/tv_series/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/features/tv_series/presentation/pages/search_tv_series_page.dart';
import 'package:ditonton/features/tv_series/presentation/pages/top_rated_tv_series_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../features/movie/presentation/pages/about_page.dart';
import '../features/movie/presentation/pages/home_movie_page.dart';
import '../features/movie/presentation/pages/movie_detail_page.dart';
import '../features/movie/presentation/pages/popular_movies_page.dart';
import '../features/movie/presentation/pages/search_page.dart';
import '../features/movie/presentation/pages/top_rated_movies_page.dart';
import '../features/movie/presentation/pages/watchlist_movies_page.dart';
import '../features/tv_series/presentation/pages/airing_today_tv_series_page.dart';
import '../features/tv_series/presentation/pages/watchlist_tv_series_page.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeMoviePage.routeName:
      return MaterialPageRoute(builder: (_) => const HomeMoviePage());
    case PopularMoviesPage.routeName:
      return CupertinoPageRoute(builder: (_) => const PopularMoviesPage());
    case TopRatedMoviesPage.routeName:
      return CupertinoPageRoute(builder: (_) => const TopRatedMoviesPage());
    case MovieDetailPage.routeName:
      final id = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => MovieDetailPage(id: id),
        settings: settings,
      );
    case SearchPage.routeName:
      return CupertinoPageRoute(builder: (_) => const SearchPage());
    case WatchlistMoviesPage.routeName:
      return MaterialPageRoute(builder: (_) => const WatchlistMoviesPage());
    case AboutPage.routeName:
      return MaterialPageRoute(builder: (_) => const AboutPage());
    case HomeTvSeriesPage.routeName:
      return MaterialPageRoute(builder: (_) => const HomeTvSeriesPage());
    case AiringTodayTvSeriesPage.routeName:
      return MaterialPageRoute(builder: (_) => const AiringTodayTvSeriesPage());
    case PopularTvSeriesPage.routeName:
      return MaterialPageRoute(builder: (_) => const PopularTvSeriesPage());
    case TopRatedTvSeriesPage.routeName:
      return MaterialPageRoute(builder: (_) => const TopRatedTvSeriesPage());
    case SearchTvSeriesPage.routeName:
      return MaterialPageRoute(builder: (_) => const SearchTvSeriesPage());
    case WatchlistTvSeriesPage.routeName:
      return MaterialPageRoute(builder: (_) => const WatchlistTvSeriesPage());
    case DetailTvSeriesPage.routeName:
      final id = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => DetailTvSeriesPage(id: id),
        settings: settings,
      );
    default:
      return MaterialPageRoute(builder: (_) {
        return const Scaffold(
          body: Center(
            child: Text('Page not found :('),
          ),
        );
      });
  }
}
