import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movies/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie/popular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import 'popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMovieBloc popularMovieBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieBloc = PopularMovieBloc(mockGetPopularMovies);
  });

  blocTest<PopularMovieBloc, PopularMovieState>(
    'should change movie when data is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(GetListPopularMovie()),
    expect: () => [PopularMovieLoading(), PopularMovieLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
      return GetListPopularMovie();
    },
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'should update error message when request in successful',
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer((_) async =>
          Left(ServerFailure('Terjadi kesalahaan saat memuat data')));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(GetListPopularMovie()),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieError('Terjadi kesalahaan saat memuat data')
    ],
    verify: (bloc) => PopularMovieLoading(),
  );
}
