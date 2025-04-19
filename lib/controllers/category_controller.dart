import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/category.dart';

class CategoryController extends GetxController {
  var categoryList = <Category>[].obs;
  var selectedCategory = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('http://192.168.100.7/bestlife-main/en/mobi/GetCategoryList')
      );
      
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;
        categoryList.value = jsonData.map((item) => Category.fromJson(item)).toList();
      }
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      isLoading(false);
    }
  }
} 