import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_state.dart';

class TopRatedMoviesCubit extends Cubit<TopRatedState> {
  GetTopRatedMovies _topRatedMovies;

  TopRatedMoviesCubit(this._topRatedMovies) : super(TopRatedState());

  void getTopRatedMovies() async {
    emit(TopRatedState(state: RequestState.Loading));

    final result = await _topRatedMovies.execute();

    result.fold(
        (failure) => emit(TopRatedState(
            state: RequestState.Error, errorMessage: failure.message)),
        (data) =>
            emit(TopRatedState(state: RequestState.Loaded, movies: data)));
  }
}
