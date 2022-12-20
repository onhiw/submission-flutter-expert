import 'package:ditonton/presentation/bloc/tv-series/popular-tv/popular_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvPage extends StatefulWidget {
  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<PopularTvBloc>(context, listen: false)
            .add(GetListPopularTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvBloc, PopularTvState>(
            builder: (context, state) {
          if (state is PopularTvLoading) {
            return Center(child: const CircularProgressIndicator());
          } else if (state is PopularTvLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.tv[index];
                return TvCard(tv);
              },
              itemCount: state.tv.length,
            );
          } else if (state is PopularTvError) {
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
