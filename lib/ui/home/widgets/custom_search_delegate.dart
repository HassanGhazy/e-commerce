import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/helpers/app_router.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/product_provider.dart';
import 'package:shop/ui/home/widgets/gridview_product.dart';

class CustomSearchDelegate extends SearchDelegate {
  final ProductProvider user = Provider.of<ProductProvider>(
      AppRouter.route.navKey.currentContext!,
      listen: false);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<ProductModel> usersRes = <ProductModel>[...user.allproducts];
    bool existFirstName = usersRes.any((ProductModel element) =>
        element.title!.toLowerCase().contains(query.toLowerCase()));
    bool existLastName = usersRes.any((ProductModel element) =>
        element.description!.toLowerCase().contains(query.toLowerCase()));

    if (existFirstName || existLastName) {
      usersRes.removeWhere((ProductModel element) =>
          !element.title!.toLowerCase().contains(query.toLowerCase().trim()) &&
          !element.description!.toLowerCase().contains(query.toLowerCase()));
    }

    return GridViewProduct(usersRes, user, Axis.vertical);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return GridViewProduct(user.allproducts, user, Axis.vertical);
  }
}
