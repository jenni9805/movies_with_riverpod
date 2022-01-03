import 'package:dio/dio.dart';

import 'package:movies_with_riverpod/src/data_source/data_source.dart';

import 'package:movies_with_riverpod/src/model/movies/movies_object.dart';

class MoviesNowPlayingDataSource {
  final _dio = Dio();
  final _dataSource = DataSource();

  Future<List<MoviesObject>> getMovieNowPlaying() {
    _dio.options.baseUrl = _dataSource.baseUrl;
    return _dio
        .get(_dataSource.getJson(url: '/3/movie/now_playing'))
        .then((value) {
      return MoviesObject.toList(
        json: value.data['results'],
      );
    });
  }
}
