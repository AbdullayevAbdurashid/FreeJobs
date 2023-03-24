import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/html/controller/webview_controller.dart';
import 'package:demandium/utils/html_type.dart';

class HtmlViewerScreen extends StatelessWidget {
  final HtmlType? htmlType;
  HtmlViewerScreen({@required this.htmlType});

  @override
  Widget build(BuildContext context) {
    String imageBaseUrl = Get.find<SplashController>().configModel.content!.imageBaseUrl!;

    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar: CustomAppBar(title: htmlType == HtmlType.TERMS_AND_CONDITION ? 'terms_and_conditions'.tr
          : htmlType == HtmlType.ABOUT_US ? 'about_us'.tr :
      htmlType == HtmlType.PRIVACY_POLICY ? 'privacy_policy'.tr :
      htmlType == HtmlType.CANCELLATION_POLICY ? 'cancellation_policy'.tr :
      htmlType == HtmlType.REFUND_POLICY ? 'refund_policy'.tr :
      'no_data_found'.tr),


      body: GetBuilder<HtmlViewController>(
        initState: (state){
          Get.find<HtmlViewController>().getPagesContent();
        },
        builder: (htmlViewController){
          String? _data;
          if(htmlViewController.pagesContent != null){
             _data = htmlType == HtmlType.TERMS_AND_CONDITION ? htmlViewController.pagesContent!.termsAndConditions!.liveValues!
                : htmlType == HtmlType.ABOUT_US ? htmlViewController.pagesContent!.aboutUs!.liveValues!
                : htmlType == HtmlType.PRIVACY_POLICY ? htmlViewController.pagesContent!.privacyPolicy!.liveValues!
                : htmlType == HtmlType.REFUND_POLICY ? htmlViewController.pagesContent!.refundPolicy!.liveValues!
                : htmlType == HtmlType.CANCELLATION_POLICY ? htmlViewController.pagesContent!.cancellationPolicy!.liveValues!
                : null;

               if(_data != null) {
                 _data = _data.replaceAll('href=', 'target="_blank" href=');

               return FooterBaseView(
                 isScrollView:ResponsiveHelper.isMobile(context) ? false: true,
                 isCenter:true,
                 child: WebShadowWrap(
                   child: Container(
                     width: Dimensions.WEB_MAX_WIDTH,
                     height: Get.height,
                     child:SingleChildScrollView(
                       padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL,
                       ),
                       physics: BouncingScrollPhysics(),
                       child: Column(
                         children: [
                          if( ResponsiveHelper.isDesktop(context))
                           Padding(
                             padding:  EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
                             child: Text(
                                 htmlType == HtmlType.TERMS_AND_CONDITION ? 'terms_and_conditions'.tr
                                     : htmlType == HtmlType.ABOUT_US ? 'about_us'.tr :
                                 htmlType == HtmlType.PRIVACY_POLICY ? 'privacy_policy'.tr :
                                 htmlType == HtmlType.CANCELLATION_POLICY ? 'cancellation_policy'.tr :
                                 htmlType == HtmlType.REFUND_POLICY ? 'refund_policy'.tr:'',
                               style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                             ),
                           ),
                           Html(
                             data: _data,
                             style: {
                               "p": Style(
                                 fontSize: FontSize.medium,
                               ),

                             },
                           ),
                         ],
                       ),
                     ),
                   ),
                 ),
               );
             }else{
               return SizedBox();
             }
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        hoverColor:Colors.black26,
        onPressed: (){
          if(isRedundentClick(DateTime.now())){
            return;
          }
          String userId = Get.find<SplashController>().configModel.content!.adminDetails!.id!;
          String phone = Get.find<SplashController>().configModel.content?.businessPhone??"";
          String name = Get.find<SplashController>().configModel.content!.adminDetails!.firstName!+" "+Get.find<SplashController>().configModel.content!.adminDetails!.lastName!;
          String image = "$imageBaseUrl/user/profile_image/${Get.find<SplashController>().configModel.content!.adminDetails!.profileImage!}";
          Get.find<ConversationController>().createChannel(userId, "",name: name,image: image,fromBookingDetailsPage: true,phone: phone);
        },
        child: Center(child: Image.asset(Images.adminChat,scale: 2.8,)),
      ),
    );
  }
}
