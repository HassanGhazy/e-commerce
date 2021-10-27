import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/helpers/app_router.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/product_provider.dart';
import 'package:shop/ui/product_detail.dart';

class GridViewProduct extends StatelessWidget {
  final List<ProductModel> provider;
  final ProductProvider product;
  final Axis scrollDirection;
  GridViewProduct(this.provider, this.product, this.scrollDirection);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: scrollDirection,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: scrollDirection == Axis.vertical ? 2 : 1,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<ProductProvider>(context, listen: false)
                      .selectedProduct = provider[index];
                  AppRouter.route.pushNamed(ProductDetails.routeName, {});
                },
                child: Container(
                  height: 150,
                  width: 200,
                  child: CachedNetworkImage(
                    imageUrl: provider[index].image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  provider[index].title!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              ),
              Expanded(
                child: Container(
                  child: GridTile(
                    child: Container(),
                    footer: GridTileBar(
                      leading: Text(
                        '\$${provider[index].price}',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold),
                      ),
                      title: Container(),
                      trailing: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey[200]),
                        child: IconButton(
                          icon: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.redAccent,
                          ),
                          onPressed: () async {
                            await product.addToCart(provider[index]);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
      itemCount: provider.length,
    );
  }
}
