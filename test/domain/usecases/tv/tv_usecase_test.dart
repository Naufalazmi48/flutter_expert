import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/tv_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TvUseCase usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = TvUseCase(repo: mockTvRepository);
  });

  group('Get Tv Detail Usecase', () {
    test('should get tv detail from the repository', () async {
      final tId = 1;
      // arrange
      when(mockTvRepository.getTvDetail(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      // act
      final result = await usecase.getTvDetail(tId);
      // assert
      expect(result, Right(testTvDetail));
    });
  });
  
  group('Get Tv Recommendations Usecase', () {
    final tId = 1;
    final tTvs = <Tv>[];

    test('should get list of Tv recommendations from the repository',
            () async {
          // arrange
          when(mockTvRepository.getTvRecommendations(tId))
              .thenAnswer((_) async => Right(tTvs));
          // act
          final result = await usecase.getTvRecommendations(tId);
          // assert
          expect(result, Right(tTvs));
        });
  });
  
  group('Get On The Air Tv Usecase', () {
    final tTvs = <Tv>[];

    test('should get list of Tvs from the repository', () async {
      // arrange
      when(mockTvRepository.getNowPlayingTvs())
          .thenAnswer((_) async => Right(tTvs));
      // act
      final result = await usecase.getNowPlayingTvs();
      // assert
      expect(result, Right(tTvs));
    });
  });
  
  group('Get Popular Tv Usecase', () {
    final tTvs = <Tv>[];
    test(
        'should get list of Tvs from the repository when execute function is called',
            () async {
          // arrange
          when(mockTvRepository.getPopularTvs())
              .thenAnswer((_) async => Right(tTvs));
          // act
          final result = await usecase.getPopularTvs();
          // assert
          expect(result, Right(tTvs));
        });
  });
  
  group('Get Top Rated Tv Usecase', () {
    final tTvs = <Tv>[];

    test('should get list of Tvs from repository', () async {
      // arrange
      when(mockTvRepository.getTopRatedTvs())
          .thenAnswer((_) async => Right(tTvs));
      // act
      final result = await usecase.getTopRatedTvs();
      // assert
      expect(result, Right(tTvs));
    });
  });
  
  group('Get Watchlist Tv Usecase', () {
    test('should get list of Tvs from the repository', () async {
      // arrange
      when(mockTvRepository.getWatchlistTvs())
          .thenAnswer((_) async => Right(testTvList));
      // act
      final result = await usecase.getWatchlistTvs();
      // assert
      expect(result, Right(testTvList));
    });
  });

  group('Get Watchlist Tv Status', () {
    test('should get watchlist status from repository', () async {
      // arrange
      when(mockTvRepository.isAddedToWatchlist(1))
          .thenAnswer((_) async => true);
      // act
      final result = await usecase.getWatchListStatus(1);
      // assert
      expect(result, true);
    });
  });

  group('Remove Watchlist Tv Status', () {
    test('should remove watchlist Tv from repository', () async {
      // arrange
      when(mockTvRepository.removeWatchlist(testTvDetail))
          .thenAnswer((_) async => Right('Removed from watchlist'));
      // act
      final result = await usecase.removeWatchlist(testTvDetail);
      // assert
      verify(mockTvRepository.removeWatchlist(testTvDetail));
      expect(result, Right('Removed from watchlist'));
    });
  });

  group('Save Watchlist Tv Usecase', () {
    test('should save Tv to the repository', () async {
      // arrange
      when(mockTvRepository.saveWatchlist(testTvDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      // act
      final result = await usecase.saveWatchlist(testTvDetail);
      // assert
      verify(mockTvRepository.saveWatchlist(testTvDetail));
      expect(result, Right('Added to Watchlist'));
    });
  });

  group('Search Tv Usecase', () {
    final tTvs = <Tv>[];
    final tQuery = 'Spiderman';

    test('should get list of Tvs from the repository', () async {
      // arrange
      when(mockTvRepository.searchTvs(tQuery))
          .thenAnswer((_) async => Right(tTvs));
      // act
      final result = await usecase.searchTvs(tQuery);
      // assert
      expect(result, Right(tTvs));
    });
  });
}