import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class MovieSearchCubit extends Cubit<SearchState> {
  SearchMovies _searchMovies;

  MovieSearchCubit(this._searchMovies) : super(SearchState());

  void searchMovie(String query) async {
    emit(SearchState(state: RequestState.Loading));

    final result = await _searchMovies.execute(query);

    result.fold(
        (failure) => emit(SearchState(
            state: RequestState.Error, errorMessage: failure.message)),
        (data) => emit(SearchState(state: RequestState.Loaded, movies: data)));
  }
}
