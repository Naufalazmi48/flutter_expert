part of 'tv_search_cubit.dart';

class TvSearchState extends Equatable {
  List<Tv> tvs;
  RequestState state;
  String errorMessage;

  TvSearchState(
      {this.tvs = const [],
        this.state = RequestState.Empty,
        this.errorMessage = ''});

  @override
  List<Object?> get props => [tvs, state, errorMessage];
}
