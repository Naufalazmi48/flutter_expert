import 'package:equatable/equatable.dart';

class Tv extends Equatable {

  Tv({
    required this.firstAirDate,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  Tv.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  String? firstAirDate;
  String? backdropPath;
  List<int>? genreIds;
  int id;
  String? name;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;
  
  
  @override
  // TODO: implement props
  List<Object?> get props => [
    firstAirDate,
    backdropPath,
    genreIds,
    id,
    name,
    overview,
    popularity,
    posterPath,
    voteAverage,
    voteCount,
  ];
}
