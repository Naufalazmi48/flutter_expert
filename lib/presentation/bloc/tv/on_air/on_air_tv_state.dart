part of 'on_air_tv_cubit.dart';

class OnAirTvState extends Equatable {
  List<Tv> tvs;
  RequestState state;
  String errorMessage;

  OnAirTvState(
      {this.tvs = const [],
        this.state = RequestState.Empty,
        this.errorMessage = ''});

  @override
  List<Object?> get props => [tvs, state, errorMessage];
}