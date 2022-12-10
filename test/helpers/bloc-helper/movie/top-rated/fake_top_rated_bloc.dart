import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie/top-rated/top_rated_bloc.dart';

class FakeTopRatedBloc extends MockBloc<TopRatedEvent, TopRatedState>
    implements TopRatedBloc {}
