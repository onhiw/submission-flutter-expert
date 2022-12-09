part of 'movie_recomendation_bloc.dart';

abstract class MovieRecomendationEvent extends Equatable {}

class GetListMovieRecomendation extends MovieRecomendationEvent {
  final int id;

  GetListMovieRecomendation(this.id);

  @override
  List<Object> get props => [id];
}
