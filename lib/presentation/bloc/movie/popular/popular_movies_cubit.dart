import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_state.dart';

class PopularMoviesCubit extends Cubit<PopularState> {
  GetPopularMovies _popularMovies;

  PopularMoviesCubit(this._popularMovies) : super(PopularState());

  void getPopularMovies() async {
    emit(PopularState(state: RequestState.Loading));

    final result = await _popularMovies.execute();

    result.fold(
        (failure) => emit(PopularState(
            state: RequestState.Error, errorMessage: failure.message)),
        (data) => emit(PopularState(state: RequestState.Loaded, movies: data)));
  }
}
