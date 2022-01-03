import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:movies_with_riverpod/test_src/model/user_model.dart';

class ApiDataSource {
  final _dio = Dio();
  final _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<UserModel>> getData() async {
    _dio.options.baseUrl = _baseUrl;
    return _dio.get('/posts').then(
          (value) => UserModel.toList(
            json: value.data,
          ),
        );
  }
}
