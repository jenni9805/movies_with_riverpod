import 'package:dio/dio.dart';
import 'package:movies_with_riverpod/src/data_source/data_source.dart';
import 'package:movies_with_riverpod/src/model/series/series_object.dart';

class SeriesPopularDataSource{
  final _dio = Dio();
  final _dataSource = DataSource();

  Future<List<SeriesObject>> getSeriesPopular() {
    _dio.options.baseUrl = _dataSource.baseUrl;
    return _dio.get(_dataSource.getJson(url: '/3/tv/popular')).then(
          (value) => SeriesObject.toList(
        json: value.data['results'],
      ),
    );
  }
}