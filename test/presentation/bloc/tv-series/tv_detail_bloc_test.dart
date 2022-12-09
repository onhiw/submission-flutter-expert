import 'package:ditonton/domain/usecases/tv-series/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv-series/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/tv-series/get_watchlisttv_status.dart';
import 'package:ditonton/domain/usecases/tv-series/remove_watchlisttv.dart';
import 'package:ditonton/domain/usecases/tv-series/save_watchlisttv.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListTvStatus,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {}
