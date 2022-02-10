part of 'recommendation_tv_cubit.dart';

class RecommendationTvState extends Equatable {
  List<Tv> tvs;
  RequestState state;
  String errorMessage;

  RecommendationTvState(
      {this.tvs = const [],
        this.state = RequestState.Empty,
        this.errorMessage = ''});

  @override
  List<Object?> get props => [tvs, state, errorMessage];
}