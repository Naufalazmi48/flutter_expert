part of 'tv_detail_cubit.dart';

class TvDetailState extends Equatable {
  TvDetail? tvDetail;
  RequestState state;
  String errorMessage;

  TvDetailState(
      {this.tvDetail, this.state = RequestState.Empty, this.errorMessage = ''});

  @override
  List<Object?> get props => [tvDetail, state, errorMessage];
}
