import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv/popular/popular_tv_cubit.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PopularTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv/popular';

  @override
  _PopularTvPageState createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularTvCubit>(context, listen: false)
            .getPopularTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvCubit, PopularTvState>(
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
