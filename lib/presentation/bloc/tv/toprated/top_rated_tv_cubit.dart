import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/tv_usecase.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_state.dart';

class TopRatedTvCubit extends Cubit<TopRatedTvState> {
  TvUseCase _useCase;

  TopRatedTvCubit(this._useCase) : super(TopRatedTvState());

  void getTopRatedTv() async {
    emit(TopRatedTvState(state: RequestState.Loading));

    final result = await _useCase.getTopRatedTvs();

    result.fold(
        (failure) => emit(TopRatedTvState(
            state: RequestState.Error, errorMessage: failure.message)),
        (data) =>
            emit(TopRatedTvState(state: RequestState.Loaded, tvs: data)));
  }
}
