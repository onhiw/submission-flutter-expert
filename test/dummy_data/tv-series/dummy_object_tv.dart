import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testTv = Tv(
    backdropPath: "/7q448EVOnuE3gVAx24krzO7SNXM.jpg",
    firstAirDate: "2021-09-03",
    genreIds: [10764],
    id: 130392,
    name: "The D'Amelio Show",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "The D'Amelio Show",
    overview:
        "From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D'Amelios are faced with new challenges and opportunities they could not have imagined.",
    popularity: 22.843,
    posterPath: "/phv2Jc4H8cvRzvTKb9X1uKMboTu.jpg",
    voteAverage: 9,
    voteCount: 3145);

final testTvList = [testTv];

final testTvDetail = TvDetail(
    backdropPath: "/7q448EVOnuE3gVAx24krzO7SNXM.jpg",
    firstAirDate: "2021-09-03",
    genres: [Genre(id: 10764, name: 'Reality')],
    id: 130392,
    name: "The D'Amelio Show",
    originalLanguage: "en",
    originalName: "The D'Amelio Show",
    overview:
        "From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D'Amelios are faced with new challenges and opportunities they could not have imagined.",
    popularity: 22.843,
    posterPath: "/phv2Jc4H8cvRzvTKb9X1uKMboTu.jpg",
    voteAverage: 9,
    voteCount: 3145);

final testWatchListTv = Tv.watchlist(
    id: 1, overview: 'overview', posterPath: 'posterPath', name: 'name');

final testTvTable = TvTable(
    id: 1, name: 'name', posterPath: 'posterPath', overview: 'overview');

final testTvMap = {
  'id': 1,
  'name': 'name',
  'posterPath': 'posterPath',
  'overview': 'overview'
};
