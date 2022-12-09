part of 'tv_search_bloc.dart';

abstract class TvSearchState extends Equatable {
  const TvSearchState();

  @override
  List<Object> get props => [];
}

class TvSearchInitial extends TvSearchState {
  const TvSearchInitial();

  @override
  List<Object> get props => [];
}

class TvSearchLoading extends TvSearchState {}

class TvSearchLoaded extends TvSearchState {
  final List<Tv> tv;

  const TvSearchLoaded(this.tv);

  @override
  List<Object> get props => [tv];
}

class TvSearchError extends TvSearchState {
  final String message;

  const TvSearchError(this.message);

  @override
  List<Object> get props => [message];
}
