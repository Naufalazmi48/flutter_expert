import 'dart:convert';

import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
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
  final tTvResponseModel =
  TvResponse(tvList: <TvModel>[tTvModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/on_the_air.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "first_air_date": "2019-06-16",
            "backdrop_path": "/oKt4J3TFjWirVwBqoHyIvv5IImd.jpg",
            "genre_ids": [
              18
            ],
            "id": 85552,
            "name": "Euphoria",
            "overview": "A group of high school students navigate love and friendships in a world of drugs, sex, trauma, and social media.",
            "popularity": 3549.827,
            "poster_path": "/jtnfNzqZwN4E32FGGxx1YZaBWWf.jpg",
            "vote_average": 8.4,
            "vote_count": 6102
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}