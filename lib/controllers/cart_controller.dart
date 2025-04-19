import 'package:get/get.dart';
import 'package:lookme/components/modal/success_modal.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/product.dart';
import 'package:flutter/material.dart';
import '../components/modal/confirm_modal.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;
  var isLoading = false.obs;
  final String cartKey = 'cart_items';

  @override
  void onInit() {
    // loadCartFromStorage();
    super.onInit();
  }

  // Future<void> loadCartFromStorage() async {
  //   try {
  //     isLoading(true);
  //     final prefs = await SharedPreferences.getInstance();
  //     final String? cartData = prefs.getString(cartKey);
      
  //     if (cartData != null) {
  //       final List<dynamic> decodedData = json.decode(cartData);
  //       cartItems.value = decodedData.map((item) => Product.fromJson(item)).toList();
  //     }
  //   } catch (e) {
  //     print('Error loading cart: $e');
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  // Future<void> saveCartToStorage() async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final String encodedData = json.encode(cartItems.map((item) => item.toJson()).toList());
  //     await prefs.setString(cartKey, encodedData);
  //   } catch (e) {
  //     print('Error saving cart: $e');
  //   }
  // }

  void addToCart(Product product) {
    try {
      if (product.id.isEmpty || product.productName.isEmpty) {
        throw Exception('Invalid product data');
      }

      if (!cartItems.any((item) => item.id == product.id)) {
        cartItems.add(product);
        print("Item added to cart");
        
        Get.rawSnackbar(
          messageText: Text(
            '${product.productName} added to cart',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
        );
      } else {
        Get.rawSnackbar(
          messageText: Text(
            '${product.productName} is already in your cart',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
        );
      }
    } catch (e) {
      print('Error adding to cart: $e');
      Get.rawSnackbar(
        messageText: Text(
          'Could not add item to cart',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
      );
    }
  }

  void removeFromCart(String productId) {
    try {
      cartItems.removeWhere((item) => item.id == productId);
      Get.rawSnackbar(
        messageText: Text(
          'Item removed from cart',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
      );
    } catch (e) {
      print('Error removing from cart: $e');
      Get.rawSnackbar(
        messageText: Text(
          'Could not remove item from cart',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
      );
    }
  }

  double get totalAmount {
    try {
      return cartItems.fold(0, (sum, item) => sum + (double.tryParse(item.productPrice) ?? 0));
    } catch (e) {
      print('Error calculating total: $e');
      return 0;
    }
  }
} 