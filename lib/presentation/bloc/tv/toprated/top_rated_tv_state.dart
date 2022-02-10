part of 'top_rated_tv_cubit.dart';

class TopRatedTvState extends Equatable {
  List<Tv> tvs;
  RequestState state;
  String errorMessage;

  TopRatedTvState(
      {this.tvs = const [],
        this.state = RequestState.Empty,
        this.errorMessage = ''});

  @override
  List<Object?> get props => [tvs, state, errorMessage];
}
