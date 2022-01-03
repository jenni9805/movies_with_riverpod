import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_with_riverpod/routes.dart';
import 'package:movies_with_riverpod/src/ui/pages/movies/movies_principal_page.dart';

class MoviesNowPlayingPage extends StatelessWidget {
  const MoviesNowPlayingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer(
      builder: (_, ref, __) {
        final response = ref.watch(responseDataNowPlaying);
        return response.when(
          data: (value) {
            return SizedBox(
              width: double.infinity,
              height: size.height * 0.3,
              child: Swiper(
                itemCount: value.length,
                layout: SwiperLayout.STACK,
                autoplay: true,
                itemWidth: size.width,
                itemHeight: size.height,
                itemBuilder: (_, index) {
                  final movie = value[index];
                  return Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              movie.getBackdropUrl(),
                            ),
                            fit: BoxFit.fill,
                            alignment: Alignment.center,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        height: 20,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                onTap: (index) {
                  final movie = value[index];
                  return Navigator.pushNamed(
                    _,
                    Routes.detailsMovies,
                    arguments: movie,
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
      },
    );
  }
}
