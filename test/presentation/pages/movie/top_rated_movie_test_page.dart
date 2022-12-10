import 'package:ditonton/presentation/bloc/movie/top-rated/top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/movie-page/top_rated_movies_page.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import '../../../helpers/bloc-helper/movie/top-rated/fake_top_rated_bloc.dart';
import '../../../helpers/bloc-helper/movie/top-rated/fake_top_rated_event.dart';
import '../../../helpers/bloc-helper/movie/top-rated/fake_top_rated_state.dart';

void main() {
  late FakeTopRatedBloc fakeTopRatedBloc;

  setUp(() {
    fakeTopRatedBloc = FakeTopRatedBloc();
    registerFallbackValue(FakeTopRatedEvent());
    registerFallbackValue(FakeTopRatedState());
  });

  tearDown(() {
    fakeTopRatedBloc.close();
  });

  Widget _buildTestWidget(Widget body) {
    return BlocProvider<TopRatedBloc>(
      create: (_) => fakeTopRatedBloc,
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
    when(() => fakeTopRatedBloc.state).thenReturn(TopRatedLoading());

    final circular = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_buildTestWidget(TopRatedMoviesPage()));
    await tester.pump();

    expect(circular, findsOneWidget);
  });

  testWidgets(
      'the page should display top rated movie when the data is successfully loaded',
      (WidgetTester tester) async {
    when(() => fakeTopRatedBloc.state)
        .thenReturn(TopRatedLoaded(testMovieList));
    await tester.pumpWidget(_buildTestWidget(TopRatedMoviesPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
  });
}
