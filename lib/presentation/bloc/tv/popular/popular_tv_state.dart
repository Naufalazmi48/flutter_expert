part of 'popular_tv_cubit.dart';

class PopularTvState extends Equatable {
  List<Tv> tvs;
  RequestState state;
  String errorMessage;

  PopularTvState(
      {this.tvs = const [],
        this.state = RequestState.Empty,
        this.errorMessage = ''});

  @override
  List<Object?> get props => [tvs, state, errorMessage];
}