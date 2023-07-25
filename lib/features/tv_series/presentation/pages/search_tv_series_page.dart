import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/presentation/providers/search_tv_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/tv_series_card.dart';

class SearchTvSeriesPage extends StatelessWidget {
  const SearchTvSeriesPage({super.key});

  static const routeName = '/search-tv-series';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                Provider.of<SearchTvSeriesNotifier>(
                  context,
                  listen: false,
                ).fetchSearchTvSeries(query);
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text('Search Result', style: kHeading6),
            Consumer<SearchTvSeriesNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (data.state == RequestState.loaded) {
                  final result = data.tvSeries;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        final tvSeries = data.tvSeries[index];
                        return TvSeriesCard(tvSeries);
                      },
                    ),
                  );
                } else {
                  return Expanded(child: Container());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
