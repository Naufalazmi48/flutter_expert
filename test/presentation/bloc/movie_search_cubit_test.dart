import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie/search/movie_search_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_search_cubit_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MovieSearchCubit movieSearchCubit;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    movieSearchCubit = MovieSearchCubit(mockSearchMovies);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  final tQuery = 'spiderman';

  test('Initial state should be Empty', () {
    expect(movieSearchCubit.state.state, RequestState.Empty);
    expect(movieSearchCubit.state.movies.isEmpty, true);
    expect(movieSearchCubit.state.errorMessage.isEmpty, true);
  });

  blocTest<MovieSearchCubit, SearchState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
    when(mockSearchMovies.execute(tQuery))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    return movieSearchCubit;
  },
  act: (bloc) => bloc.searchMovie(tQuery),
  expect: () => [
    SearchState(state: RequestState.Loading),
    SearchState(state: RequestState.Error, errorMessage: 'Server Failure')
  ],
  verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
  });

  blocTest<MovieSearchCubit, SearchState>(
      'Should emit [Loading, HasData] when get search is successful',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return movieSearchCubit;
      },
      act: (bloc) => bloc.searchMovie(tQuery),
      expect: () => [
        SearchState(state: RequestState.Loading),
        SearchState(state: RequestState.Loaded, movies: tMovieList)
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      });
}
