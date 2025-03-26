import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:havahawai/services/api_service.dart';
import 'package:havahawai/model/product.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final productListProvider = FutureProvider.autoDispose<List<Product>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.fetchProducts();
});