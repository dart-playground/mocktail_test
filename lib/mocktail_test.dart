import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio});

  Future<List<Product>> getProducts() async {
    try {
      final response = await dio.get('/products');
      final list = response.data as List;
      return list.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }
}

class Product extends Equatable {
  final String id;
  final String title;
  final double price;

  Product({
    required this.id,
    required this.title,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final test = json['id'] as String;
    print(test);
    return Product(
      id: json['id'] as String,
      title: json['title'] as String,
      price: json['price'] as double,
    );
  }

  @override
  List<Object?> get props => [id, title, price];
}
