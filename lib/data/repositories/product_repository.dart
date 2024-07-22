import 'package:lesson_81/data/models/product.dart';
import 'package:lesson_81/data/services/dio_product_service.dart';

class ProductRepository {
  final DioProductService _dioProductService;

  ProductRepository({required DioProductService dioProductService})
      : _dioProductService = dioProductService;

  Future<List<Product>> getProducts() async {
    return await _dioProductService.getProducts();
  }
}
