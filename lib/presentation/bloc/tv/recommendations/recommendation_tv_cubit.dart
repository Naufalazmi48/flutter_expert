import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/tv_usecase.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_tv_state.dart';

class RecommendationTvCubit extends Cubit<RecommendationTvState> {
  TvUseCase _useCase;

  RecommendationTvCubit(this._useCase) : super(RecommendationTvState());

  void getRecommendationTv(int id) async {
    emit(RecommendationTvState(state: RequestState.Loading));

    final result = await _useCase.getTvRecommendations(id);

    result.fold(
        (failure) => emit(RecommendationTvState(
            state: RequestState.Error, errorMessage: failure.message)),
        (data) =>
            emit(RecommendationTvState(state: RequestState.Loaded, tvs: data)));
  }
}
