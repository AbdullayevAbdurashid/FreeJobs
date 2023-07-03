import 'package:demandium/data/provider/client_api.dart';
import 'package:demandium/utils/app_constants.dart';
import 'package:get/get.dart';

class WalletRepo{
  final ApiClient apiClient;
  WalletRepo({required this.apiClient});

  Future<Response> getWalletTransactionData(int offset) async {
    return await apiClient.getData("${AppConstants.walletTransactionData}?limit=10&offset=$offset");
  }
}