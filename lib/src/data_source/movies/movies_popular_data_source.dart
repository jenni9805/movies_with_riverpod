import 'package:dio/dio.dart';

import 'package:movies_with_riverpod/src/data_source/data_source.dart';

import 'package:movies_with_riverpod/src/model/movies/movies_object.dart';

class MoviesPopularDataSource {
  final _dio = Dio();
  final _dataSource = DataSource();

  Future<List<MoviesObject>> getMoviePopular() {
    _dio.options.baseUrl = _dataSource.baseUrl;
    return _dio.get(_dataSource.getJson(url: '/3/movie/popular')).then(
          (value) => MoviesObject.toList(
        json: value.data['results'],
      ),
    );
  }
}
