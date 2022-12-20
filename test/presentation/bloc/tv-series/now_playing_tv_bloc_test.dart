import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:ditonton/domain/usecases/tv-series/get_now_playing_tv.dart';
import 'package:ditonton/presentation/bloc/tv-series/now-playing-tv/now_playing_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv-series/dummy_object_tv.dart';
import 'now_playing_tv_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late NowPlayingTvBloc nowPlayingTvBloc;
  late MockGetNowPlayingTv mockGetNowPlayingTv;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    nowPlayingTvBloc = NowPlayingTvBloc(mockGetNowPlayingTv);
  });

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'should change tv when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(GetListNowPlayingTv()),
    expect: () => [NowPlayingTvLoading(), NowPlayingTvLoaded(testTvList)],
    verify: (bloc) {
      verify(mockGetNowPlayingTv.execute());
      return GetListNowPlayingTv().props;
    },
  );

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'should change tv when data is gotten initial',
    build: () {
      when(mockGetNowPlayingTv.execute()).thenAnswer((_) async => Right([]));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(GetListNowPlayingTv()),
    expect: () => [NowPlayingTvLoading(), NowPlayingTvInitial()],
    verify: (bloc) {
      verify(mockGetNowPlayingTv.execute());
      return GetListNowPlayingTv().props;
    },
  );

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'should update error message when request in successful',
    build: () {
      when(mockGetNowPlayingTv.execute()).thenAnswer((_) async =>
          Left(ServerFailure('Terjadi kesalahaan saat memuat data')));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(GetListNowPlayingTv()),
    expect: () => [
      NowPlayingTvLoading(),
      NowPlayingTvError('Terjadi kesalahaan saat memuat data')
    ],
    verify: (bloc) => NowPlayingTvLoading(),
  );
}
