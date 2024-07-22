import 'package:lesson_81/core/network/dio_client.dart';
import 'package:lesson_81/data/models/product.dart';

class DioProductService {
  final dioClient = DioClient();

  Future<List<Product>> getProducts() async {
    try {
      final response = await dioClient.get(url: "/products");

      List<Product> products = [];

      for (var product in response.data) {
        products.add(Product.fromMap(product));
      }
      return products;
    } catch (e) {
      rethrow;
    }
  }


}
