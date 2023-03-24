import 'package:demandium/components/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:demandium/core/core_export.dart';

class ContactUsPage extends StatelessWidget {

  ContactUsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar: CustomAppBar(title: 'contact_us'.tr,),
      body: Center(
        child: FooterBaseView(
          child: WebShadowWrap(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(Images.helpAndSupport,width: 172,height: 129,)),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),

                  (ResponsiveHelper.isDesktop(context))?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      contactWithEmailOrPhone(
                        'contact_us_through_email'.tr,
                        "${'you_can_send_us_email_through'.tr}",
                        "typically_the_support_team_send_you_any_feedback".tr,
                        context,
                        '${Get.find<SplashController>().configModel.content!.businessEmail.toString()}',
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                      contactWithEmailOrPhone(
                        'contact_us_through_phone'.tr,
                        'contact_us_through_our_customer_care_number'.tr,
                        "talk_with_our_customer".tr,
                        context,
                        "${Get.find<SplashController>().configModel.content!.businessPhone.toString()}",
                      ),
                    ],
                  ):Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      contactWithEmailOrPhone(
                        'contact_us_through_email'.tr,
                        "${'you_can_send_us_email_through'.tr}",
                        "typically_the_support_team_send_you_any_feedback".tr,
                        context,
                        '${Get.find<SplashController>().configModel.content!.businessEmail.toString()}',
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                      contactWithEmailOrPhone(
                        'contact_us_through_phone'.tr,
                        'contact_us_through_our_customer_care_number'.tr,
                        "talk_with_our_customer".tr,
                        context,
                        "${Get.find<SplashController>().configModel.content!.businessPhone.toString()}",
                      )
                    ],
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                  //email and call section
                  ResponsiveHelper.isDesktop(context)
                      ? Column(

                    children: [
                      _emailCallButton(
                          context,
                          'email'.tr,
                          Icons.email,
                          email
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                      _emailCallButton(
                          context,
                          'call'.tr,
                          Icons.call,
                          launchUri,
                          isCall: true,
                      ),
                    ],
                  ): Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _emailCallButton(
                        context,
                        'email'.tr,
                        Icons.email,
                        email
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width/20,),
                      _emailCallButton(
                        context,
                        'call'.tr,
                        Icons.call,
                        launchUri,
                        isCall:true,
                      ),
                    ],
                  ),
                  Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  Gaps.verticalGapOf(Dimensions.PADDING_SIZE_SMALL),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget contactWithEmailOrPhone(String title,String subTitle,String message,context,String emailOrPhone){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subTitle,style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6)),),
              SizedBox(height: Dimensions.PADDING_SIZE_MINI,),
              Text(emailOrPhone,style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!),),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
              Text(message,style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6)),),
            ],
          ),
        ),
      ],
    );
  }

  _emailCallButton(context,String title,IconData iconData,Uri uri, {bool isCall = false}){
    return  CustomButton(
        width: ResponsiveHelper.isDesktop(context)?270:ResponsiveHelper.isTab(context)?150 :120,
        radius: Dimensions.RADIUS_EXTRA_LARGE,
        buttonText: title,
        icon: iconData,
        onPressed: () async{
          await launchUrl(uri,mode: LaunchMode.externalApplication);
          },
    );
  }

  //dummy data willl be removed soon
  final Uri launchUri =  Uri(
    scheme: 'tel',
    path: Get.find<SplashController>().configModel.content!.businessPhone.toString(),
  );
  final Uri email =  Uri(
    scheme: 'mailto',
    path: Get.find<SplashController>().configModel.content!.businessEmail,
  );
}