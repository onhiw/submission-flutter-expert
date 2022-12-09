import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedBloc(this.getTopRatedMovies) : super(TopRatedInitial()) {
    on<GetListTopRatedMovie>(_fetchTopRatedMovie);
  }

  Future<void> _fetchTopRatedMovie(
      GetListTopRatedMovie event, Emitter<TopRatedState> emit) async {
    emit(TopRatedLoading());

    final data = await getTopRatedMovies.execute();

    data.fold((failure) {
      emit(TopRatedError(failure.message));
    }, (success) {
      success.isEmpty ? emit(TopRatedInitial()) : emit(TopRatedLoaded(success));
    });
  }
}
