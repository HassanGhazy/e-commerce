import 'package:dio/dio.dart';
import 'package:shop/models/product.dart';

class ApiHelper {
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();
  Dio dio = Dio();
  static const String baseUrl = "https://fakestoreapi.com/";
  Future<List<String>> getAllCategories() async {
    String url = '${baseUrl}products/categories';
    Response response = await dio.get(url);
    List<dynamic> categories = response.data;
    return categories.map((e) => e.toString()).toList();
  }

  Future<List<ProductModel>> getAllCategoryProducts(String categoryName) async {
    String url = '${baseUrl}products/category/$categoryName';
    Response response = await dio.get(url);

    List<dynamic> categories = response.data;
    return categories.map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<List<ProductModel>> getAllProducts() async {
    String url = '${baseUrl}products';
    Response response = await dio.get(url);
    List<dynamic> products = response.data;
    return products.map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<ProductModel> getProduct(String id) async {
    String url = '${baseUrl}products/$id';
    Response response = await dio.get(url);

    return ProductModel.fromJson(response.data);
  }
}
