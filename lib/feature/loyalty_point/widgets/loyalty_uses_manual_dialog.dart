import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/loyalty_point/controller/loyalty_point_controller.dart';
import 'package:get/get.dart';

class LoyaltyPointUsesManualDialog extends StatelessWidget {
  const LoyaltyPointUsesManualDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoyaltyPointController>(builder: (controller){
      double webPadding = (Get.width-Dimensions.WEB_MAX_WIDTH)/2;

      double minimumConvertAblePoint = double.tryParse(controller.loyaltyPointModel?.content?.minLoyaltyPointToTransfer??"0")??0;
      return Padding(
        padding:EdgeInsets.fromLTRB(ResponsiveHelper.isDesktop(context)?webPadding:20,70,ResponsiveHelper.isDesktop(context)?webPadding:20,0),
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: Column(mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(child: Row(mainAxisAlignment: MainAxisAlignment.end,children: [Icon(Icons.highlight_remove,size: 20,)]),
                        onTap: ()=>Get.back(),
                      ),

                      Padding(
                          padding: const EdgeInsets.fromLTRB(0,Dimensions.PADDING_SIZE_EXTRA_SMALL,0,Dimensions.PADDING_SIZE_SMALL),
                          child: Text('how_to_use'.tr,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge,color:Get.isDarkMode?Colors.white70 : Theme.of(context).primaryColor),)),

                      Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                        Padding(padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_SMALL,top: 3),
                          child: Icon(Icons.circle,size: 7,),
                        ),
                        Expanded(child: Text('convert_point_hint_text'.tr)),
                      ]),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

                      Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                        Padding(padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_SMALL,top: 3),
                          child: Icon(Icons.circle,size: 7,),
                        ),
                        Expanded(child: Text('${'minimum'.tr} $minimumConvertAblePoint ${'points_required_to_convert_point'.tr}'.tr)),
                      ]),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                    ],),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}


