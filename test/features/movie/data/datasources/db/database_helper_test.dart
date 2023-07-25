import 'package:ditonton/common/db_helper.dart';
import 'package:ditonton/features/movie/data/datasources/db/database_helper.dart';
import 'package:ditonton/features/tv_series/data/datasources/db/database_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../../../helpers/test_helper.mocks.dart';
import '../../../dummy_data/dummy_objects.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late MovieDBHelper movieDBHelper;
  late String databasePath;

  setUp(() async {
    sqfliteFfiInit();
    databaseFactoryOrNull = databaseFactoryFfi;
    final path = await getDatabasesPath();
    databasePath = '$path/ditonton.db';
    mockDatabaseHelper = MockDatabaseHelper();
    movieDBHelper = MovieDBHelper(mockDatabaseHelper);
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

  group('MovieDBHelper Tests', () {
    setUp(() {
      arrangeDb();
    });

    test('should database has been opened', () async {
      // arrange
      // act
      final isDbOpen = await movieDBHelper.isDatabaseOpened();
      // assert
      expect(isDbOpen, true);
    });

    test('should change when insert watchlist is successfull', () async {
      // arrange
      when(
        mockDatabaseHelper.onInsert(
          MovieDBHelper.tblWatchlist,
          testMovieMap,
        ),
      ).thenAnswer((_) => Future.value(1));
      // act
      final isInsertInt = await movieDBHelper.insertWatchlist(
        testMovieTable,
      );
      // assert
      verify(mockDatabaseHelper.onInsert(
        MovieDBHelper.tblWatchlist,
        testMovieMap,
      ));
      expect(isInsertInt, 1);
    });

    test('should change when remove watchlist is successfull', () async {
      // arrange
      when(
        mockDatabaseHelper.onDelete(
          MovieDBHelper.tblWatchlist,
          testMovieTable.id,
        ),
      ).thenAnswer((_) => Future.value(1));
      // act
      final isRemoved = await movieDBHelper.removeWatchlist(
        testMovieTable,
      );
      // assert
      verify(mockDatabaseHelper.onDelete(
        MovieDBHelper.tblWatchlist,
        testMovieTable.id,
      ));
      expect(isRemoved, 1);
    });

    test('should change data tv series when is gotten successfully', () async {
      final tId = testMovieTable.id;
      // arrange
      when(
        mockDatabaseHelper.getById(MovieDBHelper.tblWatchlist, tId),
      ).thenAnswer((_) => Future.value(testMovieMap));
      // act
      final result = await movieDBHelper.getMovieById(tId);
      // assert
      verify(mockDatabaseHelper.getById(MovieDBHelper.tblWatchlist, tId));
      expect(result, equals(testMovieMap));
    });

    test('should change list of tv series when is gotten successfully',
        () async {
      // arrange
      when(
        mockDatabaseHelper.onSelect(MovieDBHelper.tblWatchlist),
      ).thenAnswer((_) => Future.value([testMovieMap]));
      // act
      final result = await movieDBHelper.getWatchlistMovies();
      // assert
      verify(mockDatabaseHelper.onSelect(MovieDBHelper.tblWatchlist));
      expect(result, equals([testMovieMap]));
    });
  });
}
