import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:havahawai/model/product.dart';

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com';

  Future<List<Product>> fetchProducts({int skip = 0, int limit = 10}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/products?skip=$skip&limit=$limit'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List products = data['products'];
      return products.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}