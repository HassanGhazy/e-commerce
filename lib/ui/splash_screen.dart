import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product_provider.dart';
import 'package:shop/ui/home/home.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation? animation;
  @override
  void initState() {
    getData();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 100).animate(animationController!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          // animationController!.forward();
          // Navigator.of(context).pushReplacementNamed(Home.routeName);
        }
      });
    animationController!.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();

    super.dispose();
  }

  Future<void> getData() async {
    await Provider.of<ProductProvider>(context, listen: false)
        .getAllCategories();
    await Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    Provider.of<ProductProvider>(context, listen: false).currentCategory =
        Provider.of<ProductProvider>(context, listen: false)
            .allCategories
            .first;

    await Provider.of<ProductProvider>(context, listen: false)
        .getSpecificCategoey(
            Provider.of<ProductProvider>(context, listen: false)
                .currentCategory!);
    await Provider.of<ProductProvider>(context, listen: false)
        .getAllFavorites();
  }

  @override
  Widget build(BuildContext context) {
    // getData().then(
    //     (value) => Navigator.of(context).pushReplacementNamed(Home.routeName));

    return Transform.scale(
      // angle: animation!.value,
      // offset: Offset(0, 15),
      scale: animation!.value,
      child: Center(
        child: FlutterLogo(
          size: 100,
        ),
      ),
    );
  }
}
