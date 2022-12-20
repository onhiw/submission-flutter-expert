import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:ditonton/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie/top-rated/top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import 'top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedBloc topRatedBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedBloc = TopRatedBloc(mockGetTopRatedMovies);
  });

  blocTest<TopRatedBloc, TopRatedState>(
    'should change movie when data is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(GetListTopRatedMovie()),
    expect: () => [TopRatedLoading(), TopRatedLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
      return GetListTopRatedMovie().props;
    },
  );

  blocTest<TopRatedBloc, TopRatedState>(
    'should change movie when data is gotten initial',
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Right([]));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(GetListTopRatedMovie()),
    expect: () => [TopRatedLoading(), TopRatedInitial()],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
      return GetListTopRatedMovie().props;
    },
  );

  blocTest<TopRatedBloc, TopRatedState>(
    'should update error message when request in successful',
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer((_) async =>
          Left(ServerFailure('Terjadi kesalahaan saat memuat data')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(GetListTopRatedMovie()),
    expect: () => [
      TopRatedLoading(),
      TopRatedError('Terjadi kesalahaan saat memuat data')
    ],
    verify: (bloc) => TopRatedLoading(),
  );
}
