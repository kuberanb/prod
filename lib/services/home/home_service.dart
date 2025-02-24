import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:prod/models/home/product_model.dart';

class HomeService {
  final Dio _dio = Dio();

  Future<List<Products>> getProducts() async {
    try {
      final response = await _dio.get('https://dummyjson.com/products');
      log("Products response: ${response.data}");

      if (response.statusCode == 200) {
        final List<dynamic> products = response.data['products'];

        return products.map((json) => Products.fromJson(json)).toList();

        //  products.map((json) => Products.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      log("Error fetching products: $e");
      throw Exception('Failed to load products: $e');
    }
  }
}
