import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:ditonton/domain/usecases/tv-series/search_tv.dart';
import 'package:ditonton/presentation/bloc/tv-series/tv-search/tv_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv-series/dummy_object_tv.dart';
import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late TvSearchBloc tvSearchBloc;
  late MockSearchTv mockSearchTv;

  setUp(() {
    mockSearchTv = MockSearchTv();
    tvSearchBloc = TvSearchBloc(mockSearchTv);
  });

  final tQuery = 'game of thrones';

  blocTest<TvSearchBloc, TvSearchState>(
    'should change Tv Search when data is gotten successfully',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Right(testTvList));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(GetListSearchTv(tQuery)),
    expect: () => [TvSearchLoading(), TvSearchLoaded(testTvList)],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
      return GetListSearchTv(tQuery).props;
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'should change Tv Search when data is gotten initial',
    build: () {
      when(mockSearchTv.execute(tQuery)).thenAnswer((_) async => Right([]));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(GetListSearchTv(tQuery)),
    expect: () => [TvSearchLoading(), TvSearchInitial()],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
      return GetListSearchTv(tQuery).props;
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'should update error message when request in successful',
    build: () {
      when(mockSearchTv.execute(tQuery)).thenAnswer((_) async =>
          Left(ServerFailure('Terjadi kesalahaan saat memuat data')));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(GetListSearchTv(tQuery)),
    expect: () => [
      TvSearchLoading(),
      TvSearchError('Terjadi kesalahaan saat memuat data')
    ],
    verify: (bloc) => TvSearchLoading(),
  );
}
