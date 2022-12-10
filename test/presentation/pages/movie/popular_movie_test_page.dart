import 'package:ditonton/presentation/bloc/movie/popular_movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie-page/popular_movies_page.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import '../../../helpers/bloc-helper/movie/popular-movie/fake_popular_movie_bloc.dart';
import '../../../helpers/bloc-helper/movie/popular-movie/fake_popular_movie_event.dart';
import '../../../helpers/bloc-helper/movie/popular-movie/fake_popular_movie_state.dart';

void main() {
  late FakePopularMovieBloc fakePopularMovieBloc;

  setUp(() {
    fakePopularMovieBloc = FakePopularMovieBloc();
    registerFallbackValue(FakePopularMovieEvent());
    registerFallbackValue(FakePopularMovieState());
  });

  tearDown(() {
    fakePopularMovieBloc.close();
  });

  Widget _buildTestWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>(
      create: (_) => fakePopularMovieBloc,
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
    when(() => fakePopularMovieBloc.state).thenReturn(PopularMovieLoading());

    final circular = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_buildTestWidget(PopularMoviesPage()));
    await tester.pump();

    expect(circular, findsOneWidget);
  });

  testWidgets(
      'the page should display popular movie when the data is successfully loaded',
      (WidgetTester tester) async {
    when(() => fakePopularMovieBloc.state)
        .thenReturn(PopularMovieLoaded(testMovieList));
    await tester.pumpWidget(_buildTestWidget(PopularMoviesPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
  });
}
