part of 'popular_movies_cubit.dart';

class PopularState extends Equatable {
  List<Movie> movies;
  RequestState state;
  String errorMessage;

  PopularState({this.movies = const [], this.state = RequestState.Empty, this.errorMessage = ''});

  @override
  List<Object?> get props => [
    movies,
    state,
    errorMessage
  ];
}