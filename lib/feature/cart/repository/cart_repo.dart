import 'dart:convert';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/notification/repository/notification_repo.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  CartRepo({required this.sharedPreferences,required this.apiClient});

  List<CartModel> getCartList() {
    List<String> carts = [];
    if(sharedPreferences.containsKey(AppConstants.cartList)) {
      carts = sharedPreferences.getStringList(AppConstants.cartList)!;
    }
    List<CartModel> cartList = [];
    for (var cart in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(cart)));
    }
    return cartList;
  }

  void addToCartList(List<CartModel> cartProductList) {
    List<String> carts = [];
    for (var cartModel in cartProductList) {
      carts.add(jsonEncode(cartModel));
    }


    sharedPreferences.setStringList(AppConstants.cartList, carts);
  }

  Future<Response> addToCartListToServer(CartModelBody cartModel) async {
    return await apiClient.postData(AppConstants.addToCart, cartModel.toJson());
  }

  Future<Response> getCartListFromServer() async {
    return await apiClient.getData(AppConstants.getCartList);
  }

  Future<Response> removeCartFromServer(String cartID) async {
    return await apiClient.deleteData("${AppConstants.removeCartItem}$cartID");
  }

  Future<Response> removeAllCartFromServer() async {
    return await apiClient.deleteData(AppConstants.removeAllCartItem);
  }

  Future<Response> updateCartQuantity(String cartID, int quantity)async{
    return await apiClient.putData("${AppConstants.updateCartQuantity}$cartID", { 'quantity': quantity});
  }

  Future<Response> updateProvider(String providerId)async{
    return await apiClient.postData(AppConstants.updateCartProvider,
      { 'provider_id': providerId,
        "_method":"put"
      });
  }

  Future<Response> getProviderBasedOnSubcategory(String subcategoryId) async {
    return await apiClient.getData("${AppConstants.getProviderBasedOnSubcategory}?sub_category_id=$subcategoryId");
  }

}