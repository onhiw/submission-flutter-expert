import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovies;

  PopularMovieBloc(this.getPopularMovies) : super(PopularMovieInitial()) {
    on<GetListPopularMovie>(_fetchPopularMovie);
  }

  Future<void> _fetchPopularMovie(
      GetListPopularMovie event, Emitter<PopularMovieState> emit) async {
    emit(PopularMovieLoading());

    final data = await getPopularMovies.execute();

    data.fold((failure) {
      emit(PopularMovieError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(PopularMovieInitial())
          : emit(PopularMovieLoaded(success));
    });
  }
}
