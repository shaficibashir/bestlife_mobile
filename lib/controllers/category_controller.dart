import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/category.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var categoryList = <Category>[].obs;
  var selectedCategory = "".obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
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
        if (categoryList.isNotEmpty) {
          selectedCategory.value = categoryList[0].categoryName;
        }
      }
    } catch (e) {
      print('Error while getting categories: $e');
    } finally {
      isLoading(false);
    }
  }
} 