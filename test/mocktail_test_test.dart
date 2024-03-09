import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_test/mocktail_test.dart';
import 'package:test/test.dart';

class DioMock extends Mock implements Dio {}

class ResponseMock extends Mock implements Response {}

void main() {
  final DioMock dio = DioMock();
  final ResponseMock response = ResponseMock();
  final ApiService service = ApiService(dio: dio);

  tearDown(() {
    reset(dio);
    reset(response);
  });

  test('Must be return a list of Products', () async {
    when(() => response.data).thenReturn(productsJsonList);
    when(() => dio.get(any())).thenAnswer((_) async => response);

    expect(
        service.getProducts(),
        completion([
          Product(id: '123', title: 'Product 1', price: 123.0),
          Product(id: '124', title: 'Product 2', price: 123.0)
        ]));
  });

  test('Must be return a empty list when error', () {
    when(() => dio.get(any())).thenThrow(Exception());

    expect(service.getProducts(), completion([]));
  });
}

final productsJsonList = [
  {'id': '123', 'title': 'Product 1', 'price': 123.0},
  {'id': '124', 'title': 'Product 2', 'price': 123.0}
];
