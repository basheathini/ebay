import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class Product{
  String id;
  String description;
  String name;
  String category;
  int price;

  Product({
    this.id  ,
    this.description,
    this.name,
    this.category,
    this.price
  });

  Product.fromMap(Map data) :
        id = data['id'] ?? '',
        description = data['description'] ?? '',
        name = data['name'] ?? '',
        category = data['category'] ?? '';

}
class Products with ChangeNotifier {

  List<Product> _products = [];
  Product _product;

  Product get getProduct{
    return _product;
  }
  List<Product> get getProducts{
    return _products;
  }

  Future<void> getAllProducts(int limit, int offset) async {
    //my api wrong is definitely wrong, the documentation is bad and had to time to learn and register
    final url = "https://api.ebay.com/buy/browse/v1/item_summary/search?q=ipad&limit=${limit}&offset=${offset}";
    try{
      final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: "SBX-69e8f2e86640-5a27-467a-aacb-f97b"},);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if(extractedData == null){
        return;
      }
      extractedData.forEach((key, value) {
        _products.add(Product(
          id: key,
          description: value['description'],
          category: value['category'],
          name: value['name'],
          price: value['price'],
        ));
        notifyListeners();
      });
    }catch(error){
      throw error;
    }
  }

  Future<void> getProductProductByName(String name) async {
    _product = _products.firstWhere((product) => product.name == name);
    _products.clear();
    _products.add(_product);
    notifyListeners();
  }

  Future<void> getProductByNameFromApi(String name) async {
    final url = "https://shopping-app-flutter-36ebb.firebaseio.com/products/";
    try{
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((key, value) {
        _product = Product(id: value[''], price: value[''], name: value[''], category: value[''], description: value['']);
      });
      notifyListeners();
    }catch(error){
      throw error;
    }
  }
}