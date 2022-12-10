import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv-series/get_tv_detail.dart';
import 'package:ditonton/presentation/bloc/tv-series/detail-tv/detail_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv-series/dummy_object_tv.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late DetailTvBloc detailTvBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    detailTvBloc = DetailTvBloc(mockGetTvDetail);
  });

  final tId = 130392;

  blocTest<DetailTvBloc, DetailTvState>(
    'should change Tv when data is gotten successfully',
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      return detailTvBloc;
    },
    act: (bloc) => bloc.add(GetSingleDetailTv(tId)),
    expect: () => [DetailTvLoading(), DetailTvLoaded(testTvDetail)],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(tId));
      return GetSingleDetailTv(tId).props;
    },
  );

  blocTest<DetailTvBloc, DetailTvState>(
    'should update error message when request in successful',
    build: () {
      when(mockGetTvDetail.execute(tId)).thenAnswer((_) async =>
          Left(ServerFailure('Terjadi kesalahaan saat memuat data')));
      return detailTvBloc;
    },
    act: (bloc) => bloc.add(GetSingleDetailTv(tId)),
    expect: () => [
      DetailTvLoading(),
      DetailTvError('Terjadi kesalahaan saat memuat data')
    ],
    verify: (bloc) => DetailTvLoading(),
  );
}
