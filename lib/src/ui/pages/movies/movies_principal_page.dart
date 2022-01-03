import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_with_riverpod/src/data_source/movies/movies_now_playing_data_source.dart';
import 'package:movies_with_riverpod/src/data_source/movies/movies_popular_data_source.dart';
import 'package:movies_with_riverpod/src/ui/pages/movies/movies_now_playing_page.dart';
import 'package:movies_with_riverpod/src/ui/pages/movies/movies_popular_page.dart';
import 'package:movies_with_riverpod/src/ui/widgets/text_seccion.dart';

//popular

final popularProvider = Provider((ref) => MoviesPopularDataSource());

final responseDataPopular = FutureProvider.autoDispose((ref){
  final client = ref.read(popularProvider);
  return client.getMoviePopular();
});

//now_playing

final nowPlayingProvider = Provider((ref) => MoviesNowPlayingDataSource());

final responseDataNowPlaying = FutureProvider.autoDispose((ref){
  final client = ref.read(nowPlayingProvider);
  print(client.getMovieNowPlaying());
  return client.getMovieNowPlaying();
});


class MoviesPrincipalPage extends StatelessWidget {
  const MoviesPrincipalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const [
        TextSeccion(
          text: 'En cines...',
          size: 20.0,
          color: Colors.blueGrey,
        ),
        MoviesNowPlayingPage(),
        TextSeccion(
          text: 'Populares...',
          size: 20.0,
          color: Colors.blueGrey,
        ),
        Expanded(
          child: MoviesPopularPage(),
        ),
      ],
    );
  }
}
