import 'package:ditonton/features/genre/data/models/genre_model.dart';
import 'package:ditonton/features/genre/domain/entities/genre.dart';
import 'package:ditonton/features/tv_series/data/models/season_model.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_detail_model.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_model.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_table.dart';
import 'package:ditonton/features/tv_series/domain/entities/season.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series_detail.dart';

const testTvSeriesTable = TvSeriesTable(
  id: 1,
  firstAirDate: "2023-05-08",
  name: "Ojek pengkolan",
  overview: "Film layar lebar",
  posterPath: "/path.jpg",
);

final testTvSeriesMap = {
  'id': 1,
  'firstAirDate': "2023-05-08",
  'name': "Ojek pengkolan",
  'overview': "Film layar lebar",
  'posterPath': "/path.jpg",
};

const testGenreModel = GenreModel(id: 18, name: "Drama");
const testGenre = Genre(id: 18, name: "Drama");

const testSeasonModel = SeasonModel(
  airDate: "2023-05-08",
  episodeCount: 100,
  id: 1,
  name: "Season 1",
  overview: "season pertama",
  posterPath: "/path.jpg",
  seasonNumber: 1,
  voteAverage: 8.0,
);
const testSeason = Season(
  airDate: "2023-05-08",
  episodeCount: 100,
  id: 1,
  name: "Season 1",
  overview: "season pertama",
  posterPath: "/path.jpg",
  seasonNumber: 1,
  voteAverage: 8.0,
);

const testSeriesDetailModel = TvSeriesDetailModel(
  id: 1,
  adult: false,
  backdropPath: "/path.jpg",
  firstAirDate: "2023-05-08",
  genres: [testGenreModel],
  homepage: "http://gshow.com/terraepaixao",
  inProduction: true,
  lastAirDate: "2023-07-19",
  name: "Ojek pengkolan",
  numberOfEpisodes: 100,
  numberOfSeasons: 1,
  originCountry: ["ID"],
  originalLanguage: "id",
  originalName: "Ojek pengkolan",
  overview: "Film layar lebar",
  popularity: 10.5,
  posterPath: "/path.jpg",
  seasons: [testSeasonModel],
  status: "Returning Series",
  tagline: "series",
  type: "Scripted",
  voteAverage: 10.5,
  voteCount: 100,
);

const testSeriesDetail = TvSeriesDetail(
  id: 1,
  adult: false,
  backdropPath: "/path.jpg",
  firstAirDate: "2023-05-08",
  genres: [testGenre],
  lastAirDate: "2023-07-19",
  name: "Ojek pengkolan",
  numberOfEpisodes: 100,
  numberOfSeasons: 1,
  originalLanguage: "id",
  originalName: "Ojek pengkolan",
  overview: "Film layar lebar",
  popularity: 10.5,
  posterPath: "/path.jpg",
  seasons: [testSeason],
  voteAverage: 10.5,
  voteCount: 100,
);

final testSeriesModel = TvSeriesModel(
  id: 1,
  backdropPath: "/path.jpg",
  firstAirDate: "2023-05-08",
  name: "Ojek pengkolan",
  originalLanguage: "id",
  originalName: "Ojek pengkolan",
  overview: "Film layar lebar",
  popularity: 10.5,
  posterPath: "/path.jpg",
  voteAverage: 10.5,
  voteCount: 100,
  genreIds: [testGenre.id],
  originCountry: const ["BR"],
);

final testSeries = TvSeries(
  id: 1,
  backdropPath: "/path.jpg",
  firstAirDate: "2023-05-08",
  name: "Ojek pengkolan",
  originalLanguage: "id",
  originalName: "Ojek pengkolan",
  overview: "Film layar lebar",
  popularity: 10.5,
  posterPath: "/path.jpg",
  voteAverage: 10.5,
  voteCount: 100,
  genreIds: [testGenre.id],
  originCountry: const ["BR"],
);

final testWatchlistSeries = TvSeries.watchlist(
  id: 1,
  name: "Ojek pengkolan",
  overview: "Film layar lebar",
  posterPath: "/path.jpg",
  firstAirDate: "2023-05-08",
);
