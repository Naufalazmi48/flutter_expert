import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv/toprated/top_rated_tv_cubit.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TopRatedTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv/top-rated';

  @override
  _TopRatedTvPageState createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedTvCubit>(context, listen: false)
            .getTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvCubit, TopRatedTvState>(
          builder: (context, data) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tvs[index];
                  return TvCardList(tv: tv);
                },
                itemCount: data.tvs.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.errorMessage),
              );
            }
          },
        ),
      ),
    );
  }
}
