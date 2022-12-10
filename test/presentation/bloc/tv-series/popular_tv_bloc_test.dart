import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv-series/get_popular_tv.dart';
import 'package:ditonton/presentation/bloc/tv-series/popular-tv/popular_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv-series/dummy_object_tv.dart';
import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late PopularTvBloc popularTvBloc;
  late MockGetPopularTv mockGetPopularTv;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    popularTvBloc = PopularTvBloc(mockGetPopularTv);
  });

  blocTest<PopularTvBloc, PopularTvState>(
    'should change Tv when data is gotten successfully',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(GetListPopularTv()),
    expect: () => [PopularTvLoading(), PopularTvLoaded(testTvList)],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
      return GetListPopularTv().props;
    },
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'should change Tv when data is gotten initial',
    build: () {
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right([]));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(GetListPopularTv()),
    expect: () => [PopularTvLoading(), PopularTvInitial()],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
      return GetListPopularTv().props;
    },
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'should update error message when request in successful',
    build: () {
      when(mockGetPopularTv.execute()).thenAnswer((_) async =>
          Left(ServerFailure('Terjadi kesalahaan saat memuat data')));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(GetListPopularTv()),
    expect: () => [
      PopularTvLoading(),
      PopularTvError('Terjadi kesalahaan saat memuat data')
    ],
    verify: (bloc) => PopularTvLoading(),
  );
}
