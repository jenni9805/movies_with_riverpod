import 'package:movies_with_riverpod/src/resources/endpoints.dart';

class DataSource {
  final String baseUrl = Endpoints.serviceMovies;
  final String _key = Endpoints.key;
  final String _language = 'es-ES';

  String getJson({
    required String url,
  }) =>
      '$url?api_key=$_key&language=$_language';
}
