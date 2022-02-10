import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/tv_usecase.dart';
import 'package:equatable/equatable.dart';

part 'on_air_tv_state.dart';

class OnAirTvCubit extends Cubit<OnAirTvState> {
  TvUseCase _useCase;

  OnAirTvCubit(this._useCase) : super(OnAirTvState());

  void getOnAirTv() async {
    emit(OnAirTvState(state: RequestState.Loading));

    final result = await _useCase.getNowPlayingTvs();

    result.fold(
            (failure) => emit(OnAirTvState(
            state: RequestState.Error, errorMessage: failure.message)),
            (data) =>
            emit(OnAirTvState(state: RequestState.Loaded, tvs: data)));
  }
}
