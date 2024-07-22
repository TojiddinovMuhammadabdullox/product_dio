import 'package:dio/dio.dart';
import 'package:product_dio/models/product.dart';

class ProductRepository {
  final Dio _dio = Dio();

  final String baseUrl = 'https://api.escuelajs.co/api/v1/products';

  Future<List<Product>> getProducts() async {
    final response = await _dio.get(baseUrl);
    return (response.data as List)
        .map((product) => Product.fromJson(product))
        .toList();
  }

  Future<void> createProduct(Product product) async {
    await _dio.post(baseUrl, data: product.toJson());
  }

  Future<void> updateProduct(Product product) async {
    print('Sending update request with data: ${product.toJson()}');
    await _dio.put('$baseUrl/${product.id}', data: product.toJson());
  }

  Future<void> deleteProduct(int id) async {
    await _dio.delete('$baseUrl/$id');
  }
}
