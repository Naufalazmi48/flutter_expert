part of 'movie_list_cubit.dart';

class MovieListState extends Equatable {
  List<Movie> nowPlayingMovies;
  RequestState nowPlayingState;

  String errorMessage;

  MovieListState({
    this.nowPlayingMovies = const [], this.nowPlayingState = RequestState.Empty,
    this.errorMessage = ''
  });

  @override
  List<Object> get props => [
    nowPlayingState,
    nowPlayingMovies,
    errorMessage
  ];
}
