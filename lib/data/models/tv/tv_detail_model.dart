import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailResponse extends Equatable {
  TvDetailResponse({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.name,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<GenreModel> genres;
  final int id;
  final String name;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final int runtime;
  final double voteAverage;
  final int voteCount;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        backdropPath: json['backdrop_path'],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json['id'],
        name: json['name'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        releaseDate: json['first_air_date'],
        runtime: json['episode_run_time'][0],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
      );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "id": id,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "first_air_date": releaseDate,
    "episode_run_time": runtime,
    "name": name,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };

  TvDetail toEntity() {
    return TvDetail(
      backdropPath: this.backdropPath,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      id: this.id,
      name: this.name,
      overview: this.overview,
      posterPath: this.posterPath,
      popularity: this.popularity,
      releaseDate: this.releaseDate,
      runtime: this.runtime,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    backdropPath,
    genres,
    id,
    overview,
    popularity,
    posterPath,
    releaseDate,
    runtime,
    voteAverage,
    voteCount,
  ];
}
