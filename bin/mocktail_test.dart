import 'package:dio/dio.dart';
import 'package:mocktail_test/mocktail_test.dart';

void main(List<String> arguments) {
  final service = ApiService(dio: Dio());
  final result = service.getProducts();
  print(result);
}
