import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv-series/get_now_playing_tv.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  final GetNowPlayingTv getNowPlayingTv;

  NowPlayingTvBloc(this.getNowPlayingTv) : super(NowPlayingTvInitial()) {
    on<NowPlayingTvEvent>((event, emit) {
      on<GetListNowPlayingTv>(_fetchNowPlayingTv);
    });
  }

  Future<void> _fetchNowPlayingTv(
      GetListNowPlayingTv event, Emitter<NowPlayingTvState> emit) async {
    emit(NowPlayingTvLoading());

    final data = await getNowPlayingTv.execute();

    data.fold((failure) {
      emit(NowPlayingTvError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(NowPlayingTvInitial())
          : emit(NowPlayingTvLoaded(success));
    });
  }
}
