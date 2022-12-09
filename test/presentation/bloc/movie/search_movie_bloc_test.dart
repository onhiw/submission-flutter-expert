import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movies/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie-search/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import 'search_movie_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MovieSearchBloc movieSearchBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    movieSearchBloc = MovieSearchBloc(mockSearchMovies);
  });

  final tQuery = 'spiderman';

  blocTest<MovieSearchBloc, MovieSearchState>(
    'should change movie when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(testMovieList));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(GetListSearchMovie(tQuery)),
    expect: () => [MovieSearchLoading(), MovieSearchLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
      return GetListSearchMovie(tQuery).props;
    },
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'should update error message when request in successful',
    build: () {
      when(mockSearchMovies.execute(tQuery)).thenAnswer((_) async =>
          Left(ServerFailure('Terjadi kesalahaan saat memuat data')));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(GetListSearchMovie(tQuery)),
    expect: () => [
      MovieSearchLoading(),
      MovieSearchError('Terjadi kesalahaan saat memuat data')
    ],
    verify: (bloc) => MovieSearchLoading(),
  );
}
