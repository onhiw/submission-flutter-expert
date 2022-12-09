import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv-series/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'tv_recomendation_event.dart';
part 'tv_recomendation_state.dart';

class TvRecomendationBloc
    extends Bloc<TvRecomendationEvent, TvRecomendationState> {
  final GetTvRecommendations getTvRecommendations;
  TvRecomendationBloc(this.getTvRecommendations)
      : super(TvRecomendationInitial()) {
    on<GetListTvRecomendation>(_fetchTvRecomendation);
  }

  Future<void> _fetchTvRecomendation(
      GetListTvRecomendation event, Emitter<TvRecomendationState> emit) async {
    emit(TvRecomendationLoading());

    final data = await getTvRecommendations.execute(event.id);

    data.fold((failure) {
      emit(TvRecomendationError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TvRecomendationInitial())
          : emit(TvRecomendationLoaded(success));
    });
  }
}
