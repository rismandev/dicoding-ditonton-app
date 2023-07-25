import 'dart:async';

import 'package:ditonton/common/db_helper.dart';

import '../../models/movie_table.dart';

class MovieDBHelper {
  final DatabaseHelper databaseHelper;

  MovieDBHelper(this.databaseHelper);

  static const String tblWatchlist = 'watchlist';

  Future<bool> isDatabaseOpened() async {
    final db = await databaseHelper.database;
    return db?.isOpen ?? false;
  }

  Future<int> insertWatchlist(MovieTable movie) async {
    return databaseHelper.onInsert(tblWatchlist, movie.toJson());
  }

  Future<int> removeWatchlist(MovieTable movie) async {
    return databaseHelper.onDelete(tblWatchlist, movie.id);
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    return databaseHelper.getById(tblWatchlist, id);
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    return databaseHelper.onSelect(tblWatchlist);
  }
}
