import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movies/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movies/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movies/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movies/save_watchlist.dart';
import 'package:ditonton/domain/usecases/movies/search_movies.dart';
import 'package:ditonton/domain/usecases/tv-series/get_now_playing_tv.dart';
import 'package:ditonton/domain/usecases/tv-series/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/tv-series/get_top_rated_tv.dart';
import 'package:ditonton/domain/usecases/tv-series/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv-series/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/tv-series/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv-series/get_watchlisttv_status.dart';
import 'package:ditonton/domain/usecases/tv-series/remove_watchlisttv.dart';
import 'package:ditonton/domain/usecases/tv-series/save_watchlisttv.dart';
import 'package:ditonton/domain/usecases/tv-series/search_tv.dart';
import 'package:ditonton/presentation/bloc/movie/detail-movie/detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie-recomendation/movie_recomendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie-search/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/now-playing/now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top-rated/top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/tv-series/detail-tv/detail_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv-series/now-playing-tv/now_playing_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv-series/popular-tv/popular_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv-series/top-rated-tv/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv-series/tv-recomendation/tv_recomendation_bloc.dart';
import 'package:ditonton/presentation/bloc/tv-series/tv-search/tv_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv-series/tv_watchlist/tv_watchlist_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc movie
  locator.registerFactory(() => NowPlayingBloc(locator()));
  locator.registerFactory(() => DetailMovieBloc(locator()));
  locator.registerFactory(() => MovieSearchBloc(locator()));
  locator.registerFactory(() => PopularMovieBloc(locator()));
  locator.registerFactory(() => TopRatedBloc(locator()));
  locator.registerFactory(() => MovieRecomendationBloc(locator()));
  locator.registerFactory(() => MovieWatchlistBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  // bloc tv
  locator.registerFactory(() => NowPlayingTvBloc(locator()));
  locator.registerFactory(() => DetailTvBloc(locator()));
  locator.registerFactory(() => TvSearchBloc(locator()));
  locator.registerFactory(() => PopularTvBloc(locator()));
  locator.registerFactory(() => TopRatedTvBloc(locator()));
  locator.registerFactory(() => TvRecomendationBloc(locator()));
  locator.registerFactory(() => TvWatchlistBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case tv
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListTvStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // repository movie
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // repository tv
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources movie
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // data sources tv
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
