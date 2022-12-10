import 'package:ditonton/presentation/bloc/tv-series/popular-tv/popular_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv-page/popular_tv_page.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/tv-series/dummy_object_tv.dart';
import '../../../helpers/bloc-helper/tv-series/popular-tv/fake_popular_tv_bloc.dart';
import '../../../helpers/bloc-helper/tv-series/popular-tv/fake_popular_tv_event.dart';
import '../../../helpers/bloc-helper/tv-series/popular-tv/fake_popular_tv_state.dart';

void main() {
  late FakePopularTvBloc fakePopularTvBloc;

  setUp(() {
    fakePopularTvBloc = FakePopularTvBloc();
    registerFallbackValue(FakePopularTvEvent());
    registerFallbackValue(FakePopularTvState());
  });

  tearDown(() {
    fakePopularTvBloc.close();
  });

  Widget _buildTestWidget(Widget body) {
    return BlocProvider<PopularTvBloc>(
      create: (_) => fakePopularTvBloc,
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
    when(() => fakePopularTvBloc.state).thenReturn(PopularTvLoading());

    final circular = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_buildTestWidget(PopularTvPage()));
    await tester.pump();

    expect(circular, findsOneWidget);
  });

  testWidgets(
      'the page should display popular Tv when the data is successfully loaded',
      (WidgetTester tester) async {
    when(() => fakePopularTvBloc.state).thenReturn(PopularTvLoaded(testTvList));
    await tester.pumpWidget(_buildTestWidget(PopularTvPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvCard), findsOneWidget);
  });
}
