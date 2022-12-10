import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_detail.dart';
import 'package:equatable/equatable.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail getMovieDetail;

  DetailMovieBloc(this.getMovieDetail) : super(DetailMovieLoading()) {
    on<GetSingleDetailMovie>(_fetchDetailMovie);
  }

  Future<void> _fetchDetailMovie(
      GetSingleDetailMovie event, Emitter<DetailMovieState> emit) async {
    emit(DetailMovieLoading());

    final data = await getMovieDetail.execute(event.id);

    data.fold((failure) {
      emit(DetailMovieError(failure.message));
    }, (success) {
      emit(DetailMovieLoaded(success));
    });
  }
}
