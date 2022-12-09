part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent extends Equatable {}

class GetListSearchMovie extends MovieSearchEvent {
  final String query;

  GetListSearchMovie(this.query);

  @override
  List<Object> get props => [query];
}
