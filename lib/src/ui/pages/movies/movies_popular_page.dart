import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_with_riverpod/routes.dart';
import 'package:movies_with_riverpod/src/ui/pages/movies/movies_principal_page.dart';
import 'package:movies_with_riverpod/src/ui/widgets/card_general.dart';


class MoviesPopularPage extends StatelessWidget {
  const MoviesPopularPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, __){
      final response = ref.watch(responseDataPopular);
      return response.when(
        data: (value) {
          return Container(
            height: 300,
            color: Colors.transparent,
            child: ListView.builder(
              itemCount: value.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                final movie = value[index];
                return Consumer(
                  builder: (_, ref, __) {
                    int position = index;
                    return CardGeneral(
                      image: movie.getPosterUrl(),
                      title: movie.title,
                      stars: movie.voteAverage,
                      position: position,
                      route: () {
                        final movie = value[position];
                        Navigator.pushNamed(
                        _,
                        Routes.detailsMovies,
                        arguments: movie,
                      );
                      },
                    );
                  },
                );
              },
            ),
          );
        },
        error: (e, stack) {
          return Text('error en: $e');
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
