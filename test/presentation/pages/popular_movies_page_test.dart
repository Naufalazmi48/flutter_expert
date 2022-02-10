import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie/popular/popular_movies_cubit.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMoviesCubit])
void main() {
  late MockPopularMoviesCubit mockPopularMoviesCubit;

  setUp(() {
    mockPopularMoviesCubit = MockPopularMoviesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesCubit>.value(
      value: mockPopularMoviesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
        when(mockPopularMoviesCubit.stream).thenAnswer(
                (_) => Stream.value(PopularState(state: RequestState.Loading)));

        when(mockPopularMoviesCubit.state).thenReturn(PopularState(state: RequestState.Loading));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
        when(mockPopularMoviesCubit.stream).thenAnswer(
                (_) => Stream.value(PopularState(state: RequestState.Loaded, movies: <Movie>[])));

        when(mockPopularMoviesCubit.state).thenReturn(PopularState(state: RequestState.Loaded, movies: <Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
        when(mockPopularMoviesCubit.stream).thenAnswer(
                (_) => Stream.value(PopularState(state: RequestState.Error, errorMessage: 'Error')));

        when(mockPopularMoviesCubit.state).thenReturn(PopularState(state: RequestState.Error, errorMessage: 'Error'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
