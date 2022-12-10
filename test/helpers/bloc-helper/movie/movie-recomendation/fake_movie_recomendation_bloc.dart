import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie/movie-recomendation/movie_recomendation_bloc.dart';

class FakeMovieRecomendationBloc
    extends MockBloc<MovieRecomendationEvent, MovieRecomendationState>
    implements MovieRecomendationBloc {}
