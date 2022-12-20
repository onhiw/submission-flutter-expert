import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:ditonton/domain/usecases/tv-series/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv-series/get_watchlisttv_status.dart';
import 'package:ditonton/domain/usecases/tv-series/remove_watchlisttv.dart';
import 'package:ditonton/domain/usecases/tv-series/save_watchlisttv.dart';
import 'package:ditonton/presentation/bloc/tv-series/tv_watchlist/tv_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv-series/dummy_object_tv.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTv,
  GetWatchListTvStatus,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late TvWatchlistBloc tvWatchlistBloc;
  late MockGetWatchlistTv mockGetWatchlistTv;
  late MockGetWatchListTvStatus mockGetWatchListTvStatus;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    mockGetWatchListTvStatus = MockGetWatchListTvStatus();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    tvWatchlistBloc = TvWatchlistBloc(mockGetWatchlistTv,
        mockGetWatchListTvStatus, mockSaveWatchlistTv, mockRemoveWatchlistTv);
  });

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'should change Tv when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Right([testWatchListTv]));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetListTvWatchlist()),
    expect: () => [
      TvWatchlistLoading(),
      TvWatchlistLoaded([testWatchListTv])
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
      return GetListTvWatchlist().props;
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'should change Tv when data is gotten initial',
    build: () {
      when(mockGetWatchlistTv.execute()).thenAnswer((_) async => Right([]));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetListTvWatchlist()),
    expect: () => [TvWatchlistLoading(), TvWatchlistInitial()],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
      return GetListTvWatchlist().props;
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'should update error message when request in successful',
    build: () {
      when(mockGetWatchlistTv.execute()).thenAnswer((_) async =>
          Left(ServerFailure('Terjadi kesalahaan saat memuat data')));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetListTvWatchlist()),
    expect: () => [
      TvWatchlistLoading(),
      TvWatchlistError('Terjadi kesalahaan saat memuat data')
    ],
    verify: (bloc) => TvWatchlistLoading(),
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'should be true if the watchlist status is also true',
    build: () {
      when(mockGetWatchListTvStatus.execute(testWatchListTv.id))
          .thenAnswer((_) async => true);
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetListTvWatchlistStatus(testWatchListTv.id!)),
    expect: () => [
      TvWatchlistIsAdded(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListTvStatus.execute(testWatchListTv.id));
      return GetListTvWatchlistStatus(testWatchListTv.id!).props;
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'should be false if the watchlist status is also false',
    build: () {
      when(mockGetWatchListTvStatus.execute(testWatchListTv.id))
          .thenAnswer((_) async => false);
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetListTvWatchlistStatus(testWatchListTv.id!)),
    expect: () => [
      TvWatchlistIsAdded(false),
    ],
    verify: (bloc) {
      verify(mockGetWatchListTvStatus.execute(testWatchListTv.id));
      return GetListTvWatchlistStatus(testWatchListTv.id!).props;
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'should successfully add watchlist',
    build: () {
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvWatchlistAdd(testTvDetail)),
    expect: () => [
      TvWatchlistMessage('Added to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTv.execute(testTvDetail));
      return TvWatchlistAdd(testTvDetail).props;
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'should fail to add to the watchlist',
    build: () {
      when(mockSaveWatchlistTv.execute(testTvDetail)).thenAnswer(
          (_) async => Left(DatabaseFailure('Failed Add to Watchlist')));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvWatchlistAdd(testTvDetail)),
    expect: () => [
      TvWatchlistError('Failed Add to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTv.execute(testTvDetail));
      return TvWatchlistAdd(testTvDetail).props;
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'should successfully remove watchlist',
    build: () {
      when(mockRemoveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('Remove to Watchlist'));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvWatchlistRemove(testTvDetail)),
    expect: () => [
      TvWatchlistMessage('Remove to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
      return TvWatchlistRemove(testTvDetail).props;
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'should fail to remove to the watchlist',
    build: () {
      when(mockRemoveWatchlistTv.execute(testTvDetail)).thenAnswer(
          (_) async => Left(DatabaseFailure('Failed Remove to Watchlist')));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(TvWatchlistRemove(testTvDetail)),
    expect: () => [
      TvWatchlistError('Failed Remove to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
      return TvWatchlistRemove(testTvDetail).props;
    },
  );
}
