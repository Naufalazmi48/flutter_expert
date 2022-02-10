
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/tv_usecase.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final TvUseCase usecase;

  WatchlistTvBloc( this.usecase) : super(WatchlistTvEmpty()) {
    on<GetWatchlistTvEvents>((event, emit) async {
      emit(WatchlistTvLoading());

      final result = await usecase.getWatchlistTvs();
      result.fold(
        (failure) {
          emit(WatchlistTvError(failure.message));
        },
        (tvsData) {
          emit(WatchlistTvHasData(tvsData));
        },
      );
    });

    on<GetWatchlistStatusEvents>((event, emit) async {
      final id = event.id;

      final result = await usecase.getWatchListStatus(id);

      emit(TvIsAddedToWatchList(result));
    });

    on<AddTvToWatchlistEvents>((event, emit) async {
      final tv = event.tvDetail;

      final result = await usecase.saveWatchlist(tv);

      result.fold((failure) {
        emit(WatchlistTvError(failure.message));
      }, (data) {
        emit(WatchlistTvMessage(data));
      });
    });

    on<RemoveTvFromWatchlistEvents>((event, emit) async {
      final tv = event.tvDetail;

      final result = await usecase.removeWatchlist(tv);

      result.fold((failure) {
        emit(WatchlistTvError(failure.message));
      }, (data) {
        emit(WatchlistTvMessage(data));
      });
    });
  }
}
