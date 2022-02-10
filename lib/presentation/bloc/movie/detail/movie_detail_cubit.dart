import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  GetMovieDetail _getMovieDetail;

  MovieDetailCubit(this._getMovieDetail)
      : super(MovieDetailState(state: RequestState.Empty));

  void getDetailMovie(int id) async {
    emit(MovieDetailState(state: RequestState.Loading));

    final result = await _getMovieDetail.execute(id);

    result.fold(
        (failure) => emit(MovieDetailState(
            state: RequestState.Error, errorMessage: failure.message)),
        (data) => emit(
            MovieDetailState(state: RequestState.Loaded, movieDetail: data)));
  }
}
