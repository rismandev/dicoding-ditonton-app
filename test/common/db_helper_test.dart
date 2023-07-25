import 'package:ditonton/features/tv_series/data/datasources/db/database_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/common/db_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../features/tv_series/dummy_data/dummy_objects.dart';

void main() {
  late DatabaseHelper databaseHelper;

  setUp(() {
    sqfliteFfiInit();
    databaseFactoryOrNull = databaseFactoryFfi;
    databaseHelper = DatabaseHelper();
  });

  test('test database should success initialized', () async {
    // arrange
    // act
    final db = await databaseHelper.database;
    final isInit = await databaseHelper.initDb();
    // assert
    expect(db, isNotNull);
    expect(isInit, isNotNull);
  });

  test('test insert data', () async {
    // arrange
    // act
    final insertData = await databaseHelper.onInsert(
      TvSeriesDBHelper.tblWatchlist,
      testTvSeriesMap,
    );
    // assert
    expect(insertData, 1);
  });

  test('test select data', () async {
    // arrange
    // act
    final result = await databaseHelper.onSelect(TvSeriesDBHelper.tblWatchlist);
    // assert
    expect(result, [testTvSeriesMap]);
  });

  test('test select data by id', () async {
    // arrange
    // act
    final result = await databaseHelper.getById(
      TvSeriesDBHelper.tblWatchlist,
      testTvSeriesTable.id,
    );
    // assert
    expect(result, testTvSeriesMap);
  });

  test('test remove data', () async {
    // arrange
    // act
    final removeData = await databaseHelper.onDelete(
      TvSeriesDBHelper.tblWatchlist,
      testTvSeriesTable.id,
    );
    // assert
    expect(removeData, 1);
  });
}
