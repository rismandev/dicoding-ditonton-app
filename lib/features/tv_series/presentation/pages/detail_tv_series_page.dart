import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/presentation/providers/detail_tv_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../genre/domain/entities/genre.dart';
import '../../domain/entities/tv_series.dart';
import '../../domain/entities/tv_series_detail.dart';

class DetailTvSeriesPage extends StatefulWidget {
  final int id;

  const DetailTvSeriesPage({
    super.key,
    required this.id,
  });

  static const routeName = '/detail-tv-series';

  @override
  State<DetailTvSeriesPage> createState() => _DetailTvSeriesPageState();
}

class _DetailTvSeriesPageState extends State<DetailTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<DetailTvSeriesNotifier>(
        context,
        listen: false,
      ).fetchDetailTvSeries(widget.id);
    });
    Provider.of<DetailTvSeriesNotifier>(
      context,
      listen: false,
    ).loadWatchlistStatus(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailTvSeriesNotifier>(
        builder: (context, provider, child) {
          if (provider.state == RequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.state == RequestState.loaded) {
            final tvSeriesDetail = provider.tvSeries;
            return SafeArea(
              child: DetailContent(
                tvSeries: tvSeriesDetail,
                recommendations: provider.tvSeriesRecommendations,
                isAddedWatchlist: provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail tvSeries;
  final List<TvSeries> recommendations;
  final bool isAddedWatchlist;

  const DetailContent({
    super.key,
    required this.tvSeries,
    required this.recommendations,
    this.isAddedWatchlist = false,
  });

  void _onClickWatchlist(BuildContext context) {
    if (!isAddedWatchlist) {
      Provider.of<DetailTvSeriesNotifier>(
        context,
        listen: false,
      ).addWatchlist(tvSeries);
    } else {
      Provider.of<DetailTvSeriesNotifier>(
        context,
        listen: false,
      ).removeFromWatchlist(tvSeries);
    }

    final message = Provider.of<DetailTvSeriesNotifier>(
      context,
      listen: false,
    ).watchlistMessage;

    if (message == DetailTvSeriesNotifier.watchlistAddSuccessMessage ||
        message == DetailTvSeriesNotifier.watchlistRemoveSuccessMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
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
                            Text(tvSeries.name, style: kHeading5),
                            ElevatedButton(
                              onPressed: () => _onClickWatchlist(context),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tvSeries.genres),
                              style: kBodyText.copyWith(color: kMikadoYellow),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text('Total Season : '),
                                Text('${tvSeries.numberOfSeasons}'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text('Total Episode : '),
                                Text('${tvSeries.numberOfEpisodes}'),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeries.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text('Overview', style: kHeading6),
                            Text(
                              tvSeries.overview.isEmpty
                                  ? '-'
                                  : tvSeries.overview,
                            ),
                            const SizedBox(height: 16),
                            Text('Recommendations', style: kHeading6),
                            Consumer<DetailTvSeriesNotifier>(
                              builder: (context, data, child) {
                                if (data.recommendationState ==
                                    RequestState.loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (data.recommendationState ==
                                    RequestState.error) {
                                  return Text(data.message);
                                } else if (data.recommendationState ==
                                    RequestState.loaded) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: recommendations.length,
                                      itemBuilder: (context, index) {
                                        return TvSeriesRecommendationCard(
                                          rTvSeries: recommendations[index],
                                        );
                                      },
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
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
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
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}

class TvSeriesRecommendationCard extends StatelessWidget {
  const TvSeriesRecommendationCard({
    super.key,
    required this.rTvSeries,
  });

  final TvSeries rTvSeries;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(
            context,
            DetailTvSeriesPage.routeName,
            arguments: rTvSeries.id,
          );
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          child: CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${rTvSeries.posterPath}',
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
