import 'package:get/get.dart';

import '../modules/product/ui/view/product_screen/product_api_controller.dart';
import 'app_routes.dart';
import 'app_screen.dart';


class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.product,
      page: () => AppScreens.product,
      binding: BindingsBuilder(() {
        Get.put(ProductController());
      }),
    ),
    GetPage(
      name: AppRoutes.productDetails,
      page: () => AppScreens.productDetails,
      binding: BindingsBuilder(() {
        Get.put(());
      }),
    ),

  ];
}
