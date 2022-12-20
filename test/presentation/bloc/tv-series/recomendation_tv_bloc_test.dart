import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:ditonton/domain/usecases/tv-series/get_tv_recommendations.dart';
import 'package:ditonton/presentation/bloc/tv-series/tv-recomendation/tv_recomendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv-series/dummy_object_tv.dart';
import 'recomendation_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late TvRecomendationBloc tvRecomendationBloc;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    tvRecomendationBloc = TvRecomendationBloc(mockGetTvRecommendations);
  });

  final tId = 130392;

  blocTest<TvRecomendationBloc, TvRecomendationState>(
    'should change Tv Recomendation when data is gotten successfully',
    build: () {
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Right(testTvList));
      return tvRecomendationBloc;
    },
    act: (bloc) => bloc.add(GetListTvRecomendation(tId)),
    expect: () => [TvRecomendationLoading(), TvRecomendationLoaded(testTvList)],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(tId));
      return GetListTvRecomendation(tId).props;
    },
  );

  blocTest<TvRecomendationBloc, TvRecomendationState>(
    'should change Tv Recomendation when data is gotten initial',
    build: () {
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Right([]));
      return tvRecomendationBloc;
    },
    act: (bloc) => bloc.add(GetListTvRecomendation(tId)),
    expect: () => [TvRecomendationLoading(), TvRecomendationInitial()],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(tId));
      return GetListTvRecomendation(tId).props;
    },
  );

  blocTest<TvRecomendationBloc, TvRecomendationState>(
    'should update error message when request in successful',
    build: () {
      when(mockGetTvRecommendations.execute(tId)).thenAnswer((_) async =>
          Left(ServerFailure('Terjadi kesalahaan saat memuat data')));
      return tvRecomendationBloc;
    },
    act: (bloc) => bloc.add(GetListTvRecomendation(tId)),
    expect: () => [
      TvRecomendationLoading(),
      TvRecomendationError('Terjadi kesalahaan saat memuat data')
    ],
    verify: (bloc) => TvRecomendationLoading(),
  );
}
