import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
  });

  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final int runtime;
  final double voteAverage;
  final int voteCount;
  final double popularity;

  @override
  List<Object?> get props => [
    backdropPath,
    genres,
    id,
    name,
    overview,
    posterPath,
    releaseDate,
    voteAverage,
    voteCount,
  ];
}
