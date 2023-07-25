// Mocks generated by Mockito 5.4.2 from annotations
// in ditonton/test/features/tv_series/presentation/providers/detail_tv_series_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:ditonton/common/failure.dart' as _i6;
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart'
    as _i9;
import 'package:ditonton/features/tv_series/domain/entities/tv_series_detail.dart'
    as _i7;
import 'package:ditonton/features/tv_series/domain/repositories/tv_series_repository.dart'
    as _i2;
import 'package:ditonton/features/tv_series/domain/usecases/get_detail_tv_series.dart'
    as _i4;
import 'package:ditonton/features/tv_series/domain/usecases/get_recommendation_tv_series.dart'
    as _i8;
import 'package:ditonton/features/tv_series/domain/usecases/get_watchlist_status_tv_series.dart'
    as _i13;
import 'package:ditonton/features/tv_series/domain/usecases/get_watchlist_tv_series.dart'
    as _i12;
import 'package:ditonton/features/tv_series/domain/usecases/remove_tv_series_from_watchlist.dart'
    as _i11;
import 'package:ditonton/features/tv_series/domain/usecases/save_tv_series_to_watchlist.dart'
    as _i10;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTvSeriesRepository_0 extends _i1.SmartFake
    implements _i2.TvSeriesRepository {
  _FakeTvSeriesRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetDetailTvSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetDetailTvSeries extends _i1.Mock implements _i4.GetDetailTvSeries {
  MockGetDetailTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.TvSeriesDetail>> execute(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, _i7.TvSeriesDetail>>.value(
                _FakeEither_1<_i6.Failure, _i7.TvSeriesDetail>(
          this,
          Invocation.method(
            #execute,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.TvSeriesDetail>>);
}

/// A class which mocks [GetRecommendationTvSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetRecommendationTvSeries extends _i1.Mock
    implements _i8.GetRecommendationTvSeries {
  MockGetRecommendationTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.TvSeries>>> execute(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i9.TvSeries>>>.value(
                _FakeEither_1<_i6.Failure, List<_i9.TvSeries>>(
          this,
          Invocation.method(
            #execute,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i9.TvSeries>>>);
}

/// A class which mocks [SaveTvSeriesToWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveTvSeriesToWatchlist extends _i1.Mock
    implements _i10.SaveTvSeriesToWatchlist {
  MockSaveTvSeriesToWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(
          _i7.TvSeriesDetail? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [tvSeries],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
            _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [tvSeries],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

/// A class which mocks [RemoveTvSeriesFromWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveTvSeriesFromWatchlist extends _i1.Mock
    implements _i11.RemoveTvSeriesFromWatchlist {
  MockRemoveTvSeriesFromWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(
          _i7.TvSeriesDetail? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [tvSeries],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
            _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [tvSeries],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

/// A class which mocks [GetWatchlistTvSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistTvSeries extends _i1.Mock
    implements _i12.GetWatchlistTvSeries {
  MockGetWatchlistTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.TvSeries>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i9.TvSeries>>>.value(
                _FakeEither_1<_i6.Failure, List<_i9.TvSeries>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i9.TvSeries>>>);
}

/// A class which mocks [GetWatchlistStatusTvSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistStatusTvSeries extends _i1.Mock
    implements _i13.GetWatchlistStatusTvSeries {
  MockGetWatchlistStatusTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvSeriesRepository);
  @override
  _i5.Future<bool> execute(int? id) => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}
