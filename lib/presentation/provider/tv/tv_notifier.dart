import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/tv_usecase.dart';
import 'package:flutter/foundation.dart';

class TvNotifier extends ChangeNotifier {
  var _watchlistTvs = <Tv>[];
  List<Tv> get watchlistTvs => _watchlistTvs;
  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  var _nowPlayingTvs = <Tv>[];
  List<Tv> get nowPlayingTvs => _nowPlayingTvs;
  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTvs = <Tv>[];
  List<Tv> get popularTvs => _popularTvs;
  RequestState _popularTvsState = RequestState.Empty;
  RequestState get popularTvsState => _popularTvsState;

  var _topRatedTvs = <Tv>[];
  List<Tv> get topRatedTvs => _topRatedTvs;
  RequestState _topRatedTvsState = RequestState.Empty;
  RequestState get topRatedTvsState => _topRatedTvsState;

  late TvDetail _tv;
  TvDetail get tv => _tv;
  RequestState _tvDetailState = RequestState.Empty;
  RequestState get tvDetailState => _tvDetailState;

  RequestState _tvState = RequestState.Empty;
  RequestState get tvState => _tvState;

  List<Tv> _tvRecommendations = [];
  List<Tv> get tvRecommendations => _tvRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  RequestState _tvSearchState = RequestState.Empty;
  RequestState get tvSearchState => _tvSearchState;

  List<Tv> _searchResult = [];
  List<Tv> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  

  TvNotifier({required this.tvUseCase});

  final TvUseCase tvUseCase;

  Future<void> fetchNowPlayingTvs() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await tvUseCase.getNowPlayingTvs();
    result.fold(
          (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (tvData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingTvs = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvs() async {
    _popularTvsState = RequestState.Loading;
    notifyListeners();

    final result = await tvUseCase.getPopularTvs();
    result.fold(
          (failure) {
        _popularTvsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (tvData) {
        _popularTvsState = RequestState.Loaded;
        _popularTvs = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvs() async {
    _topRatedTvsState = RequestState.Loading;
    notifyListeners();

    final result = await tvUseCase.getTopRatedTvs();
    result.fold(
          (failure) {
        _topRatedTvsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (tvData) {
        _topRatedTvsState = RequestState.Loaded;
        _topRatedTvs = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchWatchlistTvs() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await tvUseCase.getWatchlistTvs();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvs = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchtvDetail(int id) async {
    _tvState = RequestState.Loading;
    notifyListeners();
    final detailResult = await tvUseCase.getTvDetail(id);
    final recommendationResult = await tvUseCase.getTvRecommendations(id);
    detailResult.fold(
          (failure) {
            _tvDetailState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (tv) {
        _recommendationState = RequestState.Loading;
        _tv = tv;
        notifyListeners();
        recommendationResult.fold(
              (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
              (tvs) {
            _recommendationState = RequestState.Loaded;
            _tvRecommendations = tvs;
          },
        );
        _tvDetailState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvDetail tv) async {
    final result = await tvUseCase.saveWatchlist(tv);

    await result.fold(
          (failure) async {
        _watchlistMessage = failure.message;
      },
          (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(TvDetail tv) async {
    final result = await tvUseCase.removeWatchlist(tv);

    await result.fold(
          (failure) async {
        _watchlistMessage = failure.message;
      },
          (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await tvUseCase.getWatchListStatus(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }

  Future<void> fetchTvSearch(String query) async {
    _tvSearchState = RequestState.Loading;
    notifyListeners();

    final result = await tvUseCase.searchTvs(query);
    result.fold(
          (failure) {
        _message = failure.message;
        _tvSearchState = RequestState.Error;
        notifyListeners();
      },
          (data) {
        _searchResult = data;
        _tvSearchState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
