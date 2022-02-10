import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie/toprated/top_rated_movies_cubit.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([TopRatedMoviesCubit])
void main() {
  late MockTopRatedMoviesCubit mockTopRatedMoviesCubit;

  setUp(() {
    mockTopRatedMoviesCubit = MockTopRatedMoviesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesCubit>.value(
      value: mockTopRatedMoviesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockTopRatedMoviesCubit.stream).thenAnswer(
        (_) => Stream.value(TopRatedState(state: RequestState.Loading)));

    when(mockTopRatedMoviesCubit.state)
        .thenReturn(TopRatedState(state: RequestState.Loading));
    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockTopRatedMoviesCubit.stream).thenAnswer((_) => Stream.value(
        TopRatedState(state: RequestState.Loaded, movies: <Movie>[])));

    when(mockTopRatedMoviesCubit.state).thenReturn(
        TopRatedState(state: RequestState.Loaded, movies: <Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockTopRatedMoviesCubit.stream).thenAnswer((_) => Stream.value(
        TopRatedState(state: RequestState.Error, errorMessage: 'Error')));

    when(mockTopRatedMoviesCubit.state).thenReturn(
        TopRatedState(state: RequestState.Error, errorMessage: 'Error'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
