import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie/movie-recomendation/movie_recomendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import 'recomendation_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecomendationBloc movieRecomendationBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecomendationBloc =
        MovieRecomendationBloc(mockGetMovieRecommendations);
  });

  final tId = 1;

  blocTest<MovieRecomendationBloc, MovieRecomendationState>(
    'should change movie recomendation when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(testMovieList));
      return movieRecomendationBloc;
    },
    act: (bloc) => bloc.add(GetListMovieRecomendation(tId)),
    expect: () =>
        [MovieRecomendationLoading(), MovieRecomendationLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(tId));
      return GetListMovieRecomendation(tId).props;
    },
  );

  blocTest<MovieRecomendationBloc, MovieRecomendationState>(
    'should change movie recomendation when data is gotten initial',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right([]));
      return movieRecomendationBloc;
    },
    act: (bloc) => bloc.add(GetListMovieRecomendation(tId)),
    expect: () => [MovieRecomendationLoading(), MovieRecomendationInitial()],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(tId));
      return GetListMovieRecomendation(tId).props;
    },
  );

  blocTest<MovieRecomendationBloc, MovieRecomendationState>(
    'should update error message when request in successful',
    build: () {
      when(mockGetMovieRecommendations.execute(tId)).thenAnswer((_) async =>
          Left(ServerFailure('Terjadi kesalahaan saat memuat data')));
      return movieRecomendationBloc;
    },
    act: (bloc) => bloc.add(GetListMovieRecomendation(tId)),
    expect: () => [
      MovieRecomendationLoading(),
      MovieRecomendationError('Terjadi kesalahaan saat memuat data')
    ],
    verify: (bloc) => MovieRecomendationLoading(),
  );
}
