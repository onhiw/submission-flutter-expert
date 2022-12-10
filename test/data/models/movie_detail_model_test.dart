import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMoviedetailModel = MovieDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 1,
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: 'homepage',
      id: 1,
      imdbId: 'imdbId',
      originalLanguage: 'originalLanguage',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 1,
      runtime: 1,
      status: 'status',
      tagline: 'tagline',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1);

  final tMovieDetail = MovieDetail(
      adult: false,
      backdropPath: 'backdropPath',
      genres: [Genre(id: 1, name: 'Action')],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      runtime: 1,
      title: 'title',
      voteAverage: 1,
      voteCount: 1);

  test('should be a subclass of Movie Detail entity', () async {
    final result = tMoviedetailModel.toEntity();
    expect(result, tMovieDetail);
  });
}
