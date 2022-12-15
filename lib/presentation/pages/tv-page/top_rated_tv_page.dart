import 'package:ditonton/presentation/bloc/tv-series/top-rated-tv/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    Future.microtask(() =>
        BlocProvider.of<TopRatedTvBloc>(context, listen: false)
            .add(GetListTopRatedTv()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
            builder: (context, state) {
          if (state is TopRatedTvLoading) {
            return Center(child: const CircularProgressIndicator());
          } else if (state is TopRatedTvLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.tv[index];
                return TvCard(tv);
              },
              itemCount: state.tv.length,
            );
          } else if (state is TopRatedTvError) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(state.message),
            ));
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
