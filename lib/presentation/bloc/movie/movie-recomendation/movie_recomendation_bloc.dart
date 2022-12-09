import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'movie_recomendation_event.dart';
part 'movie_recomendation_state.dart';

class MovieRecomendationBloc
    extends Bloc<MovieRecomendationEvent, MovieRecomendationState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecomendationBloc(this.getMovieRecommendations)
      : super(MovieRecomendationInitial()) {
    on<GetListMovieRecomendation>(_fetchMovieRecomendation);
  }

  Future<void> _fetchMovieRecomendation(GetListMovieRecomendation event,
      Emitter<MovieRecomendationState> emit) async {
    emit(MovieRecomendationLoading());

    final data = await getMovieRecommendations.execute(event.id);

    data.fold((failure) {
      emit(MovieRecomendationError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(MovieRecomendationInitial())
          : emit(MovieRecomendationLoaded(success));
    });
  }
}
