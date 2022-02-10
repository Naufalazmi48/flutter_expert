import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/presentation/bloc/tv/detail/tv_detail_cubit.dart';
import 'package:ditonton/presentation/bloc/tv/recommendations/recommendation_tv_cubit.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist/watchlist_tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv/detail';

  final int id;

  TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvDetailCubit>(context, listen: false)
        ..getDetailTv(widget.id);
      Provider.of<RecommendationTvCubit>(context, listen: false)
        ..getRecommendationTv(widget.id);
      Provider.of<WatchlistTvBloc>(context, listen: false)
        ..add(GetWatchlistStatusEvents(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailCubit, TvDetailState>(
        builder: (context, provider) {
          final isAdded = context.select<WatchlistTvBloc, bool>((bloc) {
            if (bloc.state is TvIsAddedToWatchList) {
              return (bloc.state as TvIsAddedToWatchList).isAdded;
            }
            return false;
          });
          var tvDetail = provider.tvDetail;
          if (provider.state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.state == RequestState.Loaded &&
              tvDetail != null) {
            return BlocBuilder<RecommendationTvCubit, RecommendationTvState>(
              builder: (context, state) {
                return SafeArea(
                  child: TvDetailContent(
                    tvDetail,
                    state.tvs,
                    isAdded,
                  ),
                );
              },
            );
          } else {
            return Text(provider.errorMessage);
          }
        },
      ),
    );
  }
}

class TvDetailContent extends StatefulWidget {
  final TvDetail tv;
  final List<Tv> recommendations;
  bool isAddedWatchlist;

  TvDetailContent(this.tv, this.recommendations, this.isAddedWatchlist);

  @override
  State<TvDetailContent> createState() => _TvDetailContentState();
}

class _TvDetailContentState extends State<TvDetailContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isAddedWatchlist) {
                                  Provider.of<WatchlistTvBloc>(context, listen: false)
                                    ..add(AddTvToWatchlistEvents(widget.tv));
                                } else {
                                  Provider.of<WatchlistTvBloc>(context, listen: false)
                                    ..add(RemoveTvFromWatchlistEvents(widget.tv));
                                }

                                final state =
                                    BlocProvider.of<WatchlistTvBloc>(context)
                                        .state;

                                String message = '';
                                const addedMsg = 'Added this movie to favorite';
                                const removedMsg = 'Removed this movie from favorite';

                                if (state is TvIsAddedToWatchList) {
                                  message = (state.isAdded == false) ? addedMsg : removedMsg;
                                } else {
                                  message = (widget.isAddedWatchlist == false) ? addedMsg : removedMsg;
                                }

                                if (message == addedMsg || message == removedMsg) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));

                                  setState(() {
                                    widget.isAddedWatchlist =
                                    !widget.isAddedWatchlist;
                                  });
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.tv.genres),
                            ),
                            Text(
                              _showDuration(widget.tv.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tv.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tv.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationTvCubit, RecommendationTvState>(
                              builder: (context, data) {
                                if (data.state ==
                                    RequestState.Loading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (data.state ==
                                    RequestState.Error) {
                                  return Text(data.errorMessage);
                                } else if (data.state ==
                                    RequestState.Loaded) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = widget.recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvDetailPage.ROUTE_NAME,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: widget.recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
