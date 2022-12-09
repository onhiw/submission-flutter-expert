part of 'movie_recomendation_bloc.dart';

abstract class MovieRecomendationState extends Equatable {
  const MovieRecomendationState();

  @override
  List<Object> get props => [];
}

class MovieRecomendationInitial extends MovieRecomendationState {
  const MovieRecomendationInitial();

  @override
  List<Object> get props => [];
}

class MovieRecomendationLoading extends MovieRecomendationState {}

class MovieRecomendationLoaded extends MovieRecomendationState {
  final List<Movie> movie;

  const MovieRecomendationLoaded(this.movie);

  @override
  List<Object> get props => [movie];
}

class MovieRecomendationError extends MovieRecomendationState {
  final String message;

  const MovieRecomendationError(this.message);

  @override
  List<Object> get props => [message];
}
