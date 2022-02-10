part of 'movie_search_cubit.dart';

class SearchState extends Equatable {

  List<Movie> movies;
  RequestState state;
  String errorMessage;

  SearchState({this.movies = const [], this.state = RequestState.Empty, this.errorMessage = ''});

  @override
  List<Object?> get props => [
    movies,
    state,
    errorMessage
  ];

}