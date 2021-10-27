import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shop/helpers/app_router.dart';
import 'package:shop/helpers/db_helper.dart';
import 'package:shop/providers/product_provider.dart';
import 'package:shop/ui/all_products.dart';
import 'package:shop/ui/cart.dart';
import 'package:shop/ui/favorite/favorite.dart';
import 'package:shop/ui/home/all_categories.dart';
import 'package:shop/ui/home/home.dart';
import 'package:shop/ui/product_detail.dart';
import 'package:shop/ui/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.dbhelper.initDataBase();
  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<ProductProvider>(
          create: (_) => ProductProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ramni',
      navigatorKey: AppRouter.route.navKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
      ),
      home: SplashScreen(),
      routes: {
        Home.routeName: (_) => Home(),
        ProductDetails.routeName: (_) => ProductDetails(),
        Cart.routeName: (_) => Cart(),
        Favorite.routeName: (_) => Favorite(),
        AllProduct.routeName: (_) => AllProduct(),
        AllCategories.routeName: (_) => AllCategories(),
      },
    );
  }
}
