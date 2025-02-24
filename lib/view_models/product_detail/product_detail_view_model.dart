import 'package:flutter/material.dart';
import 'package:prod/services/product_detail/product_detail_service.dart';
import '../../models/home/product_model.dart';
import '../../services/home/home_service.dart';
import '../../services/internet_service.dart';

class ProductDetailViewModel extends ChangeNotifier {
  final ProductDetailService _productDetailService = ProductDetailService();
  Products? _product;
  bool _isLoading = false;
  String? _error;
  bool _hasInternet = true;

  Products? get product => _product;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasInternet => _hasInternet;

  Future<void> fetchProductDetail(int productId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    _hasInternet = await isInternetAvailable();
    if (!_hasInternet) {
      _isLoading = false;
      _error = 'No internet connection';
      notifyListeners();
      return;
    }

    try {
      _product = await _productDetailService.getProductDetail(productId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
