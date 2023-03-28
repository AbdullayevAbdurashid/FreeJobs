import 'package:demandium/feature/loyalty_point/model/loyalty_point_model.dart';

class WalletTransactionModel {

  Content? content;
  WalletTransactionModel({this.content});

  WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    content = json['content'] != null ? new Content.fromJson(json['content']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    return data;
  }
}

class Content {
  double? walletBalance;
  Transactions? transactions;

  Content({this.walletBalance, this.transactions});

  Content.fromJson(Map<String, dynamic> json) {
    walletBalance = double.tryParse(json['wallet_balance'].toString());
    transactions = json['transactions'] != null
        ? new Transactions.fromJson(json['transactions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet_balance'] = this.walletBalance;
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.toJson();
    }
    return data;
  }
}

