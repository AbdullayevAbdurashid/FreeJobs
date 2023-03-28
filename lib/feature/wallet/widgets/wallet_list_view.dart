import 'package:demandium/components/paginated_list_view.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/loyalty_point/model/loyalty_point_model.dart';
import 'package:demandium/feature/wallet/controller/wallet_controller.dart';
import 'package:demandium/feature/wallet/widgets/wallet_list_item.dart';
import 'package:get/get.dart';

class WalletListView extends StatelessWidget {
  const WalletListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return GetBuilder<WalletController>(builder: (walletController){
      List<LoyaltyPointTransactionData> listOfTransaction = walletController.listOfTransaction;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_SMALL),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
          Text('wallet_history'.tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge,color: Theme.of(context).textTheme.bodyLarge!.color),),
          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
          listOfTransaction.length>0?
          PaginatedListView(
            scrollController: scrollController,
            totalSize: walletController.walletTransactionModel!.content!.transactions!.total!,
            onPaginate: (int offset) async => await walletController.getWalletTransactionData(
              offset, reload: false,
            ),
            offset: walletController.walletTransactionModel!.content!.transactions?.currentPage != null ?
            walletController.walletTransactionModel!.content!.transactions?.currentPage  != null ?
            walletController.walletTransactionModel!.content!.transactions?.currentPage:null:null,
            itemView: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveHelper.isDesktop(context)?2:1,
                mainAxisExtent: 120,crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT),
              itemCount: listOfTransaction.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return WalletListItem(transactionData: listOfTransaction[index],);
              },),
          ):NoDataScreen(text: 'no_transaction_yet'.tr,type: NoDataType.TRANSACTION,),
        ],),
      );
    });
  }
}

