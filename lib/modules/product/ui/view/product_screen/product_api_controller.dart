import 'package:get/get.dart';
import '../../../../../api/uistate.dart';
import '../../../data/product_model.dart';
import '../../../data/product_repo.dart';

class ProductController extends GetxController {
  final StandardApiRepo repo = StandardApiRepo();


  var productsState = UiState<List<Productlist>>.loading().obs;

  @override
  void onInit() {
    super.onInit();

    getProducts();
  }

  void getProducts() {
    repo.getProductsList(
      callback: (state) {
        productsState.value = state;
      },
    );
  }
}
