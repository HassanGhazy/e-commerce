import 'package:flutter/cupertino.dart';
import 'package:shop/data/api_helper.dart';
import 'package:shop/helpers/db_helper.dart';
import 'package:shop/models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<String> allCategories = [];
  List<ProductModel> allproducts = [];
  List<ProductModel> allCart = [];
  List<ProductModel> categoriesProducts = [];
  List<ProductModel> specificCategory = [];
  List<ProductModel> allFavorites = [];
  double totalAmount = 0;
  ProductModel? selectedProduct;
  int quantityCurrentProduct = 0;
  String? currentCategory;
  bool loading = false;
  selectCategory(String cat) {
    currentCategory = cat;

    notifyListeners();
  }

  getAllCategories() async {
    allCategories = await ApiHelper.apiHelper.getAllCategories();
    notifyListeners();
  }

  getAllProducts() async {
    allproducts = await ApiHelper.apiHelper.getAllProducts();
    notifyListeners();
  }

  getSpecificProduct(String id) async {
    selectedProduct = null;
    selectedProduct = await ApiHelper.apiHelper.getProduct(id);
    notifyListeners();
  }

  void amountAllProduct() {
    totalAmount = 0;
    allCart.forEach((element) {
      totalAmount += element.price! * element.quantity!;
    });
  }

  getSpecificCategoey(String categoryName) async {
    categoriesProducts =
        await ApiHelper.apiHelper.getAllCategoryProducts(categoryName);

    notifyListeners();
  }

  Future<void> getAllFavorites() async {
    allFavorites = await DBHelper.dbhelper.getAllFavorites();
    notifyListeners();
  }

  Future<void> getAllCartProvider() async {
    allCart = await DBHelper.dbhelper.getAllCart();

    notifyListeners();
  }

  Future<void> addToCart(ProductModel pr) async {
    // allCart = await DBHelper.dbhelper.getAllCart();
    bool exist = allCart.any((p) => p.id == pr.id);

    if (exist) {
      await DBHelper.dbhelper.updateQuantityIncreasing(pr);
    } else {
      await DBHelper.dbhelper.createCart(pr);
      allCart = await DBHelper.dbhelper.getAllCart();
    }

    totalAmount += pr.price!;
    notifyListeners();
  }

  Future<void> removeFromCart(ProductModel pr) async {
    if ((pr.quantity ?? 0) > 1) {
      await DBHelper.dbhelper.updateQuantityDecreaing(pr);
    } else if (pr.quantity == 1) {
      pr.quantity = 0;
      await DBHelper.dbhelper.deleteFromCart(pr);
      allCart.removeWhere((element) => element.id == pr.id);
    }
    totalAmount -= pr.price!;

    notifyListeners();
  }

  Future<void> updateFavorite(ProductModel pr) async {
    bool productInFavourite = allFavorites.any((x) {
      return x.id == pr.id;
    });

    if (productInFavourite) {
      deleteFromFavourite(pr);
    } else {
      await DBHelper.dbhelper.createFavorite(pr);
    }

    await getAllFavorites();
    notifyListeners();
  }

  deleteFromFavourite(ProductModel pr) async {
    await DBHelper.dbhelper.deleteFavorite(pr);
    await getAllFavorites();
    notifyListeners();
  }
}
