import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tv-series/tv-recomendation/tv_recomendation_bloc.dart';

class FakeTvRecomendationBloc
    extends MockBloc<TvRecomendationEvent, TvRecomendationState>
    implements TvRecomendationBloc {}
