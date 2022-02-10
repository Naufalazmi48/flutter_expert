import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';
class TvModel extends Equatable {

  TvModel({
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

  String? firstAirDate;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String? name;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
    firstAirDate: json["first_air_date"],
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    popularity: json["popularity"].toDouble(),
    posterPath: json["poster_path"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
  );


  Tv toEntity() => Tv(
    firstAirDate: this.firstAirDate,
    backdropPath:this.backdropPath,
    genreIds: this.genreIds,
    id: this.id,
    name: this.name,
    overview: this.overview,
    popularity: this.popularity,
    posterPath: this.posterPath,
    voteAverage: this.voteAverage,
    voteCount: this.voteCount,
  );

  Map<String, dynamic> toJson() => {
    "first_air_date": firstAirDate,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "name": name,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };

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