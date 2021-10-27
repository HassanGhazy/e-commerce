import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/helpers/app_router.dart';
import 'package:shop/providers/product_provider.dart';

class Cart extends StatelessWidget {
  static const String routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Cart",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () async {
              AppRouter.route.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) => provider.allCart.isEmpty
            ? Center(
                child: Text(
                  "Your Cart is Empty",
                  style: TextStyle(fontSize: 22),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: provider.allCart[index].image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 150,
                                    child: Text(
                                      provider.allCart[index].title!,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                      // overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                  ),
                                  Text(
                                    "\$${provider.allCart[index].price!}",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            await provider.removeFromCart(
                                                provider.allCart[index]);
                                          },
                                          icon: Icon(Icons.do_disturb_on)),
                                      // IconButton(onPressed: onPressed, icon: icon),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "${provider.allCart[index].quantity!}"),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            await provider.addToCart(
                                                provider.allCart[index]);
                                          },
                                          icon: Icon(Icons.control_point)),
                                    ],
                                  ),
                                  const Divider(
                                    height: 2,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      itemCount: provider.allCart.length,
                    ),
                  ),
                  Text(
                    "Total Amount",
                    style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "\$${provider.totalAmount.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 45),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              "Checkout",
                              style: TextStyle(fontSize: 20),
                            ),
                            Icon(Icons.arrow_forward)
                          ],
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )))),
                  ),
                  const SizedBox(height: 70),
                ],
              ),
      ),
    );
  }
}
