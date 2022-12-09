part of 'tv_recomendation_bloc.dart';

abstract class TvRecomendationState extends Equatable {
  const TvRecomendationState();

  @override
  List<Object> get props => [];
}

class TvRecomendationInitial extends TvRecomendationState {
  const TvRecomendationInitial();

  @override
  List<Object> get props => [];
}

class TvRecomendationLoading extends TvRecomendationState {}

class TvRecomendationLoaded extends TvRecomendationState {
  final List<Tv> tv;

  const TvRecomendationLoaded(this.tv);

  @override
  List<Object> get props => [tv];
}

class TvRecomendationError extends TvRecomendationState {
  final String message;

  const TvRecomendationError(this.message);

  @override
  List<Object> get props => [message];
}
