import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tv-series/tv_watchlist/tv_watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<MovieWatchlistBloc>().add(GetListMovieWatchlist()));
    Future.microtask(
        () => context.read<TvWatchlistBloc>().add(GetListTvWatchlist()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Future.microtask(
        () => context.read<MovieWatchlistBloc>().add(GetListMovieWatchlist()));
    Future.microtask(
        () => context.read<TvWatchlistBloc>().add(GetListTvWatchlist()));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.tv)),
              Tab(icon: Icon(Icons.movie)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<TvWatchlistBloc, TvWatchlistState>(
                  builder: (context, state) {
                if (state is TvWatchlistLoading) {
                  return Center(child: const CircularProgressIndicator());
                } else if (state is TvWatchlistInitial) {
                  return Center(
                      child: Text(
                    'Belum ada data',
                    style: kHeading6,
                  ));
                } else if (state is TvWatchlistLoaded) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final tv = state.tv[index];
                      return TvCard(tv);
                    },
                    itemCount: state.tv.length,
                  );
                } else if (state is MovieWatchlistError) {
                  return const Text("Terjadi kesalahaan saat memuat data");
                } else {
                  return Container();
                }
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
                  builder: (context, state) {
                if (state is MovieWatchlistLoading) {
                  return Center(child: const CircularProgressIndicator());
                } else if (state is MovieWatchlistInitial) {
                  return Center(
                      child: Text(
                    'Belum ada data',
                    style: kHeading6,
                  ));
                } else if (state is MovieWatchlistLoaded) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = state.movie[index];
                      return MovieCard(movie);
                    },
                    itemCount: state.movie.length,
                  );
                } else if (state is MovieWatchlistError) {
                  return const Text("Terjadi kesalahaan saat memuat data");
                } else {
                  return Container();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
