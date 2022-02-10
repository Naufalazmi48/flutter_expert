import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvModel(
    firstAirDate: '2019-06-16',
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTv = Tv(
    firstAirDate: '2019-06-16',
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of Tv entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
