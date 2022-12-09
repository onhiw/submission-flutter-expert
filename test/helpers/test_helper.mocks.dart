// Mocks generated by Mockito 5.3.0 from annotations
// in ditonton/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;
import 'dart:convert' as _i27;
import 'dart:io' as _i5;
import 'dart:typed_data' as _i28;

import 'package:dartz/dartz.dart' as _i2;
import 'package:ditonton/common/failure.dart' as _i10;
import 'package:ditonton/common/ssl_pinning.dart' as _i26;
import 'package:ditonton/data/datasources/db/database_helper.dart' as _i24;
import 'package:ditonton/data/datasources/movie_local_data_source.dart' as _i15;
import 'package:ditonton/data/datasources/movie_remote_data_source.dart'
    as _i13;
import 'package:ditonton/data/datasources/tv_local_data_source.dart' as _i22;
import 'package:ditonton/data/datasources/tv_remote_data_source.dart' as _i20;
import 'package:ditonton/data/models/movie_detail_model.dart' as _i3;
import 'package:ditonton/data/models/movie_model.dart' as _i14;
import 'package:ditonton/data/models/movie_table.dart' as _i16;
import 'package:ditonton/data/models/tv_detail_model.dart' as _i4;
import 'package:ditonton/data/models/tv_model.dart' as _i21;
import 'package:ditonton/data/models/tv_table.dart' as _i23;
import 'package:ditonton/domain/entities/movie.dart' as _i11;
import 'package:ditonton/domain/entities/movie_detail.dart' as _i12;
import 'package:ditonton/domain/entities/tv.dart' as _i18;
import 'package:ditonton/domain/entities/tv_detail.dart' as _i19;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i8;
import 'package:ditonton/domain/repositories/tv_repository.dart' as _i17;
import 'package:http/http.dart' as _i6;
import 'package:http/io_client.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i25;

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

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeMovieDetailResponse_1 extends _i1.SmartFake
    implements _i3.MovieDetailResponse {
  _FakeMovieDetailResponse_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeTvDetailResponse_2 extends _i1.SmartFake
    implements _i4.TvDetailResponse {
  _FakeTvDetailResponse_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeSecurityContext_3 extends _i1.SmartFake
    implements _i5.SecurityContext {
  _FakeSecurityContext_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeResponse_4 extends _i1.SmartFake implements _i6.Response {
  _FakeResponse_4(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeIOStreamedResponse_5 extends _i1.SmartFake
    implements _i7.IOStreamedResponse {
  _FakeIOStreamedResponse_5(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i8.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>
      getNowPlayingMovies() => (super.noSuchMethod(
              Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i11.Movie>>(
                          this, Invocation.method(#getNowPlayingMovies, []))))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
              returnValue:
                  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i11.Movie>>(
                          this, Invocation.method(#getPopularMovies, []))))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
              returnValue:
                  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i11.Movie>>(
                          this, Invocation.method(#getTopRatedMovies, []))))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, _i12.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue:
                  _i9.Future<_i2.Either<_i10.Failure, _i12.MovieDetail>>.value(
                      _FakeEither_0<_i10.Failure, _i12.MovieDetail>(
                          this, Invocation.method(#getMovieDetail, [id]))))
          as _i9.Future<_i2.Either<_i10.Failure, _i12.MovieDetail>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>
      getMovieRecommendations(int? id) => (super.noSuchMethod(
              Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i11.Movie>>(this,
                          Invocation.method(#getMovieRecommendations, [id]))))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i11.Movie>>(
                          this, Invocation.method(#searchMovies, [query]))))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, String>> saveWatchlist(
          _i12.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: _i9.Future<_i2.Either<_i10.Failure, String>>.value(
                  _FakeEither_0<_i10.Failure, String>(
                      this, Invocation.method(#saveWatchlist, [movie]))))
          as _i9.Future<_i2.Either<_i10.Failure, String>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, String>> removeWatchlist(
          _i12.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: _i9.Future<_i2.Either<_i10.Failure, String>>.value(
                  _FakeEither_0<_i10.Failure, String>(
                      this, Invocation.method(#removeWatchlist, [movie]))))
          as _i9.Future<_i2.Either<_i10.Failure, String>>);
  @override
  _i9.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: _i9.Future<bool>.value(false)) as _i9.Future<bool>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue:
                  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i11.Movie>>(
                          this, Invocation.method(#getWatchlistMovies, []))))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i13.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<List<_i14.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  _i9.Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]))
          as _i9.Future<List<_i14.MovieModel>>);
  @override
  _i9.Future<List<_i14.MovieModel>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
              returnValue:
                  _i9.Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]))
          as _i9.Future<List<_i14.MovieModel>>);
  @override
  _i9.Future<List<_i14.MovieModel>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
              returnValue:
                  _i9.Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]))
          as _i9.Future<List<_i14.MovieModel>>);
  @override
  _i9.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue: _i9.Future<_i3.MovieDetailResponse>.value(
                  _FakeMovieDetailResponse_1(
                      this, Invocation.method(#getMovieDetail, [id]))))
          as _i9.Future<_i3.MovieDetailResponse>);
  @override
  _i9.Future<List<_i14.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  _i9.Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]))
          as _i9.Future<List<_i14.MovieModel>>);
  @override
  _i9.Future<List<_i14.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  _i9.Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]))
          as _i9.Future<List<_i14.MovieModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i15.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<String> insertWatchlist(_i16.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: _i9.Future<String>.value('')) as _i9.Future<String>);
  @override
  _i9.Future<String> removeWatchlist(_i16.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: _i9.Future<String>.value('')) as _i9.Future<String>);
  @override
  _i9.Future<_i16.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: _i9.Future<_i16.MovieTable?>.value())
          as _i9.Future<_i16.MovieTable?>);
  @override
  _i9.Future<List<_i16.MovieTable>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue:
                  _i9.Future<List<_i16.MovieTable>>.value(<_i16.MovieTable>[]))
          as _i9.Future<List<_i16.MovieTable>>);
}

/// A class which mocks [TvRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRepository extends _i1.Mock implements _i17.TvRepository {
  MockTvRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i18.Tv>>> getNowPlayingTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingTvSeries, []),
              returnValue:
                  _i9.Future<_i2.Either<_i10.Failure, List<_i18.Tv>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i18.Tv>>(
                          this, Invocation.method(#getNowPlayingTvSeries, []))))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i18.Tv>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i18.Tv>>> getPopularTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvSeries, []),
              returnValue:
                  _i9.Future<_i2.Either<_i10.Failure, List<_i18.Tv>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i18.Tv>>(
                          this, Invocation.method(#getPopularTvSeries, []))))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i18.Tv>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i18.Tv>>> getTopRatedTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvSeries, []),
              returnValue:
                  _i9.Future<_i2.Either<_i10.Failure, List<_i18.Tv>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i18.Tv>>(
                          this, Invocation.method(#getTopRatedTvSeries, []))))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i18.Tv>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, _i19.TvDetail>> getTvDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvDetail, [id]),
              returnValue:
                  _i9.Future<_i2.Either<_i10.Failure, _i19.TvDetail>>.value(
                      _FakeEither_0<_i10.Failure, _i19.TvDetail>(
                          this, Invocation.method(#getTvDetail, [id]))))
          as _i9.Future<_i2.Either<_i10.Failure, _i19.TvDetail>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i18.Tv>>> getTvRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvRecommendations, [id]),
              returnValue:
                  _i9.Future<_i2.Either<_i10.Failure, List<_i18.Tv>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i18.Tv>>(this,
                          Invocation.method(#getTvRecommendations, [id]))))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i18.Tv>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i18.Tv>>> searchTvSeries(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvSeries, [query]),
              returnValue:
                  _i9.Future<_i2.Either<_i10.Failure, List<_i18.Tv>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i18.Tv>>(
                          this, Invocation.method(#searchTvSeries, [query]))))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i18.Tv>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, String>> saveWatchlist(
          _i19.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [tv]),
              returnValue: _i9.Future<_i2.Either<_i10.Failure, String>>.value(
                  _FakeEither_0<_i10.Failure, String>(
                      this, Invocation.method(#saveWatchlist, [tv]))))
          as _i9.Future<_i2.Either<_i10.Failure, String>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, String>> removeWatchlist(
          _i19.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tv]),
              returnValue: _i9.Future<_i2.Either<_i10.Failure, String>>.value(
                  _FakeEither_0<_i10.Failure, String>(
                      this, Invocation.method(#removeWatchlist, [tv]))))
          as _i9.Future<_i2.Either<_i10.Failure, String>>);
  @override
  _i9.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: _i9.Future<bool>.value(false)) as _i9.Future<bool>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i18.Tv>>> getWatchlistTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvSeries, []),
              returnValue:
                  _i9.Future<_i2.Either<_i10.Failure, List<_i18.Tv>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i18.Tv>>(
                          this, Invocation.method(#getWatchlistTvSeries, []))))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i18.Tv>>>);
}

/// A class which mocks [TvRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRemoteDataSource extends _i1.Mock
    implements _i20.TvRemoteDataSource {
  MockTvRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<List<_i21.TvModel>> getNowPlayingTv() => (super.noSuchMethod(
          Invocation.method(#getNowPlayingTv, []),
          returnValue: _i9.Future<List<_i21.TvModel>>.value(<_i21.TvModel>[]))
      as _i9.Future<List<_i21.TvModel>>);
  @override
  _i9.Future<List<_i21.TvModel>> getPopularTv() => (super.noSuchMethod(
          Invocation.method(#getPopularTv, []),
          returnValue: _i9.Future<List<_i21.TvModel>>.value(<_i21.TvModel>[]))
      as _i9.Future<List<_i21.TvModel>>);
  @override
  _i9.Future<List<_i21.TvModel>> getTopRatedTv() => (super.noSuchMethod(
          Invocation.method(#getTopRatedTv, []),
          returnValue: _i9.Future<List<_i21.TvModel>>.value(<_i21.TvModel>[]))
      as _i9.Future<List<_i21.TvModel>>);
  @override
  _i9.Future<_i4.TvDetailResponse> getTvDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvDetail, [id]),
              returnValue: _i9.Future<_i4.TvDetailResponse>.value(
                  _FakeTvDetailResponse_2(
                      this, Invocation.method(#getTvDetail, [id]))))
          as _i9.Future<_i4.TvDetailResponse>);
  @override
  _i9.Future<List<_i21.TvModel>> getTvRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvRecommendations, [id]),
              returnValue:
                  _i9.Future<List<_i21.TvModel>>.value(<_i21.TvModel>[]))
          as _i9.Future<List<_i21.TvModel>>);
  @override
  _i9.Future<List<_i21.TvModel>> searchTv(String? query) => (super.noSuchMethod(
          Invocation.method(#searchTv, [query]),
          returnValue: _i9.Future<List<_i21.TvModel>>.value(<_i21.TvModel>[]))
      as _i9.Future<List<_i21.TvModel>>);
}

/// A class which mocks [TvLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvLocalDataSource extends _i1.Mock implements _i22.TvLocalDataSource {
  MockTvLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<String> insertWatchlistTv(_i23.TvTable? tvTable) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistTv, [tvTable]),
          returnValue: _i9.Future<String>.value('')) as _i9.Future<String>);
  @override
  _i9.Future<String> removeWatchlistTv(_i23.TvTable? tvTable) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTv, [tvTable]),
          returnValue: _i9.Future<String>.value('')) as _i9.Future<String>);
  @override
  _i9.Future<_i23.TvTable?> getTvById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvById, [id]),
              returnValue: _i9.Future<_i23.TvTable?>.value())
          as _i9.Future<_i23.TvTable?>);
  @override
  _i9.Future<List<_i23.TvTable>> getWatchlistTv() => (super.noSuchMethod(
          Invocation.method(#getWatchlistTv, []),
          returnValue: _i9.Future<List<_i23.TvTable>>.value(<_i23.TvTable>[]))
      as _i9.Future<List<_i23.TvTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i24.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i25.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: _i9.Future<_i25.Database?>.value())
          as _i9.Future<_i25.Database?>);
  @override
  _i9.Future<int> insertWatchlist(_i16.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: _i9.Future<int>.value(0)) as _i9.Future<int>);
  @override
  _i9.Future<int> insertWatchlistTv(_i23.TvTable? tvTable) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistTv, [tvTable]),
          returnValue: _i9.Future<int>.value(0)) as _i9.Future<int>);
  @override
  _i9.Future<int> removeWatchlist(_i16.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: _i9.Future<int>.value(0)) as _i9.Future<int>);
  @override
  _i9.Future<int> removeWatchlistTv(_i23.TvTable? tvTable) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTv, [tvTable]),
          returnValue: _i9.Future<int>.value(0)) as _i9.Future<int>);
  @override
  _i9.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: _i9.Future<Map<String, dynamic>?>.value())
          as _i9.Future<Map<String, dynamic>?>);
  @override
  _i9.Future<Map<String, dynamic>?> getTvById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvById, [id]),
              returnValue: _i9.Future<Map<String, dynamic>?>.value())
          as _i9.Future<Map<String, dynamic>?>);
  @override
  _i9.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue: _i9.Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i9.Future<List<Map<String, dynamic>>>);
  @override
  _i9.Future<List<Map<String, dynamic>>> getWatchlistTv() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTv, []),
              returnValue: _i9.Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i9.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [SslPinning].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i26.SslPinning {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i5.SecurityContext> get globalContext => (super.noSuchMethod(
          Invocation.getter(#globalContext),
          returnValue: _i9.Future<_i5.SecurityContext>.value(
              _FakeSecurityContext_3(this, Invocation.getter(#globalContext))))
      as _i9.Future<_i5.SecurityContext>);
  @override
  _i9.Future<_i6.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: _i9.Future<_i6.Response>.value(_FakeResponse_4(
                  this, Invocation.method(#get, [url], {#headers: headers}))))
          as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i7.IOStreamedResponse> send(_i6.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue: _i9.Future<_i7.IOStreamedResponse>.value(
                  _FakeIOStreamedResponse_5(
                      this, Invocation.method(#send, [request]))))
          as _i9.Future<_i7.IOStreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
  @override
  _i9.Future<_i6.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: _i9.Future<_i6.Response>.value(_FakeResponse_4(
                  this, Invocation.method(#head, [url], {#headers: headers}))))
          as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i6.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i27.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#post, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i9.Future<_i6.Response>.value(_FakeResponse_4(
                  this,
                  Invocation.method(#post, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i6.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i27.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#put, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i9.Future<_i6.Response>.value(_FakeResponse_4(
                  this,
                  Invocation.method(#put, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i6.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i27.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#patch, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i9.Future<_i6.Response>.value(_FakeResponse_4(
                  this,
                  Invocation.method(#patch, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i6.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i27.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#delete, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i9.Future<_i6.Response>.value(_FakeResponse_4(
                  this,
                  Invocation.method(#delete, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i9.Future<_i6.Response>);
  @override
  _i9.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: _i9.Future<String>.value('')) as _i9.Future<String>);
  @override
  _i9.Future<_i28.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: _i9.Future<_i28.Uint8List>.value(_i28.Uint8List(0)))
          as _i9.Future<_i28.Uint8List>);
}
