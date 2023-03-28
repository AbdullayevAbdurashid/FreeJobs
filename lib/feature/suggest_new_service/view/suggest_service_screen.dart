import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/suggest_new_service/controller/suggest_service_controller.dart';
import 'package:demandium/feature/suggest_new_service/view/suggested_service_list_screen.dart';
import 'package:demandium/feature/suggest_new_service/widgets/suggest_service_input_field.dart';
import 'package:get/get.dart';

class SuggestServiceScreen extends StatefulWidget {
  const SuggestServiceScreen({Key? key}) : super(key: key);

  @override
  State<SuggestServiceScreen> createState() => _SuggestServiceScreenState();
}

class _SuggestServiceScreenState extends State<SuggestServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar: CustomAppBar(title: "service_request".tr, actionWidget: IconButton(
        onPressed: (){
          Get.to(()=> SuggestedServiceListScreen());
        },
        icon: Icon(Icons.notifications_active),
      )),
      body: GetBuilder<SuggestServiceController>(builder: (suggestServiceController){
        return FooterBaseView(
          child: Center(
            child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Padding(padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Container(height: Get.height-100,
                  child: Stack(alignment: Alignment.bottomCenter,
                    children: [
                      if(ResponsiveHelper.isDesktop(context))
                      Padding(padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                        child: Align(
                          alignment: Get.find<LocalizationController>().isLtr? Alignment.topRight: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () => Get.toNamed(RouteHelper.getNewSuggestedServiceList()),
                            child: Container(
                              decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Theme.of(context).colorScheme.primary
                              ),
                              padding: const EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_DEFAULT,vertical:Dimensions.PADDING_SIZE_SMALL-2),
                              child: Text('${'see_request'.tr}', style: ubuntuMedium.copyWith(
                                fontSize: Dimensions.fontSizeDefault, color: Colors.white
                              )),
                            ),
                          ),
                        ),
                      ),
                      Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                          child: Text('tell_us_more_about_your_service'.tr,
                              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.9),
                              )
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_SMALL),
                          child: Text('suggest_more_service_that_you_willing'.tr,
                            style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7),
                            ), textAlign: TextAlign.center,
                          ),
                        ),

                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                            child: Image.asset(Images.suggestServiceIcon,width: suggestServiceController.initialImageSize,),
                          ),
                        ),

                        AnimatedOpacity(opacity: suggestServiceController.initialContainerOpacity,
                          duration: Duration(milliseconds: 1500),
                          child: SuggestServiceInputField(),
                        )
                      ]),

                      AnimatedPositioned(
                        top: suggestServiceController.initialButtonPadding,
                        duration: Duration(milliseconds: 500),
                        child: suggestServiceController.isLoading==false?
                        CustomButton(width: 240, fontSize: Dimensions.fontSizeDefault,
                          buttonText: suggestServiceController.isShowInputField?"send_request".tr:'request_for_service'.tr,
                          onPressed: (){
                            if(!suggestServiceController.isShowInputField){
                              suggestServiceController.updateShowInputField();
                            }else{
                              if(suggestServiceController.selectedCategoryName==""){
                                customSnackBar('select_category'.tr);
                              }else if(suggestServiceController.serviceNameController.text==""){
                                customSnackBar('provide_your_desired_service_name'.tr);
                              }else if(suggestServiceController.serviceDetailsController.text.isEmpty){
                                customSnackBar("provide_some_details_about_your_service".tr);
                              }else{
                                suggestServiceController.submitNewServiceRequest();
                              }
                            }
                          },
                        ): CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
