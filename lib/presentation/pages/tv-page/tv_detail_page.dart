import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/presentation/bloc/tv-series/detail-tv/detail_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv-series/tv-recomendation/tv_recomendation_bloc.dart';
import 'package:ditonton/presentation/bloc/tv-series/tv_watchlist/tv_watchlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvDetailPage extends StatefulWidget {
  final int id;
  TvDetailPage({required this.id});

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<DetailTvBloc>().add(GetSingleDetailTv(widget.id));
      context
          .read<TvRecomendationBloc>()
          .add(GetListTvRecomendation(widget.id));
      context.read<TvWatchlistBloc>().add(GetListTvWatchlistStatus(widget.id));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isAddedToWatchlistTv = context.select<TvWatchlistBloc, bool>((bloc) {
      if (bloc.state is TvWatchlistIsAdded) {
        return (bloc.state as TvWatchlistIsAdded).isAdded;
      }
      return false;
    });
    return Scaffold(
      body: BlocBuilder<DetailTvBloc, DetailTvState>(builder: (context, state) {
        if (state is DetailTvLoading) {
          return Center(child: const CircularProgressIndicator());
        } else if (state is DetailTvLoaded) {
          return SafeArea(
            child: DetailTvContent(
                tvDetail: state.tvDetail,
                isAddedWatchlistTv: isAddedToWatchlistTv),
          );
        } else if (state is DetailTvError) {
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

class DetailTvContent extends StatefulWidget {
  final TvDetail tvDetail;
  bool isAddedWatchlistTv;

  DetailTvContent({
    Key? key,
    required this.tvDetail,
    required this.isAddedWatchlistTv,
  }) : super(key: key);

  @override
  State<DetailTvContent> createState() => _DetailTvContentState();
}

class _DetailTvContentState extends State<DetailTvContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${widget.tvDetail.posterPath}',
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
                              widget.tvDetail.name!,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                String message = "";
                                if (!widget.isAddedWatchlistTv) {
                                  context
                                      .read<TvWatchlistBloc>()
                                      .add(TvWatchlistAdd(widget.tvDetail));
                                } else {
                                  context
                                      .read<TvWatchlistBloc>()
                                      .add(TvWatchlistRemove(widget.tvDetail));
                                }
                                final state =
                                    BlocProvider.of<TvWatchlistBloc>(context)
                                        .state;

                                if (state is TvWatchlistIsAdded) {
                                  message = state.isAdded == false
                                      ? "Added to Watchlist"
                                      : "Removed from Watchlist";
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  message = !widget.isAddedWatchlistTv
                                      ? "Added to Watchlist"
                                      : "Removed from Watchlist";
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                }
                                setState(() {
                                  widget.isAddedWatchlistTv =
                                      !widget.isAddedWatchlistTv;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlistTv
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.tvDetail.genres!),
                            ),
                            // Text(
                            //   _showDuration(tvDetail.runtime),
                            // ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tvDetail.voteAverage! / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tvDetail.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tvDetail.overview!,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvRecomendationBloc,
                                    TvRecomendationState>(
                                builder: (context, state) {
                              if (state is TvRecomendationLoading) {
                                return Center(
                                    child: const CircularProgressIndicator());
                              } else if (state is TvRecomendationLoaded) {
                                return Container(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final tv = state.tv[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              detailTvRoute,
                                              arguments: tv.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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
                                    itemCount: state.tv.length,
                                  ),
                                );
                              } else if (state is TvRecomendationError) {
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
