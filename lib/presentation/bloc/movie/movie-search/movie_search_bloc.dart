import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/search_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc(this.searchMovies) : super(MovieSearchInitial()) {
    on<MovieSearchEvent>((event, emit) {
      on<GetListSearchMovie>(_fetchMovieSearch);
    });
  }

  Future<void> _fetchMovieSearch(
      GetListSearchMovie event, Emitter<MovieSearchState> emit) async {
    emit(MovieSearchLoading());

    final data = await searchMovies.execute(event.query);

    data.fold((failure) {
      emit(MovieSearchError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(MovieSearchInitial())
          : emit(MovieSearchLoaded(success));
    });
  }
}
