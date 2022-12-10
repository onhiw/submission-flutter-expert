import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tv-series/popular-tv/popular_tv_bloc.dart';

class FakePopularTvBloc extends MockBloc<PopularTvEvent, PopularTvState>
    implements PopularTvBloc {}
