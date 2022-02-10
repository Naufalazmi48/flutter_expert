part of 'recommendation_movies_cubit.dart';
class RecommendationState extends Equatable {
  List<Movie> movies;
  RequestState state;
  String errorMessage;

  RecommendationState({this.movies = const [], this.state = RequestState.Empty, this.errorMessage = ''});

  @override
  List<Object?> get props => [
    movies,
    state,
    errorMessage
  ];
}