import 'package:dio/dio.dart';

import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:movies_with_riverpod/test_src/data_source/api_data_source.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}


void main(){

  group('ApiDataSource', (){
    final Dio dio = Dio();
    ApiDataSource dataSource;
    DioAdapterMock dioAdapterMock;

    setUp((){
      dioAdapterMock = DioAdapterMock();
      dio.httpClientAdapter = dioAdapterMock;
      dataSource = ApiDataSource();
    });


    


  });



}