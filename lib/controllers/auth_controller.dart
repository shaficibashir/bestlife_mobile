import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static const String baseUrl = 'http://192.168.100.7/bestlife-main/en';
  static const String loginEndpoint = '$baseUrl/login';
  static const String registerEndpoint = '$baseUrl/register';
  
  // Store user data
  static Future<void> storeUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userData', jsonEncode(userData));
  }

  // Get stored user data
  static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString('userData');
    if (userDataString != null) {
      return jsonDecode(userDataString);
    }
    return null;
  }

  // Clear user data (logout)
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userData');
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final userData = await getUserData();
    return userData != null;
  }

  // Login function
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(loginEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          await storeUserData(data['customer']);
          return {'success': true, 'data': data['customer']};
        } else {
          return {'success': false, 'message': data['message'] ?? 'Login failed'};
        }
      } else {
        return {'success': false, 'message': 'Server error occurred'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error occurred'};
    }
  }

  // Register function
  static Future<Map<String, dynamic>> register(
    String email,
    String password,
    String firstName,
    String lastName,
    String phone,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(registerEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'firstname': firstName,
          'lastname': lastName,
          'phone': phone,
        }),
      );

      print(jsonEncode({
          'email': email,
          'password': password,
          'firstname': firstName,
          'lastname': lastName,
          'phone': phone,
        }));

        // print(response.body);


      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        if (data['success'] == true) {
          await storeUserData(data['customer']);
          return {'success': true, 'data': data['customer']};
        } else {
          return {'success': false, 'message': data['message'] ?? 'Registration failed'};
        }
      } else {
        return {'success': false, 'message': 'Server error occurred'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error occurred'};
    }
  }
} 