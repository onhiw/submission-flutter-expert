import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv-series/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv-series/get_watchlisttv_status.dart';
import 'package:ditonton/domain/usecases/tv-series/remove_watchlisttv.dart';
import 'package:ditonton/domain/usecases/tv-series/save_watchlisttv.dart';
import 'package:equatable/equatable.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchlistTv getWatchlistTv;
  final GetWatchListTvStatus getWatchListTvStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;
  TvWatchlistBloc(this.getWatchlistTv, this.getWatchListTvStatus,
      this.saveWatchlistTv, this.removeWatchlistTv)
      : super(TvWatchlistInitial()) {
    on<GetListTvWatchlist>(_fetchTvWatchlist);
    on<GetListTvWatchlistStatus>(_fetchTvWatchlistStatus);
    on<TvWatchlistAdd>(_fetchTvWatchlistAdd);
    on<TvWatchlistRemove>(_fetchTvWatchlistRemove);
  }

  Future<void> _fetchTvWatchlist(
      GetListTvWatchlist event, Emitter<TvWatchlistState> emit) async {
    emit(TvWatchlistLoading());
    final data = await getWatchlistTv.execute();

    data.fold((failure) {
      emit(TvWatchlistError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TvWatchlistInitial())
          : emit(TvWatchlistLoaded(success));
    });
  }

  Future<void> _fetchTvWatchlistStatus(
      GetListTvWatchlistStatus event, Emitter<TvWatchlistState> emit) async {
    final data = await getWatchListTvStatus.execute(event.id);
    emit(TvWatchlistIsAdded(data));
  }

  Future<void> _fetchTvWatchlistAdd(
      TvWatchlistAdd event, Emitter<TvWatchlistState> emit) async {
    final data = await saveWatchlistTv.execute(event.tvDetail);
    data.fold((failure) {
      emit(TvWatchlistError(failure.message));
    }, (success) {
      emit(TvWatchlistMessage(success));
    });
  }

  Future<void> _fetchTvWatchlistRemove(
      TvWatchlistRemove event, Emitter<TvWatchlistState> emit) async {
    final data = await removeWatchlistTv.execute(event.tvDetail);
    data.fold((failure) {
      emit(TvWatchlistError(failure.message));
    }, (success) {
      emit(TvWatchlistMessage(success));
    });
  }
}
