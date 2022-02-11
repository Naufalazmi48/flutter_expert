import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/detail/movie_detail_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_cubit_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail
])
void main() {
  late MovieDetailCubit movieDetailCubit;
  late MockGetMovieDetail mockGetMovieDetail;


  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailCubit = MovieDetailCubit(
     mockGetMovieDetail
    );
  });

  final tId = 1;

  test('Initial state should be Empty', () {
    expect(movieDetailCubit.state.state, RequestState.Empty);
    expect(movieDetailCubit.state.movieDetail == null, true);
    expect(movieDetailCubit.state.errorMessage.isEmpty, true);
  });

  blocTest<MovieDetailCubit, MovieDetailState>(
      'Should emit [Loading, Error] when get detail is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieDetailCubit;
      },
      act: (bloc) => bloc.getDetailMovie(tId),
      expect: () => [
        MovieDetailState(state: RequestState.Loading),
        MovieDetailState(state: RequestState.Error, errorMessage: 'Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      });

  blocTest<MovieDetailCubit, MovieDetailState>(
      'Should emit [Loading, HasData] when get detail is successful',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return movieDetailCubit;
      },
      act: (bloc) => bloc.getDetailMovie(tId),
      expect: () => [
        MovieDetailState(state: RequestState.Loading),
        MovieDetailState(state: RequestState.Loaded, movieDetail: testMovieDetail)
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      });
}
