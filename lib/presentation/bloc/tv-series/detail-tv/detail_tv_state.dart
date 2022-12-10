part of 'detail_tv_bloc.dart';

abstract class DetailTvState extends Equatable {
  const DetailTvState();

  @override
  List<Object> get props => [];
}

class DetailTvLoading extends DetailTvState {}

class DetailTvLoaded extends DetailTvState {
  final TvDetail tvDetail;

  const DetailTvLoaded(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class DetailTvError extends DetailTvState {
  final String message;

  const DetailTvError(this.message);

  @override
  List<Object> get props => [message];
}
