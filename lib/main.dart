import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/features/movie/presentation/pages/home_movie_page.dart';
import 'package:ditonton/init_provider.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return InitProviderWidget(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        navigatorObservers: [routeObserver],
        initialRoute: HomeMoviePage.routeName,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
