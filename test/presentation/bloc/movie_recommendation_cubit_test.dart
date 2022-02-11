import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie/recommendations/recommendation_movies_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_recommendation_cubit_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late RecommendationMoviesCubit recommendationMoviesCubit;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMoviesCubit = RecommendationMoviesCubit(mockGetMovieRecommendations);
  });

  final tId = 1;

  test('Initial state should be Empty', () {
    expect(recommendationMoviesCubit.state.state, RequestState.Empty);
    expect(recommendationMoviesCubit.state.movies.isEmpty, true);
    expect(recommendationMoviesCubit.state.errorMessage.isEmpty, true);
  });

  blocTest<RecommendationMoviesCubit, RecommendationState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return recommendationMoviesCubit;
      },
      act: (bloc) => bloc.getRecommendationMovies(tId),
      expect: () => [
        RecommendationState(state: RequestState.Loading),
        RecommendationState(state: RequestState.Error, errorMessage: 'Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      });

  blocTest<RecommendationMoviesCubit, RecommendationState>(
      'Should emit [Loading, HasData] when get search is successful',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return recommendationMoviesCubit;
      },
      act: (bloc) => bloc.getRecommendationMovies(tId),
      expect: () => [
        RecommendationState(state: RequestState.Loading),
        RecommendationState(state: RequestState.Loaded, movies: testMovieList)
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      });

}
