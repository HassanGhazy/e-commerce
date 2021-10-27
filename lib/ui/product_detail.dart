import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/helpers/app_router.dart';
import 'package:shop/providers/product_provider.dart';

class ProductDetails extends StatelessWidget {
  static const String routeName = '/product-details';
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, product, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () async {
                  await product.updateFavorite(product.selectedProduct!);
                },
                icon: Icon(
                  Icons.favorite,
                  color: product.allFavorites.any((element) =>
                          element.id == product.selectedProduct!.id!)
                      ? Colors.red
                      : Colors.black,
                ))
          ],
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                AppRouter.route.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width / 2,
                  child: CachedNetworkImage(
                    imageUrl: product.selectedProduct!.image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                product.selectedProduct!.title!,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star_border,
                          color: Colors.redAccent,
                        ),
                        Text(
                            '${product.selectedProduct!.rating == null ? "un avaliable" : product.selectedProduct!.rating!.rate!}'),
                      ],
                    ),
                    Text(
                      '\$${product.selectedProduct!.price!}',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Decription:',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '${product.selectedProduct!.description!}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 45,
                    width: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.redAccent,
                        border:
                            Border.all(color: Colors.black.withOpacity(.2))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await product
                                .removeFromCart(product.selectedProduct!);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Icon(
                              Icons.minimize,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        Text(
                          '${product.selectedProduct!.quantity ?? 0}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await product.addToCart(product.selectedProduct!);
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () async {
                  //     await product.addToCart(product.selectedProduct!);
                  //   },
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     child: Text(
                  //       "Add to cart",
                  //       style: TextStyle(fontSize: 20, color: Colors.white),
                  //     ),
                  //     height: 50,
                  //     width: 200,
                  //     decoration: BoxDecoration(
                  //       color: Colors.redAccent,
                  //       borderRadius: BorderRadius.circular(30),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
