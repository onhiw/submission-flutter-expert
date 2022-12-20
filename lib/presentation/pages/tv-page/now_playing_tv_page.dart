import 'package:ditonton/presentation/bloc/tv-series/now-playing-tv/now_playing_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingTvPage extends StatefulWidget {
  @override
  State<NowPlayingTvPage> createState() => _NowPlayingTvPageState();
}

class _NowPlayingTvPageState extends State<NowPlayingTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<NowPlayingTvBloc>(context, listen: false)
            .add(GetListNowPlayingTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvBloc, NowPlayingTvState>(
            builder: (context, state) {
          if (state is NowPlayingTvLoading) {
            return Center(child: const CircularProgressIndicator());
          } else if (state is NowPlayingTvLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.tv[index];
                return TvCard(tv);
              },
              itemCount: state.tv.length,
            );
          } else if (state is NowPlayingTvError) {
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
