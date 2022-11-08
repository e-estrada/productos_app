import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsServices extends ChangeNotifier {
  final String _baseURL = 'flutter-varios-57a0a-default-rtdb.firebaseio.com';
  final List<ProductModel> products = [];
  bool isLoading = true;
  bool isSaving = true;
  late ProductModel selectedProduct;

  ProductsServices() {
    loadProducts();
  }

  // <List<ProductModel>>
  Future<List<ProductModel>> loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseURL, 'products.json');
    final resp = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(resp.body);
    productsMap.forEach((key, value) {
      final tempProduct = ProductModel.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();

    return products;
  }

  Future saveOrCreateProduct(ProductModel product) async {
    isSaving = true;
    notifyListeners();
    if (product.id == null) {
    } else {
      await updateProduct(product);
    }
    isSaving = false;
    notifyListeners();
  }

  Future<String?> updateProduct(ProductModel product) async {
    final url = Uri.https(_baseURL, 'products/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());
    final decodedData = resp.body;
    return product.id;
  }
}
