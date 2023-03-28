import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/suggest_new_service/controller/suggest_service_controller.dart';
import 'package:demandium/feature/suggest_new_service/widgets/suggest_service_item_view.dart';
import 'package:get/get.dart';

class SuggestedServiceListScreen extends StatelessWidget {
  const SuggestedServiceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar: CustomAppBar(title: 'service_request_list'.tr),
      body: GetBuilder<SuggestServiceController>(
        initState: (_)=>Get.find<SuggestServiceController>().getSuggestedServiceList(1,reload: true),
        builder: (suggestServiceController){
          return FooterBaseView(
            child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child:suggestServiceController.suggestedServiceModel!=null?
              Padding(padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,children: [
                  if(suggestServiceController.suggestedServiceList.length>0)
                  Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Row(
                      children: [
                        Text('${'request'.tr} ',style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge),),

                        Directionality(textDirection: TextDirection.ltr,
                          child: Text('(${suggestServiceController.suggestedServiceList.length})',style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge),)),
                      ],
                    ),
                  ),
                  suggestServiceController.suggestedServiceList.length>0?
                  ListView.builder(
                    itemCount: suggestServiceController.suggestedServiceList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return SuggestServiceItemView(suggestedService:suggestServiceController.suggestedServiceList[index]);
                    },):SizedBox(height: Get.height*0.8, child: Center(child: Text(
                      'no_service_request_yet'.tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                    ),),
                  ),
                ]),
              ):Center(
                child: SizedBox(
                    height: ResponsiveHelper.isDesktop(context)?100: Get.height*0.85,
                    child: Center(child: CircularProgressIndicator())),
              ),
            ),
          );
      }),
    );
  }
}
