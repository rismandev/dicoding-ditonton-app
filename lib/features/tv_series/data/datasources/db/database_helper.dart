import 'dart:async';

import 'package:ditonton/common/db_helper.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_table.dart';

class TvSeriesDBHelper {
  final DatabaseHelper databaseHelper;

  TvSeriesDBHelper(this.databaseHelper);

  static const String tblWatchlist = 'tv_watchlist';

  Future<bool> isDatabaseOpened() async {
    final db = await databaseHelper.database;
    return db?.isOpen ?? false;
  }

  Future<int> insertWatchlist(TvSeriesTable tvSeries) async {
    return databaseHelper.onInsert(tblWatchlist, tvSeries.toMap());
  }

  Future<int> removeWatchlist(TvSeriesTable tvSeries) async {
    return databaseHelper.onDelete(tblWatchlist, tvSeries.id);
  }

  Future<Map<String, dynamic>?> getTvSeriesById(int id) async {
    return databaseHelper.getById(tblWatchlist, id);
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvSeries() async {
    return databaseHelper.onSelect(tblWatchlist);
  }
}
