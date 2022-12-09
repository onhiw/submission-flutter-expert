import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv-series/search_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTv searchTv;

  TvSearchBloc(this.searchTv) : super(TvSearchInitial()) {
    on<TvSearchEvent>((event, emit) {
      on<GetListSearchTv>(_fetchTvSearch);
    });
  }

  Future<void> _fetchTvSearch(
      GetListSearchTv event, Emitter<TvSearchState> emit) async {
    emit(TvSearchLoading());

    final data = await searchTv.execute(event.query);

    data.fold((failure) {
      emit(TvSearchError(failure.message));
    }, (success) {
      success.isEmpty ? emit(TvSearchInitial()) : emit(TvSearchLoaded(success));
    });
  }
}
