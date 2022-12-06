import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv-series/search_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTv(mockTvRepository);
  });

  final tTv = <Tv>[];
  final tQuery = 'Game of Thrones';

  test('should get list of Tvs from the repository', () async {
    // arrange
    when(mockTvRepository.searchTvSeries(tQuery))
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTv));
  });
}
