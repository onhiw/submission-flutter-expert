import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movies/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movies/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movies/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieWatchlistBloc movieWatchlistBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieWatchlistBloc = MovieWatchlistBloc(mockGetWatchlistMovies,
        mockGetWatchListStatus, mockSaveWatchlist, mockRemoveWatchlist);
  });

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'should change movie when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetListMovieWatchlist()),
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistLoaded([testWatchlistMovie])
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
      return GetListMovieWatchlist();
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'should update error message when request in successful',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer((_) async =>
          Left(ServerFailure('Terjadi kesalahaan saat memuat data')));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetListMovieWatchlist()),
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistError('Terjadi kesalahaan saat memuat data')
    ],
    verify: (bloc) => MovieWatchlistLoading(),
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'should be true if the watchlist status is also true',
    build: () {
      when(mockGetWatchListStatus.execute(testWatchlistMovie.id))
          .thenAnswer((_) async => true);
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetListMovieWatchlistStatus(testWatchlistMovie.id)),
    expect: () => [
      MovieWatchlistIsAdded(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(testWatchlistMovie.id));
      return GetListMovieWatchlistStatus(testWatchlistMovie.id);
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'should be false if the watchlist status is also false',
    build: () {
      when(mockGetWatchListStatus.execute(testWatchlistMovie.id))
          .thenAnswer((_) async => false);
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetListMovieWatchlistStatus(testWatchlistMovie.id)),
    expect: () => [
      MovieWatchlistIsAdded(false),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(testWatchlistMovie.id));
      return GetListMovieWatchlistStatus(testWatchlistMovie.id);
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'should successfully add watchlist',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(MovieWatchlistAdd(testMovieDetail)),
    expect: () => [
      MovieWatchlistMessage('Added to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
      return MovieWatchlistAdd(testMovieDetail);
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'should fail to add to the watchlist',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
          (_) async => Left(DatabaseFailure('Failed Add to Watchlist')));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(MovieWatchlistAdd(testMovieDetail)),
    expect: () => [
      MovieWatchlistError('Failed Add to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
      return MovieWatchlistAdd(testMovieDetail);
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'should successfully remove watchlist',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Remove to Watchlist'));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(MovieWatchlistRemove(testMovieDetail)),
    expect: () => [
      MovieWatchlistMessage('Remove to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
      return MovieWatchlistRemove(testMovieDetail);
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'should fail to remove to the watchlist',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
          (_) async => Left(DatabaseFailure('Failed Remove to Watchlist')));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(MovieWatchlistRemove(testMovieDetail)),
    expect: () => [
      MovieWatchlistError('Failed Remove to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
      return MovieWatchlistRemove(testMovieDetail);
    },
  );
}
