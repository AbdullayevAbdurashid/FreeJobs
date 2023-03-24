import 'dart:convert';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/notification/repository/notification_repo.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  CartRepo({required this.sharedPreferences,required this.apiClient});

  List<CartModel> getCartList() {
    List<String> carts = [];
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }
    List<CartModel> cartList = [];
    carts.forEach((cart) => cartList.add(CartModel.fromJson(jsonDecode(cart))) );
    return cartList;
  }

  void addToCartList(List<CartModel> cartProductList) {
    List<String> carts = [];
    cartProductList.forEach((cartModel) => carts.add(jsonEncode(cartModel)) );
    cartProductList.forEach((element) {
      print(element.id);
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, carts);
  }

  Future<Response> addToCartListToServer(CartModelBody cartModel) async {
    return await apiClient.postData(AppConstants.ADD_TO_CART, cartModel.toJson());
  }

  Future<Response> getCartListFromServer() async {
    return await apiClient.getData(AppConstants.GET_CART_LIST);
  }

  Future<Response> removeCartFromServer(String cartID) async {
    return await apiClient.deleteData(AppConstants.REMOVE_CART_ITEM + "$cartID");
  }

  Future<Response> removeAllCartFromServer() async {
    return await apiClient.deleteData(AppConstants.REMOVE_ALL_CART_ITEM);
  }

  Future<Response> updateCartQuantity(String cartID, int quantity)async{
    return await apiClient.putData(AppConstants.UPDATE_CART_QUANTITY+ "$cartID", { 'quantity': quantity});
  }

}