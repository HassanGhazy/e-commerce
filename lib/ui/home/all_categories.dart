import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/helpers/app_router.dart';
import 'package:shop/providers/product_provider.dart';
import 'package:shop/ui/home/widgets/gridview_product.dart';

class AllCategories extends StatelessWidget {
  static const String routeName = '/all-categories';
  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).currentCategory = null;
    return Consumer<ProductProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            provider.currentCategory == null
                ? "All Categories"
                : provider.currentCategory![0].toUpperCase() +
                    provider.currentCategory!.substring(1),
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
              onPressed: () => AppRouter.route.back(),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: provider.allCategories
                    .map((String e) => GestureDetector(
                          onTap: () async {
                            provider.selectCategory(e);
                            provider.loading = true;
                            await provider.getSpecificCategoey(e);
                            provider.loading = false;
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
            provider.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: GridViewProduct(
                        provider.categoriesProducts, provider, Axis.vertical)),
          ],
        ),
      ),
    );
  }
}
