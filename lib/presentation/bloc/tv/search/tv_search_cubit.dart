import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/tv_usecase.dart';
import 'package:equatable/equatable.dart';

part 'tv_search_state.dart';

class TvSearchCubit extends Cubit<TvSearchState> {
  TvUseCase _useCase;

  TvSearchCubit(this._useCase) : super(TvSearchState());

  void searchTv(String query) async {
    emit(TvSearchState(state: RequestState.Loading));

    final result = await _useCase.searchTvs(query);

    result.fold(
            (failure) => emit(TvSearchState(
            state: RequestState.Error, errorMessage: failure.message)),
            (data) =>
            emit(TvSearchState(state: RequestState.Loaded, tvs: data)));
  }
}
