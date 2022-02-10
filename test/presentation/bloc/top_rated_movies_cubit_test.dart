import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie/toprated/top_rated_movies_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesCubit topRatedMoviesCubit;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesCubit = TopRatedMoviesCubit(mockGetTopRatedMovies);
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
    expect(topRatedMoviesCubit.state.state, RequestState.Empty);
    expect(topRatedMoviesCubit.state.movies.isEmpty, true);
    expect(topRatedMoviesCubit.state.errorMessage.isEmpty, true);
  });

  blocTest<TopRatedMoviesCubit, TopRatedState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedMoviesCubit;
      },
      act: (bloc) => bloc.getTopRatedMovies(),
      expect: () => [
        TopRatedState(state: RequestState.Loading),
        TopRatedState(state: RequestState.Error, errorMessage: 'Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      });

  blocTest<TopRatedMoviesCubit, TopRatedState>(
      'Should emit [Loading, HasData] when get search is successful',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedMoviesCubit;
      },
      act: (bloc) => bloc.getTopRatedMovies(),
      expect: () => [
        TopRatedState(state: RequestState.Loading),
        TopRatedState(state: RequestState.Loaded, movies: tMovieList)
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      });
}
