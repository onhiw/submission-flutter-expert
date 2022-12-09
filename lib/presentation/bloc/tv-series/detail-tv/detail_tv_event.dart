part of 'detail_tv_bloc.dart';

abstract class DetailTvEvent extends Equatable {}

class GetSingleDetailTv extends DetailTvEvent {
  final int id;

  GetSingleDetailTv(this.id);

  @override
  List<Object> get props => [];
}
