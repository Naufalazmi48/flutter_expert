import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie/popular/popular_movies_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_notifier_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesCubit popularMoviesCubit;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesCubit = PopularMoviesCubit(mockGetPopularMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  test('Initial state should be Empty', () {
    expect(popularMoviesCubit.state.state, RequestState.Empty);
    expect(popularMoviesCubit.state.movies.isEmpty, true);
    expect(popularMoviesCubit.state.errorMessage.isEmpty, true);
  });

  blocTest<PopularMoviesCubit, PopularState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularMoviesCubit;
      },
      act: (bloc) => bloc.getPopularMovies(),
      expect: () => [
        PopularState(state: RequestState.Loading),
        PopularState(state: RequestState.Error, errorMessage: 'Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      });

  blocTest<PopularMoviesCubit, PopularState>(
      'Should emit [Loading, HasData] when get search is successful',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return popularMoviesCubit;
      },
      act: (bloc) => bloc.getPopularMovies(),
      expect: () => [
        PopularState(state: RequestState.Loading),
        PopularState(state: RequestState.Loaded, movies: tMovieList)
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      });
}
