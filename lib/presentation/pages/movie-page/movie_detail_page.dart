import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/detail-movie/detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie-recomendation/movie_recomendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailMovieBloc>().add(GetSingleDetailMovie(widget.id));
      context
          .read<MovieRecomendationBloc>()
          .add(GetListMovieRecomendation(widget.id));
      context
          .read<MovieWatchlistBloc>()
          .add(GetListMovieWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAddedToWatchlist = context.select<MovieWatchlistBloc, bool>((bloc) {
      if (bloc.state is MovieWatchlistIsAdded) {
        return (bloc.state as MovieWatchlistIsAdded).isAdded;
      }
      return false;
    });
    return Scaffold(
      body: BlocBuilder<DetailMovieBloc, DetailMovieState>(
          builder: (context, state) {
        if (state is DetailMovieLoading) {
          return Center(child: const CircularProgressIndicator());
        } else if (state is DetailMovieLoaded) {
          return SafeArea(
            child: DetailContent(
                movie: state.movieDetail, isAddedWatchlist: isAddedToWatchlist),
          );
        } else if (state is DetailMovieError) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(state.message),
          ));
        } else {
          return Container();
        }
      }),
    );
  }
}

class DetailContent extends StatefulWidget {
  final MovieDetail movie;
  bool isAddedWatchlist;

  DetailContent({
    Key? key,
    required this.movie,
    required this.isAddedWatchlist,
  }) : super(key: key);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                String message = "";
                                if (!widget.isAddedWatchlist) {
                                  context
                                      .read<MovieWatchlistBloc>()
                                      .add(MovieWatchlistAdd(widget.movie));
                                } else {
                                  context
                                      .read<MovieWatchlistBloc>()
                                      .add(MovieWatchlistRemove(widget.movie));
                                }
                                final state =
                                    BlocProvider.of<MovieWatchlistBloc>(context)
                                        .state;

                                if (state is MovieWatchlistIsAdded) {
                                  message = state.isAdded == false
                                      ? "Added to Watchlist"
                                      : "Removed from Watchlist";
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  message = !widget.isAddedWatchlist
                                      ? "Added to Watchlist"
                                      : "Removed from Watchlist";
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                }
                                setState(() {
                                  widget.isAddedWatchlist =
                                      !widget.isAddedWatchlist;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.movie.genres),
                            ),
                            Text(
                              _showDuration(widget.movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.movie.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<MovieRecomendationBloc,
                                    MovieRecomendationState>(
                                builder: (context, state) {
                              if (state is MovieRecomendationLoading) {
                                return Center(
                                    child: const CircularProgressIndicator());
                              } else if (state is MovieRecomendationLoaded) {
                                return Container(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final movie = state.movie[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              MovieDetailPage.ROUTE_NAME,
                                              arguments: movie.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                              placeholder: (context, url) =>
                                                  Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: state.movie.length,
                                  ),
                                );
                              } else if (state is MovieRecomendationError) {
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
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
