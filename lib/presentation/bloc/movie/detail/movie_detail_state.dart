part of 'movie_detail_cubit.dart';

class MovieDetailState extends Equatable {
  MovieDetail? movieDetail;
  RequestState state;
  String errorMessage;

  MovieDetailState(
      {this.movieDetail,
      this.state = RequestState.Empty,
      this.errorMessage = ''});

  @override
  List<Object?> get props => [movieDetail, state, errorMessage];
}
