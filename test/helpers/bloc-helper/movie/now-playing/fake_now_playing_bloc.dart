import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie/now-playing/now_playing_bloc.dart';

class FakeNowPlayingBloc extends MockBloc<NowPlayingEvent, NowPlayingState>
    implements NowPlayingBloc {}
