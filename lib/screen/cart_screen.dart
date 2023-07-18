import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_fakestore/screen/home_screen.dart';

import '../controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                if (cartController.cartItems.isEmpty) {
                  return Center(
                    child: Text('Cart is empty'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: cartController.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartController.cartItems[index];
                      return ListTile(
                        leading: Image.network(cartItem.product.image),
                        title: Text(cartItem.product.title),
                        subtitle: Text(cartItem.product.price.toString()),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_shopping_cart),
                          onPressed: () {
                            cartController.removeFromCart(cartItem);
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.all(16),
            child: Obx(
              () => Text(
                'Total Price: \$${cartController.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (cartController.cartItems.isEmpty) {
                Get.dialog(
                  AlertDialog(
                    title: Text('Error'),
                    content: Text('Cart is empty. Cannot proceed to checkout.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              } else {
                Get.dialog(
                  AlertDialog(
                    title: Text('Checkout'),
                    content: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Total Price: \$${cartController.totalPrice.toStringAsFixed(2)}',
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          cartController.cartItems.clear();
                          await Get.snackbar(
                              'Success', 'Product added to cart');
                          Timer(Duration(seconds: 1), () {
                            Get.to(() => HomeScreen());
                          });
                        },
                        child: Text('Confirm Checkout'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
