import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:ditonton/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie/now-playing/now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import 'now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingBloc nowPlayingBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingBloc = NowPlayingBloc(mockGetNowPlayingMovies);
  });

  blocTest<NowPlayingBloc, NowPlayingState>(
    'should change movie when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(GetListNowPlayingMovie()),
    expect: () => [NowPlayingLoading(), NowPlayingLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
      return GetListNowPlayingMovie().props;
    },
  );

  blocTest<NowPlayingBloc, NowPlayingState>(
    'should change movie when data is gotten initial',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right([]));
      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(GetListNowPlayingMovie()),
    expect: () => [NowPlayingLoading(), NowPlayingInitial()],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
      return GetListNowPlayingMovie().props;
    },
  );

  blocTest<NowPlayingBloc, NowPlayingState>(
    'should update error message when request in successful',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer((_) async =>
          Left(ServerFailure('Terjadi kesalahaan saat memuat data')));
      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(GetListNowPlayingMovie()),
    expect: () => [
      NowPlayingLoading(),
      NowPlayingError('Terjadi kesalahaan saat memuat data')
    ],
    verify: (bloc) => NowPlayingLoading(),
  );
}
