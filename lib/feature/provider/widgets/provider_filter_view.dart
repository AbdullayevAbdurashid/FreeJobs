import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/provider/controller/provider_booking_controller.dart';
import 'package:demandium/feature/provider/widgets/customCheckBox.dart';
import 'package:demandium/feature/provider/widgets/filter_rating_widgets.dart';
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class ProviderFilterView extends StatefulWidget {

  ProviderFilterView();
  @override
  State<ProviderFilterView> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProviderFilterView> {

  @override
  Widget build(BuildContext context) {
    if(ResponsiveHelper.isDesktop(context))
      return  Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
        insetPadding: EdgeInsets.all(30),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: pointerInterceptor(),
      );
    return pointerInterceptor();
  }

  pointerInterceptor(){
    return Padding(
      padding: EdgeInsets.only(top: ResponsiveHelper.isWeb()? 0 :Dimensions.CART_DIALOG_PADDING),
      child: GetBuilder<ProviderBookingController>(builder: (providerBookingController){
        return PointerInterceptor(
          child: Container(
            width:ResponsiveHelper.isDesktop(context)? Dimensions.WEB_MAX_WIDTH/2:Dimensions.WEB_MAX_WIDTH,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
            ),
            child: Padding(padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                          SizedBox(),
                          Text('filter_data'.tr,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
                          Container(
                            height: 40, width: 40, alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white70.withOpacity(0.6),
                                boxShadow:Get.isDarkMode?null:[BoxShadow(
                                  color: Colors.grey[300]!, blurRadius: 2, spreadRadius: 1,
                                )]
                            ),
                            child: InkWell(
                                onTap: () => Get.back(),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.black54,

                                )
                            ),
                          ),
                        ],
                      ),

                      Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                        child: Text('sort_by'.tr,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault),),
                      ),

                      SizedBox(height: 38, child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: providerBookingController.sortBy.length,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                        return InkWell(
                          onTap: ()=>providerBookingController.updateSortByIndex(index),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                            margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                              color: index == providerBookingController.selectedSortByIndex?
                              Theme.of(context).colorScheme.primary.withOpacity(0.2): null,
                              border: Border.all( color: index == providerBookingController.selectedSortByIndex?
                              Theme.of(context).colorScheme.primary.withOpacity(0.6): Theme.of(context).hintColor.withOpacity(0.4)),
                            ),
                            child: Center(child: Text(providerBookingController.sortBy[index].tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                          ),
                        );},
                      )),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                      if(providerBookingController.categoryList.length>0)
                      Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                        child: Text('categories'.tr,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault),),
                      ),


                      SizedBox(height: Get.height*0.35,
                        child: ListView.builder(itemBuilder: (context,index){
                          return CustomCheckBox(title:  providerBookingController.categoryList[index].name??"",
                            value: providerBookingController.categoryCheckList[index],
                            onTap: ()=>providerBookingController.toggleFromCampaignChecked(index),
                          );
                        },itemCount: providerBookingController.categoryList.length,
                        ),
                      ),

                      Center(child: Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                        child: Text('ratings'.tr,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
                      )),

                      Center(child: FilterRatingWidgets()),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                      CustomButton(buttonText: 'search'.tr,onPressed: () async{
                        Get.back();
                        Get.dialog(CustomLoader(), barrierDismissible: false,);
                        await providerBookingController.getProviderList(1, true);
                        Get.back();
                      },),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
