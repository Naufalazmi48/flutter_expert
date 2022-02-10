import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  GetNowPlayingMovies _getNowPlayingMovies;

  MovieListCubit(this._getNowPlayingMovies) : super(MovieListState());

  void getNowPlayingMovies() async {
    emit(MovieListState(nowPlayingState: RequestState.Loading));

    final result = await _getNowPlayingMovies.execute();

    result.fold(
        (failure) => emit(MovieListState(
            nowPlayingState: RequestState.Error,
            errorMessage: failure.message)),
        (data) => emit(MovieListState(
            nowPlayingState: RequestState.Loaded, nowPlayingMovies: data)));
  }
}
