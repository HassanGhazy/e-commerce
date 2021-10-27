import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product_provider.dart';
import 'package:shop/ui/home/widgets/gridview_product.dart';

class Favorite extends StatelessWidget {
  static const String routeName = '/favorite';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) => provider.allFavorites.isEmpty
            ? Center(
                child: Text(
                  "No Favorite",
                  style: TextStyle(fontSize: 22),
                ),
              )
            : GridViewProduct(provider.allFavorites, provider, Axis.vertical),
      ),
    );
  }
}
