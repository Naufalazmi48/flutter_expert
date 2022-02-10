import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'recommendation_state.dart';

class RecommendationMoviesCubit extends Cubit<RecommendationState>{
  GetMovieRecommendations _getMovieRecommendations;

  RecommendationMoviesCubit(this._getMovieRecommendations) : super(RecommendationState());

  void getRecommendationMovies(int id) async {
    emit(RecommendationState(state: RequestState.Loading));

    final result = await _getMovieRecommendations.execute(id);

    result.fold(
            (failure) => emit(RecommendationState(
            state: RequestState.Error, errorMessage: failure.message)),
            (data) => emit(RecommendationState(state: RequestState.Loaded, movies: data)));
  }
}