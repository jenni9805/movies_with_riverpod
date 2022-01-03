import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_with_riverpod/src/data_source/movies/movies_details_data_source.dart';
import 'package:movies_with_riverpod/src/model/movies/movies_object.dart';
import 'package:movies_with_riverpod/src/ui/widgets/app_bar_details.dart';
import 'package:movies_with_riverpod/src/ui/widgets/cast.dart';
import 'package:movies_with_riverpod/src/ui/widgets/overview_details.dart';
import 'package:movies_with_riverpod/src/ui/widgets/poster_and_title_details.dart';

final details = Provider((ref) => MoviesDetailsDataSource());

final responseDetailsData =
    FutureProvider.autoDispose.family((ref, int movieId) {
  final client = ref.read(details);
  return client.getMovieDetail(movieId: movieId);
});

class MoviesDetailsPage extends StatelessWidget {
  const MoviesDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MoviesObject movies =
        ModalRoute.of(context)!.settings.arguments as MoviesObject;

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.77,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  AppBarDetails(
                    image: movies.getBackdropUrl(),
                    title: movies.title,
                  ),
                  PosterAndTitleDetails(
                    id: movies.id,
                    image: movies.getPosterUrl(),
                    title: movies.title,
                    stars: movies.voteAverage,
                    duration: 'Estreno: ${movies.releaseDate}',
                  ),
                  OverviewDetails(
                    overview: movies.overview,
                  ),
                ],
              ),
            ),
          ),
          //Aqui va a ir el cast
          Expanded(
              child: Casting(
            movie: movies.id,
          ))
        ],
      ),
    );
  }
}

class Casting extends ConsumerWidget {
  final int movie;

  const Casting({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final response = ref.watch(responseDetailsData(movie));

    return response.when(
      data: (value){
        return ListView.builder(
          itemCount: value.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final cast = value[index];
            return CastCard(
              image: cast.getPosterUrl(),
              name: cast.name,
            );
          },
        );
      },
      error: (e, stack) {
        return Text('error en: $e');
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
