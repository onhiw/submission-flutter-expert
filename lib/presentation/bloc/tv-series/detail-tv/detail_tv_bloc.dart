import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv-series/get_tv_detail.dart';
import 'package:equatable/equatable.dart';

part 'detail_tv_event.dart';
part 'detail_tv_state.dart';

class DetailTvBloc extends Bloc<DetailTvEvent, DetailTvState> {
  final GetTvDetail getTvDetail;

  DetailTvBloc(this.getTvDetail) : super(DetailTvInitial()) {
    on<GetSingleDetailTv>(_fetchDetailTv);
  }

  Future<void> _fetchDetailTv(
      GetSingleDetailTv event, Emitter<DetailTvState> emit) async {
    emit(DetailTvLoading());

    final data = await getTvDetail.execute(event.id);

    data.fold((failure) {
      emit(DetailTvError(failure.message));
    }, (success) {
      emit(DetailTvLoaded(success));
    });
  }
}
