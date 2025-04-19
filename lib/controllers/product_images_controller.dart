import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductImagesController extends GetxController {
  var isLoading = true.obs;
  var productImages = <String>[].obs;

  Future<void> fetchProductImages(String productId) async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('http://192.168.100.7/bestlife-main/en/mobi/getProductImagesByProduct/$productId')
      );
      
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;
        productImages.value = jsonData.map((item) => item['img'] as String).toList();
      }
    } catch (e) {
      print('Error fetching product images: $e');
    } finally {
      isLoading(false);
    }
  }
} 