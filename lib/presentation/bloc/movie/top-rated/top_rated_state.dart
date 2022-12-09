part of 'top_rated_bloc.dart';

abstract class TopRatedState extends Equatable {
  const TopRatedState();

  @override
  List<Object> get props => [];
}

class TopRatedInitial extends TopRatedState {
  const TopRatedInitial();

  @override
  List<Object> get props => [];
}

class TopRatedLoading extends TopRatedState {}

class TopRatedLoaded extends TopRatedState {
  final List<Movie> movie;

  const TopRatedLoaded(this.movie);

  @override
  List<Object> get props => [movie];
}

class TopRatedError extends TopRatedState {
  final String message;

  const TopRatedError(this.message);

  @override
  List<Object> get props => [message];
}
