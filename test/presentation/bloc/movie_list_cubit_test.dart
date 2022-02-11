import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/movie/onplaying/movie_list_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_cubit_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MovieListCubit movieListCubit;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    movieListCubit = MovieListCubit(
      mockGetNowPlayingMovies,
    );
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

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(movieListCubit.state.nowPlayingState, RequestState.Empty);
      expect(movieListCubit.state.nowPlayingMovies.isEmpty, true);
      expect(movieListCubit.state.errorMessage.isEmpty, true);
    });

    blocTest<MovieListCubit, MovieListState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return movieListCubit;
        },
        act: (bloc) => bloc.getNowPlayingMovies(),
        expect: () => [
          MovieListState(nowPlayingState: RequestState.Loading),
          MovieListState(nowPlayingState: RequestState.Error, errorMessage: 'Server Failure')
        ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        });

    blocTest<MovieListCubit, MovieListState>(
        'Should emit [Loading, HasData] when get search is successful',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return movieListCubit;
        },
        act: (bloc) => bloc.getNowPlayingMovies(),
        expect: () => [
          MovieListState(nowPlayingState: RequestState.Loading),
          MovieListState(nowPlayingState: RequestState.Loaded, nowPlayingMovies: tMovieList)
        ],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        });
  });
}
