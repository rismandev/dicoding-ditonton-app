import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/presentation/providers/airing_today_tv_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/tv_series_card.dart';

class AiringTodayTvSeriesPage extends StatefulWidget {
  const AiringTodayTvSeriesPage({super.key});

  static const routeName = '/airing-today-tv-series';

  @override
  State<AiringTodayTvSeriesPage> createState() =>
      _AiringTodayTvSeriesPageState();
}

class _AiringTodayTvSeriesPageState extends State<AiringTodayTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<AiringTodayTvSeriesNotifier>(
        context,
        listen: false,
      ).fetchAiringTodayTvSeries(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airing Today TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<AiringTodayTvSeriesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemCount: data.tvSeries.length,
                itemBuilder: (context, index) {
                  final movie = data.tvSeries[index];
                  return TvSeriesCard(movie);
                },
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
