part of 'popular_movie_bloc.dart';

abstract class PopularMovieEvent extends Equatable {}

class GetListPopularMovie extends PopularMovieEvent {
  @override
  List<Object> get props => [];
}
