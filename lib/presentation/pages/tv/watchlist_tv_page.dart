import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist/watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv/watchlist';

  @override
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchlistTvBloc>().add(GetWatchlistTvEvents()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistTvBloc>().add(GetWatchlistTvEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
          builder: (context, data) {
            if (data is WatchlistTvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is WatchlistTvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.result[index];
                  return TvCardList(tv: tv);
                },
                itemCount: data.result.length,
              );
            } else if (data is WatchlistTvError){
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
