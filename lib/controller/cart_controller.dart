import 'package:get/get.dart';

import '../model/product.dart';

class CartController extends GetxController {
  RxList<CartItem> cartItems = RxList<CartItem>([]);

  double get totalPrice {
    double total = 0;
    for (var cartItem in cartItems) {
      total += cartItem.product.price;
    }
    return total;
  }

  void addToCart(Product product) {
    cartItems.add(CartItem(product: product));
  }

  void removeFromCart(CartItem cartItem) {
    cartItems.remove(cartItem);
  }
}

class CartItem {
  Product product;

  CartItem({required this.product});
}
