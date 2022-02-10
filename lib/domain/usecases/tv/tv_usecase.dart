import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class TvUseCase {
  final TvRepository repo;

  TvUseCase({required this.repo});

  Future<Either<Failure, List<Tv>>> getNowPlayingTvs() => repo.getNowPlayingTvs();

  Future<Either<Failure, List<Tv>>> getPopularTvs() => repo.getPopularTvs();

  Future<Either<Failure, List<Tv>>> getTopRatedTvs() => repo.getTopRatedTvs();

  Future<Either<Failure, TvDetail>> getTvDetail(int id) => repo.getTvDetail(id);

  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id) => repo.getTvRecommendations(id);

  Future<Either<Failure, List<Tv>>> searchTvs(String query) => repo.searchTvs(query);

  Future<Either<Failure, String>> saveWatchlist(TvDetail tv) => repo.saveWatchlist(tv);

  Future<Either<Failure, String>> removeWatchlist(TvDetail tv) => repo.removeWatchlist(tv);

  Future<bool> getWatchListStatus(int id) => repo.isAddedToWatchlist(id);

  Future<Either<Failure, List<Tv>>> getWatchlistTvs() => repo.getWatchlistTvs();
}
