
import 'package:dio/dio.dart';
import 'package:prod/models/home/product_model.dart';
import 'package:prod/utils/api_end_points.dart';

class ProductDetailService{
  final Dio _dio = Dio();


  Future<Products> getProductDetail(int productId) async {
    try {
      final response = await _dio.get('${ApiEndPoints.kBaseUrl}${ApiEndPoints.products}/$productId');
      return Products.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load product details: $e');
    }
  }


}