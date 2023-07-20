import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../features/movie/presentation/pages/about_page.dart';
import '../features/movie/presentation/pages/home_movie_page.dart';
import '../features/movie/presentation/pages/movie_detail_page.dart';
import '../features/movie/presentation/pages/popular_movies_page.dart';
import '../features/movie/presentation/pages/search_page.dart';
import '../features/movie/presentation/pages/top_rated_movies_page.dart';
import '../features/movie/presentation/pages/watchlist_movies_page.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeMoviePage.ROUTE_NAME:
      return MaterialPageRoute(builder: (_) => HomeMoviePage());
    case PopularMoviesPage.ROUTE_NAME:
      return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
    case TopRatedMoviesPage.ROUTE_NAME:
      return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
    case MovieDetailPage.ROUTE_NAME:
      final id = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => MovieDetailPage(id: id),
        settings: settings,
      );
    case SearchPage.ROUTE_NAME:
      return CupertinoPageRoute(builder: (_) => SearchPage());
    case WatchlistMoviesPage.ROUTE_NAME:
      return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
    case AboutPage.ROUTE_NAME:
      return MaterialPageRoute(builder: (_) => AboutPage());
    default:
      return MaterialPageRoute(builder: (_) {
        return Scaffold(
          body: Center(
            child: Text('Page not found :('),
          ),
        );
      });
  }
}
