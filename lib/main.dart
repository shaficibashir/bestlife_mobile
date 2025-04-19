import 'package:lookme/controllers/category_controller.dart';
import 'package:lookme/routes/router.dart';
import 'package:lookme/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lookme/controllers/cart_controller.dart';
import 'package:lookme/controllers/product_images_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(CartController(), permanent: true);
  Get.put(ProductImagesController());
  Get.put(CategoryController());
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: IKAppTheme.lightTheme,
      darkTheme: IKAppTheme.darkTheme,
      initialRoute: '/main_home',
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
