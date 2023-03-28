import 'package:demandium/components/service_widget_vertical.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/home/web/web_recommended_service_view.dart';
import 'package:demandium/feature/provider/model/category_model_item.dart';
import 'package:get/get.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({Key? key, required this.category,}) : super(key: key);

  final CategoryModelItem category;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: category.title=="popular"?
        Theme.of(context).primaryColor.withOpacity(0.1): null,
        border: Border.symmetric(horizontal: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.5),width: 1),),
      ),
      padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT,0,Dimensions.PADDING_SIZE_DEFAULT,Dimensions.PADDING_SIZE_LARGE),
      child: category.serviceList.length>0?
      Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Padding(padding: const EdgeInsets.symmetric(vertical:Dimensions.PADDING_SIZE_DEFAULT),
          child: Row(
            children: [
              if(category.title=="popular")
                Image.asset(Images.hot,width: 20,),
              if(category.title=="popular")
                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),

              Text(category.title,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),),
            ],
          ),
        ),
        category.title=="popular"?
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount:  category.serviceList.length,
          itemBuilder: (context, index){
            Discount _discount = PriceConverter.discountCalculation(category.serviceList[index]);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: InkWell(
                onTap: () => Get.toNamed(RouteHelper.getServiceRoute(category.serviceList[index].id!)),
                child: ServiceModelView(
                  serviceList: category.serviceList,
                  discountAmountType: _discount.discountAmountType,
                  discountAmount: _discount.discountAmount,
                  index: index,
                ),
              ),
            );
          },
        ) :GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
            mainAxisSpacing:  Dimensions.PADDING_SIZE_DEFAULT,
            childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? .9 :  .70,
            mainAxisExtent:ResponsiveHelper.isMobile(context) ?  235 : 260 ,
            crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : ResponsiveHelper.isTab(context) ? 3 : 5,),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: category.serviceList.length,
          padding: EdgeInsets.symmetric(horizontal: 0),
          itemBuilder: (context, index) {
            bool _isAvailable = true;
            return ServiceWidgetVertical(service:  category.serviceList[index],  isAvailable: _isAvailable,fromType: 'provider_details',);
          },
        ),
      ]):SizedBox(),
    );
  }
}