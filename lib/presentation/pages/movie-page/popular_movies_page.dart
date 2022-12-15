import 'package:ditonton/presentation/bloc/movie/popular_movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<PopularMovieBloc>(context, listen: false)
            .add(GetListPopularMovie()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PopularMovieBloc, PopularMovieState>(
              builder: (context, state) {
            if (state is PopularMovieLoading) {
              return Center(child: const CircularProgressIndicator());
            } else if (state is PopularMovieLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movie[index];
                  return MovieCard(movie);
                },
                itemCount: state.movie.length,
              );
            } else if (state is PopularMovieError) {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(state.message),
              ));
            } else {
              return Container();
            }
          })),
    );
  }
}
