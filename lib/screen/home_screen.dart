import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:test_fakestore/screen/cart_screen.dart';

import '../controller/cart_controller.dart';
import '../controller/product_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Product List'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => CartScreen());
            },
            icon: Icon(
              Icons.shopping_cart,
              size: 24,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          if (productController.products.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: productController.products.length,
              itemBuilder: (context, index) {
                final product = productController.products[index];
                return Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Container(
                          height: 50,
                          width: 50,
                          child: Image.network(
                            product.image,
                            scale: 1,
                            fit: BoxFit.scaleDown,
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Container(
                        // color: Colors.amber,
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                product.title,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      product.rating['rate'].toString(),
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    Text.rich(
                                      TextSpan(
                                        text: 'Count : ',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: product.rating['count']
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              product.category,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.normal,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // color: Colors.amber,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.attach_money,
                                    size: 12,
                                  ),
                                  Text(
                                    product.price.toString(),
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Colors.green,
                                    ),
                                    softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.add_shopping_cart,
                                  size: 18,
                                ),
                                onPressed: () {
                                  cartController.addToCart(product);
                                  // Show a snackbar or toast to indicate that the product is added to the cart
                                  Get.snackbar(
                                      'Success', 'Product added to cart');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
