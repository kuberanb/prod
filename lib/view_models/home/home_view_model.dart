import 'package:flutter/material.dart';
import '../../models/home/product_model.dart';
import '../../services/home/home_service.dart';
import '../../services/internet_service.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeService _homeService = HomeService();

  // final ProductService _productService = ProductService();

  List<Products> _products = [];
  bool _isLoading = false;
  String? _error;
  bool _hasInternet = true;

  List<Products> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasInternet => _hasInternet;

  Future<void> checkInternet() async {
    _hasInternet = await isInternetAvailable();
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await checkInternet();
    if (!_hasInternet) {
      _isLoading = false;
      _error = 'No internet connection';
      notifyListeners();
      return;
    }

    try {
      final response = await _homeService.getProducts();
      _products = response;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
