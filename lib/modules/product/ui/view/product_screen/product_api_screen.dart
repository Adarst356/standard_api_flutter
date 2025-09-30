import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_api_call/modules/product/ui/view/product_screen/product_api_controller.dart';

class ProductApiScreen extends GetView<ProductController> {
  const ProductApiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: Obx(() {
        final state = controller.productsState.value;

        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.isError) {
          return Center(child: Text("Error: ${state.getErrorOrNull()}"));
        } else if (state.isSuccess) {
          final products = state.getDataOrNull();
          if (products?.isEmpty ?? true) {
            return const Center(child: Text("No products available"));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items in one row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: products?.length ?? 0,
            itemBuilder: (context, index) {
              final product = products?[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(
                          product?.images?.isNotEmpty == true ? product!.images!.first : "",
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image_not_supported, size: 50),
                        ),
                      ),
                    ),
                    // Product Details
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product?.title ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product?.description ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "₹${product?.price ?? 0}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const SizedBox();
      }),
    );
  }
}
