import 'package:demandium/components/paginated_list_view.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/loyalty_point/controller/loyalty_point_controller.dart';
import 'package:demandium/feature/loyalty_point/model/loyalty_point_model.dart';
import 'package:demandium/feature/loyalty_point/widgets/loyalty_point_itemview.dart';
import 'package:get/get.dart';

class LoyaltyPointListView extends StatelessWidget {
  const LoyaltyPointListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return GetBuilder<LoyaltyPointController>(builder: (loyaltyPointController){
      List<LoyaltyPointTransactionData> listOfTransaction = loyaltyPointController.listOfTransaction;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_SMALL),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
          Text('point_history'.tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
              color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
          listOfTransaction.length>0?
          PaginatedListView(
            scrollController: scrollController,
            totalSize: loyaltyPointController.loyaltyPointModel!.content!.transactions!.total!,
            onPaginate: (int offset) async => await loyaltyPointController.getLoyaltyPointData(
              offset, reload: false,
            ),
            offset: loyaltyPointController.loyaltyPointModel!.content!.transactions?.currentPage != null ?
            loyaltyPointController.loyaltyPointModel!.content!.transactions?.currentPage  != null ?
            loyaltyPointController.loyaltyPointModel!.content!.transactions?.currentPage:null:null,
            itemView: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveHelper.isDesktop(context)?2:1,
                mainAxisExtent: 120,crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT),
              itemCount: listOfTransaction.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return LoyaltyPointItemView(transactionData: listOfTransaction[index],);
              },),
          ):NoDataScreen(text: 'no_transaction_yet'.tr,type: NoDataType.TRANSACTION,),
        ],),
      );
    });
  }
}

