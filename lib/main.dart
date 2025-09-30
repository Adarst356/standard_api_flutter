import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:product_api_call/modules/product/ui/view/product_screen/product_api_screen.dart';
import 'package:product_api_call/routes/app_pages.dart';
import 'package:product_api_call/routes/app_routes.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      // home: ProductApiScreen(),
      initialRoute: AppRoutes.product,
      getPages: AppPages.routes,

    );
  }
}

