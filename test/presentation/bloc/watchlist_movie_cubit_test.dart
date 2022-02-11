import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  SaveWatchlist,
  RemoveWatchlist,
  GetWatchListStatus,
])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockGetWatchListStatus mockGetWatchlistStatus;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockSaveWatchlist = MockSaveWatchlist();
    mockGetWatchlistStatus = MockGetWatchListStatus();

    watchlistMovieBloc = WatchlistMovieBloc(
        getWatchlistMovies: mockGetWatchlistMovies,
        removeWatchlist: mockRemoveWatchlist,
        saveWatchlist: mockSaveWatchlist,
        getWatchListStatus: mockGetWatchlistStatus);
  });

  final tId = 1;
  final isAdded = false;

  group('Get Watchlist Movie', () {
    test('Initial state should be Empty', () {
      expect(watchlistMovieBloc.state is WatchlistMovieEmpty, true);
    });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'Should emit [Loading, Error] when get watchlist movie is unsuccessful',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(GetWatchlistMovieEvents()),
        expect: () =>
            [WatchlistMovieLoading(), WatchlistMovieError('Server Failure')],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'Should emit [Loading, HasData] when get watchlist is successful',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Right(testMovieList));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(GetWatchlistMovieEvents()),
        expect: () =>
            [WatchlistMovieLoading(), WatchlistMovieHasData(testMovieList)],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        });
  });

  group('Watchlist', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'Should emit MovieIsAddedToWatchList when get status is success',
        build: () {
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => isAdded);
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(GetWatchlistStatusEvents(tId)),
        expect: () =>
        [
          MovieIsAddedToWatchList(isAdded)
        ],
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(tId));
        });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'Should emit WatchlistMovieError when add watchlist is success',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(AddMovieToWatchlistEvents(testMovieDetail)),
        expect: () =>
        [
          WatchlistMovieError('Server Failure')
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
        });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'Should emit WatchlistMovieMessage when add watchlist is success',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Added to Watchlist'));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(AddMovieToWatchlistEvents(testMovieDetail)),
        expect: () =>
        [
          WatchlistMovieMessage('Added to Watchlist')
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
        });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'Should emit WatchlistMovieError when removed watchlist is success',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(RemoveMovieFromWatchlistEvents(testMovieDetail)),
        expect: () =>
        [
          WatchlistMovieError('Server Failure')
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
        });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'Should emit WatchlistMovieMessage when add watchlist is success',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Removed to Watchlist'));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(RemoveMovieFromWatchlistEvents(testMovieDetail)),
        expect: () =>
        [
          WatchlistMovieMessage('Removed to Watchlist')
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
        });
  });
}
