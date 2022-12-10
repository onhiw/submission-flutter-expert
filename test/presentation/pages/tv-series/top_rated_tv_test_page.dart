import 'package:ditonton/presentation/bloc/tv-series/top-rated-tv/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv-page/top_rated_tv_page.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/tv-series/dummy_object_tv.dart';
import '../../../helpers/bloc-helper/tv-series/top-rated-tv/fake_top_rated_tv_bloc.dart';
import '../../../helpers/bloc-helper/tv-series/top-rated-tv/fake_top_rated_tv_event.dart';
import '../../../helpers/bloc-helper/tv-series/top-rated-tv/fake_top_rated_tv_state.dart';

void main() {
  late FakeTopRatedTvBloc fakeTopRatedTvBloc;

  setUp(() {
    fakeTopRatedTvBloc = FakeTopRatedTvBloc();
    registerFallbackValue(FakeTopRatedTvEvent());
    registerFallbackValue(FakeTopRatedTvState());
  });

  tearDown(() {
    fakeTopRatedTvBloc.close();
  });

  Widget _buildTestWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>(
      create: (_) => fakeTopRatedTvBloc,
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
    when(() => fakeTopRatedTvBloc.state).thenReturn(TopRatedTvLoading());

    final circular = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_buildTestWidget(TopRatedTvPage()));
    await tester.pump();

    expect(circular, findsOneWidget);
  });

  testWidgets(
      'the page should display TopRated Tv when the data is successfully loaded',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTvBloc.state)
        .thenReturn(TopRatedTvLoaded(testTvList));
    await tester.pumpWidget(_buildTestWidget(TopRatedTvPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvCard), findsOneWidget);
  });
}
