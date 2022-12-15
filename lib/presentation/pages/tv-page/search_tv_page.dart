import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/tv-series/tv-search/tv_search_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTvPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tv';

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
                context.read<TvSearchBloc>().add(GetListSearchTv(query));
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
            BlocBuilder<TvSearchBloc, TvSearchState>(builder: (context, state) {
              if (state is TvSearchLoading) {
                return Center(child: const CircularProgressIndicator());
              } else if (state is TvSearchLoaded) {
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final tv = state.tv[index];
                      return TvCard(tv);
                    },
                    itemCount: state.tv.length,
                  ),
                );
              } else if (state is TvSearchError) {
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
