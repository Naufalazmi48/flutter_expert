import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTv = Tv(
  firstAirDate: '2019-06-16',
  backdropPath: '/oKt4J3TFjWirVwBqoHyIvv5IImd.jpg',
  genreIds: [18],
  id: 85552,
  name: 'Euphoria',
  overview: 'A group of high school students navigate love and friendships in a world of drugs, sex, trauma, and social media.',
  popularity: 3549.827,
  posterPath: '/jtnfNzqZwN4E32FGGxx1YZaBWWf.jpg',
  voteAverage: 8.4,
  voteCount: 6102,
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  backdropPath: '/oKt4J3TFjWirVwBqoHyIvv5IImd.jpg',
  genres: [Genre(id: 18, name: 'Drama')],
  id: 85552,
  name: 'Euphoria',
  overview: 'A group of high school students navigate love and friendships in a world of drugs, sex, trauma, and social media.',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  voteAverage: 1,
  voteCount: 1,
  popularity: 1,
);

final testWatchlistTv = Tv.watchlist(
  id: 85552,
  name: 'Euphoria',
  posterPath: 'posterPath',
  overview: 'A group of high school students navigate love and friendships in a world of drugs, sex, trauma, and social media.',
);

final testTvTable = TvTable(
  id: 85552,
  name: 'Euphoria',
  posterPath: 'posterPath',
  overview: 'A group of high school students navigate love and friendships in a world of drugs, sex, trauma, and social media.',
);

final testTvMap = {
  'id': 85552,
  'overview': 'A group of high school students navigate love and friendships in a world of drugs, sex, trauma, and social media.',
  'posterPath': 'posterPath',
  'name': 'Euphoria',
};
