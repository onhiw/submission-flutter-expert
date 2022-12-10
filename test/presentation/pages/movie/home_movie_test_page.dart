import 'package:ditonton/presentation/bloc/movie/now-playing/now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top-rated/top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/movie-page/home_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import '../../../helpers/bloc-helper/movie/now-playing/fake_now_playing_bloc.dart';
import '../../../helpers/bloc-helper/movie/now-playing/fake_now_playing_event.dart';
import '../../../helpers/bloc-helper/movie/now-playing/fake_now_playing_state.dart';
import '../../../helpers/bloc-helper/movie/popular-movie/fake_popular_movie_bloc.dart';
import '../../../helpers/bloc-helper/movie/popular-movie/fake_popular_movie_event.dart';
import '../../../helpers/bloc-helper/movie/popular-movie/fake_popular_movie_state.dart';
import '../../../helpers/bloc-helper/movie/top-rated/fake_top_rated_bloc.dart';
import '../../../helpers/bloc-helper/movie/top-rated/fake_top_rated_event.dart';
import '../../../helpers/bloc-helper/movie/top-rated/fake_top_rated_state.dart';

void main() {
  late FakeNowPlayingBloc fakeNowPlayingBloc;
  late FakePopularMovieBloc fakePopularMovieBloc;
  late FakeTopRatedBloc fakeTopRatedBloc;

  setUp(() {
    fakeNowPlayingBloc = FakeNowPlayingBloc();
    registerFallbackValue(FakeNowPlayingEvent());
    registerFallbackValue(FakeNowPlayingState());

    fakePopularMovieBloc = FakePopularMovieBloc();
    registerFallbackValue(FakePopularMovieEvent());
    registerFallbackValue(FakePopularMovieState());

    fakeTopRatedBloc = FakeTopRatedBloc();
    registerFallbackValue(FakeTopRatedEvent());
    registerFallbackValue(FakeTopRatedState());
  });

  tearDown(() {
    fakeNowPlayingBloc.close();
    fakePopularMovieBloc.close();
    fakeTopRatedBloc.close();
  });

  Widget _buildTestWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingBloc>(
          create: (context) => fakeNowPlayingBloc,
        ),
        BlocProvider<PopularMovieBloc>(
          create: (context) => fakePopularMovieBloc,
        ),
        BlocProvider<TopRatedBloc>(
          create: (context) => fakeTopRatedBloc,
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
    when(() => fakeNowPlayingBloc.state)
        .thenReturn(NowPlayingLoaded(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(PopularMovieLoaded(testMovieList));
    when(() => fakeTopRatedBloc.state)
        .thenReturn(TopRatedLoaded(testMovieList));

    final listView = find.byType(ListView);

    await tester.pumpWidget(_buildTestWidget(HomeMoviePage()));

    expect(listView, findsWidgets);
  });
}
