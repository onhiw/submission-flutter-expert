import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv-series/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/tv-series/top-rated-tv/top_rated_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv-series/dummy_object_tv.dart';
import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late TopRatedTvBloc topRatedBloc;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedBloc = TopRatedTvBloc(mockGetTopRatedTv);
  });

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'should change Tv when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(GetListTopRatedTv()),
    expect: () => [TopRatedTvLoading(), TopRatedTvLoaded(testTvList)],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
      return GetListTopRatedTv();
    },
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'should update error message when request in successful',
    build: () {
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async =>
          Left(ServerFailure('Terjadi kesalahaan saat memuat data')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(GetListTopRatedTv()),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvError('Terjadi kesalahaan saat memuat data')
    ],
    verify: (bloc) => TopRatedTvLoading(),
  );
}
