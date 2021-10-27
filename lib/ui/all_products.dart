import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product_provider.dart';
import 'package:shop/ui/home/widgets/gridview_product.dart';

class AllProduct extends StatelessWidget {
  static const String routeName = '/all-product';
  @override
  Widget build(BuildContext context) {
    final ProductProvider user =
        Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text("All Products"),
          centerTitle: true,
        ),
        body: GridViewProduct(user.allproducts, user, Axis.vertical));
  }
}
