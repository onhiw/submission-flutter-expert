import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingBloc(this.getNowPlayingMovies) : super(NowPlayingInitial()) {
    on<GetListNowPlayingMovie>(_fetchNowPlayingMovie);
  }

  Future<void> _fetchNowPlayingMovie(
      GetListNowPlayingMovie event, Emitter<NowPlayingState> emit) async {
    emit(NowPlayingLoading());

    final data = await getNowPlayingMovies.execute();

    data.fold((failure) {
      emit(NowPlayingError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(NowPlayingInitial())
          : emit(NowPlayingLoaded(success));
    });
  }
}
