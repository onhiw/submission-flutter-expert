part of 'now_playing_bloc.dart';

abstract class NowPlayingEvent extends Equatable {}

class GetListNowPlayingMovie extends NowPlayingEvent {
  @override
  List<Object> get props => [];
}
