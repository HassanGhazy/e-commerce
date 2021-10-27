import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/helpers/app_router.dart';
import 'package:shop/helpers/strings.dart';
import 'package:shop/providers/product_provider.dart';
import 'package:shop/ui/all_products.dart';
import 'package:shop/ui/cart.dart';
import 'package:shop/ui/favorite/favorite.dart';
import 'package:shop/ui/home/all_categories.dart';
import 'package:shop/ui/home/widgets/custom_search_delegate.dart';
import 'package:shop/ui/home/widgets/gridview_product.dart';
import 'package:shop/ui/home/widgets/text_line.dart';

class Home extends StatelessWidget {
  static const String routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () async {
              final AndroidIntent intent = AndroidIntent(
                action: 'action_application_details_settings',
                data: 'package:com.example.chat',
              );
              await intent.launch();
            },
            icon: Icon(
              Icons.message,
              color: Colors.redAccent,
            )),
        actions: [
          IconButton(
              onPressed: () async {
                await Provider.of<ProductProvider>(context, listen: false)
                    .getAllFavorites();
                AppRouter.route.pushNamed(Favorite.routeName, {});
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () async {
                await Provider.of<ProductProvider>(context, listen: false)
                    .getAllCartProvider();
                Provider.of<ProductProvider>(context, listen: false)
                    .amountAllProduct();
                AppRouter.route.pushNamed(Cart.routeName, {});
              },
              icon: Icon(Icons.shopping_cart_outlined, color: Colors.black)),
        ],
        elevation: 3,
        title: Text(
          "Home Page",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.grey[200],
                      child: TextField(
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: CustomSearchDelegate(),
                          );
                        },
                        enableInteractiveSelection: false,
                        readOnly: true,
                        showCursor: false,
                        cursorHeight: 14,
                        enableSuggestions: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                          prefixText: 'Search',
                          prefixStyle: TextStyle(color: Colors.black),
                          labelStyle: TextStyle(
                              color: Colors.black, fontSize: 10, height: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 20),
              TextLine(Strings.trendingProduct, AllProduct.routeName),
              Expanded(
                child: GridViewProduct(
                    provider.allproducts, provider, Axis.horizontal),
              ),
              SizedBox(height: 20),
              TextLine(Strings.productCategory, AllCategories.routeName),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: provider.allCategories
                      .map((String e) => GestureDetector(
                            onTap: () async {
                              provider.selectCategory(e);
                              await provider.getSpecificCategoey(e);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: provider.currentCategory == e
                                      ? Colors.redAccent
                                      : Colors.white,
                                  border: Border.all(),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(5),
                              child: Text(e[0].toUpperCase() + e.substring(1),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: provider.currentCategory == e
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                          ))
                      .toList(),
                ),
              ),
              Expanded(
                child: GridViewProduct(
                    provider.categoriesProducts, provider, Axis.horizontal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
