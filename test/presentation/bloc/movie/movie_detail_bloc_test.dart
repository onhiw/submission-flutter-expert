import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/detail-movie/detail_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late DetailMovieBloc detailMovieBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMovieBloc = DetailMovieBloc(mockGetMovieDetail);
  });

  final tId = 1;

  blocTest<DetailMovieBloc, DetailMovieState>(
    'should change movie when data is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(GetSingleDetailMovie(tId)),
    expect: () => [DetailMovieLoading(), DetailMovieLoaded(testMovieDetail)],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
      return GetSingleDetailMovie(tId).props;
    },
  );

  blocTest<DetailMovieBloc, DetailMovieState>(
    'should update error message when request in successful',
    build: () {
      when(mockGetMovieDetail.execute(tId)).thenAnswer((_) async =>
          Left(ServerFailure('Terjadi kesalahaan saat memuat data')));
      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(GetSingleDetailMovie(tId)),
    expect: () => [
      DetailMovieLoading(),
      DetailMovieError('Terjadi kesalahaan saat memuat data')
    ],
    verify: (bloc) => DetailMovieLoading(),
  );
}
