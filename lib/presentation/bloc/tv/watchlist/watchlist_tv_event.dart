part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class GetWatchlistTvEvents extends WatchlistTvEvent {}

class GetWatchlistStatusEvents extends WatchlistTvEvent {
  final int id;

  GetWatchlistStatusEvents(this.id);

  @override
  List<Object> get props => [id];
}

class AddTvToWatchlistEvents extends WatchlistTvEvent {
  final TvDetail tvDetail;

  AddTvToWatchlistEvents(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class RemoveTvFromWatchlistEvents extends WatchlistTvEvent {
  final TvDetail tvDetail;

  RemoveTvFromWatchlistEvents(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}