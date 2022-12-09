import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv-series/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvBloc(this.getTopRatedTv) : super(TopRatedTvInitial()) {
    on<GetListTopRatedTv>(_fetchTopRatedTv);
  }

  Future<void> _fetchTopRatedTv(
      GetListTopRatedTv event, Emitter<TopRatedTvState> emit) async {
    emit(TopRatedTvLoading());

    final data = await getTopRatedTv.execute();

    data.fold((failure) {
      emit(TopRatedTvError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TopRatedTvInitial())
          : emit(TopRatedTvLoaded(success));
    });
  }
}
