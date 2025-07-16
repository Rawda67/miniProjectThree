import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mini_poject3/models/ProductResponce.dart';

class StoreServices {
  final dio = Dio();
  Future<List<String>?> loadCategories() async {
    final url = 'https://dummyjson.com/products/category-list';
    final resp = await dio.get(url);
    if (resp.statusCode == 200) {
      final Categories =
          List.from(resp.data).map((cat) => cat.toString()).toList();
      return Categories;
    } else {
      return null;
    }
  }

  Future<ProductResponce?> loadProductsByCategory(String category) async {
    final url = 'https://dummyjson.com/products/category/$category';
    final resp = await dio.get(url);
    if (resp.statusCode == 200) {
      final productresp = productResponceFromJson(json.encode(resp.data));
      return productresp;
    } else {
      return null;
    }
  }
}
