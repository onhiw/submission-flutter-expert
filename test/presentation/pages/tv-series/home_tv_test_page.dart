import 'package:ditonton/presentation/bloc/tv-series/now-playing-tv/now_playing_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv-series/popular-tv/popular_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv-series/top-rated-tv/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv-page/home_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/tv-series/dummy_object_tv.dart';
import '../../../helpers/bloc-helper/tv-series/now-playing-tv/fake_now_playing_tv_bloc.dart';
import '../../../helpers/bloc-helper/tv-series/now-playing-tv/fake_now_playing_tv_event.dart';
import '../../../helpers/bloc-helper/tv-series/now-playing-tv/fake_now_playing_tv_state.dart';
import '../../../helpers/bloc-helper/tv-series/popular-tv/fake_popular_tv_bloc.dart';
import '../../../helpers/bloc-helper/tv-series/popular-tv/fake_popular_tv_event.dart';
import '../../../helpers/bloc-helper/tv-series/popular-tv/fake_popular_tv_state.dart';
import '../../../helpers/bloc-helper/tv-series/top-rated-tv/fake_top_rated_tv_bloc.dart';
import '../../../helpers/bloc-helper/tv-series/top-rated-tv/fake_top_rated_tv_event.dart';
import '../../../helpers/bloc-helper/tv-series/top-rated-tv/fake_top_rated_tv_state.dart';

void main() {
  late FakeNowPlayingTvBloc fakeNowPlayingTvBloc;
  late FakePopularTvBloc fakePopularTvBloc;
  late FakeTopRatedTvBloc fakeTopRatedTvBloc;

  setUp(() {
    fakeNowPlayingTvBloc = FakeNowPlayingTvBloc();
    registerFallbackValue(FakeNowPlayingTvEvent());
    registerFallbackValue(FakeNowPlayingTvState());

    fakePopularTvBloc = FakePopularTvBloc();
    registerFallbackValue(FakePopularTvEvent());
    registerFallbackValue(FakePopularTvState());

    fakeTopRatedTvBloc = FakeTopRatedTvBloc();
    registerFallbackValue(FakeTopRatedTvEvent());
    registerFallbackValue(FakeTopRatedTvState());
  });

  tearDown(() {
    fakeNowPlayingTvBloc.close();
    fakePopularTvBloc.close();
    fakeTopRatedTvBloc.close();
  });

  Widget _buildTestWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingTvBloc>(
          create: (context) => fakeNowPlayingTvBloc,
        ),
        BlocProvider<PopularTvBloc>(
          create: (context) => fakePopularTvBloc,
        ),
        BlocProvider<TopRatedTvBloc>(
          create: (context) => fakeTopRatedTvBloc,
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets(
      'the page should display now playing, popular, and top rated when the data is successfully loaded',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingTvBloc.state)
        .thenReturn(NowPlayingTvLoaded(testTvList));
    when(() => fakePopularTvBloc.state).thenReturn(PopularTvLoaded(testTvList));
    when(() => fakeTopRatedTvBloc.state)
        .thenReturn(TopRatedTvLoaded(testTvList));

    final listView = find.byType(ListView);

    await tester.pumpWidget(_buildTestWidget(HomeTvPage()));

    expect(listView, findsWidgets);
  });
}
