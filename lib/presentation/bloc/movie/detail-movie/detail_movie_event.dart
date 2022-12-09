part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {}

class GetSingleDetailMovie extends DetailMovieEvent {
  final int id;

  GetSingleDetailMovie(this.id);

  @override
  List<Object> get props => [id];
}
