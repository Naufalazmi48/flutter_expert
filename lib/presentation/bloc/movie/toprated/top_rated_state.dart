part of 'top_rated_movies_cubit.dart';

class TopRatedState extends Equatable {
  List<Movie> movies;
  RequestState state;
  String errorMessage;

  TopRatedState(
      {this.movies = const [],
      this.state = RequestState.Empty,
      this.errorMessage = ''});

  @override
  List<Object?> get props => [movies, state, errorMessage];
}
