

import 'package:flutter/material.dart';
import 'package:ticketing_system/services/ticket_system_service.dart';

import '../model/product.dart';

class ProductController extends ChangeNotifier {
  List<Product> productsList = [];

  bool isLoading = false;

  postGetAllProducts() async {
    isLoading = true;
    productsList = (await getAllProducts());
    isLoading = false;
    notifyListeners();
  }

  
}
