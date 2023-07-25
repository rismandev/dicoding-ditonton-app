import 'package:ditonton/common/db_helper.dart';
import 'package:ditonton/features/movie/data/datasources/db/database_helper.dart';
import 'package:ditonton/features/tv_series/data/datasources/db/database_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../../../helpers/test_helper.mocks.dart';
import '../../../dummy_data/dummy_objects.dart';

void main() async {
  late MockDatabaseHelper mockDatabaseHelper;
  late TvSeriesDBHelper tvSeriesDBHelper;
  late String databasePath;

  setUp(() async {
    sqfliteFfiInit();
    databaseFactoryOrNull = databaseFactoryFfi;
    final path = await getDatabasesPath();
    databasePath = '$path/ditonton.db';
    mockDatabaseHelper = MockDatabaseHelper();
    tvSeriesDBHelper = TvSeriesDBHelper(mockDatabaseHelper);
  });

  void onCreateTable1(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  ${MovieDBHelper.tblWatchlist} (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  void onCreateTable2(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  ${TvSeriesDBHelper.tblWatchlist} (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT,
        firstAirDate TEXT
      );
    ''');
  }

  void arrangeDb() {
    when(mockDatabaseHelper.database).thenAnswer(
      (_) => openDatabase(
        databasePath,
        version: DatabaseHelper.databaseVersion,
        onCreate: (db, version) {
          onCreateTable1(db, version);
          onCreateTable2(db, version);
        },
      ),
    );
    when(
      mockDatabaseHelper.initDb(),
    ).thenAnswer(
      (_) => openDatabase(
        databasePath,
        version: DatabaseHelper.databaseVersion,
        onCreate: (db, version) {
          onCreateTable1(db, version);
          onCreateTable2(db, version);
        },
      ),
    );
  }

  group('TvSeriesDBHelper Tests', () {
    setUp(() {
      arrangeDb();
    });

    test('should database has been opened', () async {
      // arrange
      // act
      final isDbOpen = await tvSeriesDBHelper.isDatabaseOpened();
      // assert
      expect(isDbOpen, true);
    });

    test('should change when insert watchlist is successfull', () async {
      // arrange
      when(
        mockDatabaseHelper.onInsert(
          TvSeriesDBHelper.tblWatchlist,
          testTvSeriesMap,
        ),
      ).thenAnswer((_) => Future.value(1));
      // act
      final isInsertInt = await tvSeriesDBHelper.insertWatchlist(
        testTvSeriesTable,
      );
      // assert
      verify(mockDatabaseHelper.onInsert(
        TvSeriesDBHelper.tblWatchlist,
        testTvSeriesMap,
      ));
      expect(isInsertInt, 1);
    });

    test('should change when remove watchlist is successfull', () async {
      // arrange
      when(
        mockDatabaseHelper.onDelete(
          TvSeriesDBHelper.tblWatchlist,
          testTvSeriesTable.id,
        ),
      ).thenAnswer((_) => Future.value(1));
      // act
      final isRemoved = await tvSeriesDBHelper.removeWatchlist(
        testTvSeriesTable,
      );
      // assert
      verify(mockDatabaseHelper.onDelete(
        TvSeriesDBHelper.tblWatchlist,
        testTvSeriesTable.id,
      ));
      expect(isRemoved, 1);
    });

    test('should change data tv series when is gotten successfully', () async {
      final tId = testTvSeriesTable.id;
      // arrange
      when(
        mockDatabaseHelper.getById(TvSeriesDBHelper.tblWatchlist, tId),
      ).thenAnswer((_) => Future.value(testTvSeriesMap));
      // act
      final result = await tvSeriesDBHelper.getTvSeriesById(tId);
      // assert
      verify(mockDatabaseHelper.getById(TvSeriesDBHelper.tblWatchlist, tId));
      expect(result, equals(testTvSeriesMap));
    });

    test('should change list of tv series when is gotten successfully',
        () async {
      // arrange
      when(
        mockDatabaseHelper.onSelect(TvSeriesDBHelper.tblWatchlist),
      ).thenAnswer((_) => Future.value([testTvSeriesMap]));
      // act
      final result = await tvSeriesDBHelper.getWatchlistTvSeries();
      // assert
      verify(mockDatabaseHelper.onSelect(TvSeriesDBHelper.tblWatchlist));
      expect(result, equals([testTvSeriesMap]));
    });
  });
}
