import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/tv_usecase.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_state.dart';

class TvDetailCubit extends Cubit<TvDetailState> {
  TvUseCase _useCase;

  TvDetailCubit(this._useCase) : super(TvDetailState());

  void getDetailTv(int id) async {
    emit(TvDetailState(state: RequestState.Loading));

    final result = await _useCase.getTvDetail(id);

    result.fold(
        (failure) => emit(TvDetailState(
            state: RequestState.Error, errorMessage: failure.message)),
        (data) =>
            emit(TvDetailState(state: RequestState.Loaded, tvDetail: data)));
  }
}
