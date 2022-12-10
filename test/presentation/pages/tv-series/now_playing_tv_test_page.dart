import 'package:ditonton/presentation/bloc/tv-series/now-playing-tv/now_playing_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv-page/now_playing_tv_page.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/tv-series/dummy_object_tv.dart';
import '../../../helpers/bloc-helper/tv-series/now-playing-tv/fake_now_playing_tv_bloc.dart';
import '../../../helpers/bloc-helper/tv-series/now-playing-tv/fake_now_playing_tv_event.dart';
import '../../../helpers/bloc-helper/tv-series/now-playing-tv/fake_now_playing_tv_state.dart';

void main() {
  late FakeNowPlayingTvBloc fakeNowPlayingTvBloc;

  setUp(() {
    fakeNowPlayingTvBloc = FakeNowPlayingTvBloc();
    registerFallbackValue(FakeNowPlayingTvEvent());
    registerFallbackValue(FakeNowPlayingTvState());
  });

  tearDown(() {
    fakeNowPlayingTvBloc.close();
  });

  Widget _buildTestWidget(Widget body) {
    return BlocProvider<NowPlayingTvBloc>(
      create: (_) => fakeNowPlayingTvBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets(
      'the page should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingTvBloc.state).thenReturn(NowPlayingTvLoading());

    final circular = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_buildTestWidget(NowPlayingTvPage()));
    await tester.pump();

    expect(circular, findsOneWidget);
  });

  testWidgets(
      'the page should display NowPlaying Tv when the data is successfully loaded',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingTvBloc.state)
        .thenReturn(NowPlayingTvLoaded(testTvList));
    await tester.pumpWidget(_buildTestWidget(NowPlayingTvPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvCard), findsOneWidget);
  });
}
