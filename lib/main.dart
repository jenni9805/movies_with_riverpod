import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_with_riverpod/routes.dart';
import 'package:movies_with_riverpod/src/ui/pages/movies/movies_details_page.dart';
import 'package:movies_with_riverpod/src/ui/screens/home_screen.dart';
import 'package:movies_with_riverpod/test_src/view/home_view.dart';


void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.homeView,
      routes: {
        Routes.homeView: (_) => const HomeView(),
        Routes.homeScreen: (_) => const HomeScreen(),
        Routes.detailsMovies: (_) => const MoviesDetailsPage(),
      },

    );
  }
}
