import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/tv_usecase.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_state.dart';

class PopularTvCubit extends Cubit<PopularTvState> {
  TvUseCase _useCase;

  PopularTvCubit(this._useCase) : super(PopularTvState());

  void getPopularTv() async {
    emit(PopularTvState(state: RequestState.Loading));

    final result = await _useCase.getPopularTvs();

    result.fold(
            (failure) => emit(PopularTvState(
            state: RequestState.Error, errorMessage: failure.message)),
            (data) =>
            emit(PopularTvState(state: RequestState.Loaded, tvs: data)));
  }
}
