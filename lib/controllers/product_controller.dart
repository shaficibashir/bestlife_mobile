import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class ProductController extends GetxController {
  var productList = <Product>[].obs;
  var isLoading = true.obs;
  var responseText = ''.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProductsByCategory(String categoryId) async {
    try {

      print( categoryId);
      isLoading.value = true;
      var response = await http.get(
        Uri.parse('http://192.168.100.7/bestlife-main/en/mobi/getProductsByCategory/$categoryId')
      );
      
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;
        productList.value = jsonData.map((item) => Product.fromJson(item)).toList();
      }
    } catch (e) {
      print('Error fetching products by category: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      var response = await http.get(
        Uri.parse('http://192.168.100.7/bestlife-main/en/mobi/getProductList')
      );
      
      // First, store and print the raw response
      responseText.value = response.body;
      print('API Response: ${response.body}');

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;
        productList.value = jsonData.map((item) => Product.fromJson(item)).toList();
      }
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading.value = false;
    }
  }
} 