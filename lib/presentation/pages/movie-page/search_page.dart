import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/movie/movie-search/movie_search_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<MovieSearchBloc>().add(GetListSearchMovie(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<MovieSearchBloc, MovieSearchState>(
                builder: (context, state) {
              if (state is MovieSearchLoading) {
                return Center(child: const CircularProgressIndicator());
              } else if (state is MovieSearchLoaded) {
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = state.movie[index];
                      return MovieCard(movie);
                    },
                    itemCount: state.movie.length,
                  ),
                );
              } else if (state is MovieSearchError) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(state.message),
                ));
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}
