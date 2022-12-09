part of 'tv_search_bloc.dart';

abstract class TvSearchEvent extends Equatable {}

class GetListSearchTv extends TvSearchEvent {
  final String query;

  GetListSearchTv(this.query);

  @override
  List<Object> get props => [query];
}
