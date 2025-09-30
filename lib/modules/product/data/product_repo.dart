import 'package:product_api_call/modules/product/data/product_model.dart';
import '../../../api/api_client.dart';
import '../../../api/uistate.dart';
import '../../../utils/error_helper.dart';
import '../../../utils/network_manager.dart';

class StandardApiRepo {
  Future<void> getProductsList({
    required Function(UiState<List<Productlist>>) callback,
  }) async {
    callback.call(UiState.loading());

    if (!await isNetworkAvailable()) {
      callback.call(UiState.error("No Internet available."));
      return;
    }

    final res = await GetConnectApiClient.instance.getProducts();

    if (res.isOk) {
      try {
        final categories = (res.body as List<dynamic>)
            .map((e) => Productlist.fromJson(e as Map<String, dynamic>))
            .toList();
        callback.call(UiState.success(categories));
      } catch (e) {
        callback.call(UiState.error(e.toString()));
      }
    } else {
      callback.call(UiState.error(getErrorMsg(res)));
    }
  }
}