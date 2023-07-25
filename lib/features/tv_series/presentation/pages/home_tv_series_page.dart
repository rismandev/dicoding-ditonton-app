import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/presentation/providers/tv_series_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/constants.dart';
import 'airing_today_tv_series_page.dart';
import 'detail_tv_series_page.dart';
import 'popular_tv_series_page.dart';
import 'search_tv_series_page.dart';
import 'top_rated_tv_series_page.dart';

class HomeTvSeriesPage extends StatefulWidget {
  static const routeName = '/tv-series';

  const HomeTvSeriesPage({super.key});

  @override
  State<HomeTvSeriesPage> createState() => _HomeTvSeriesPageState();
}

class _HomeTvSeriesPageState extends State<HomeTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<TvSeriesListNotifier>(context, listen: false)
          ..fetchAiringTodayTvSeries()
          ..fetchPopularTvSeries()
          ..fetchTopRatedTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvSeriesPage.routeName);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Airing Today',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AiringTodayTvSeriesPage.routeName,
                  );
                },
              ),
              Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
                final state = data.airingTodayState;
                if (state == RequestState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state == RequestState.loaded) {
                  return TvSeriesListWidget(data.airingTodayTvSeries);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopularTvSeriesPage.routeName);
                },
              ),
              Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
                final state = data.popularTvSeriesState;
                if (state == RequestState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state == RequestState.loaded) {
                  return TvSeriesListWidget(data.popularTvSeries);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(context, TopRatedTvSeriesPage.routeName);
                },
              ),
              Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
                final state = data.topRatedTvSeriesState;
                if (state == RequestState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state == RequestState.loaded) {
                  return TvSeriesListWidget(data.topRatedTvSeries);
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: kHeading6),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvSeriesListWidget extends StatelessWidget {
  final List<TvSeries> movies;

  const TvSeriesListWidget(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DetailTvSeriesPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
