part of 'tv_recomendation_bloc.dart';

abstract class TvRecomendationEvent extends Equatable {}

class GetListTvRecomendation extends TvRecomendationEvent {
  final int id;

  GetListTvRecomendation(this.id);

  @override
  List<Object> get props => [id];
}
