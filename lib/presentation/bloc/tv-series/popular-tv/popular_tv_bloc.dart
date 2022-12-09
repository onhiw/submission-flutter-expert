import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv-series/get_popular_tv.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv getPopularTv;

  PopularTvBloc(this.getPopularTv) : super(PopularTvInitial()) {
    on<GetListPopularTv>(_fetchPopularTv);
  }

  Future<void> _fetchPopularTv(
      GetListPopularTv event, Emitter<PopularTvState> emit) async {
    emit(PopularTvLoading());

    final data = await getPopularTv.execute();

    data.fold((failure) {
      emit(PopularTvError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(PopularTvInitial())
          : emit(PopularTvLoaded(success));
    });
  }
}
