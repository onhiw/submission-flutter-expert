part of 'popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object> get props => [];
}

class PopularTvInitial extends PopularTvState {
  const PopularTvInitial();

  @override
  List<Object> get props => [];
}

class PopularTvLoading extends PopularTvState {}

class PopularTvLoaded extends PopularTvState {
  final List<Tv> tv;

  const PopularTvLoaded(this.tv);

  @override
  List<Object> get props => [tv];
}

class PopularTvError extends PopularTvState {
  final String message;

  const PopularTvError(this.message);

  @override
  List<Object> get props => [message];
}
