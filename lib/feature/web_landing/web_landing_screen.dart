import 'dart:async';
import 'package:demandium/components/custom_image.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/controller/localization_controller.dart';
import 'package:demandium/data/model/response/config_model.dart';
import 'package:demandium/feature/location/widget/registration_card.dart';
import 'package:demandium/feature/splash/controller/splash_controller.dart';
import 'package:demandium/feature/web_landing/controller/web_landing_controller.dart';
import 'package:demandium/feature/web_landing/repository/web_landing_repo.dart';
import 'package:demandium/feature/web_landing/widget/live_chat_button.dart';
import 'package:demandium/feature/web_landing/widget/web_landing_search_box.dart';
import 'package:demandium/feature/web_landing/widget/web_landing_shimmer.dart';
import 'package:demandium/feature/web_landing/widget/web_mid_section.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/images.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'widget/testimonial_widget.dart';

class WebLandingPage extends StatefulWidget {
  final bool? fromSignUp;
  final bool? fromHome;
  final String? route;

  const WebLandingPage({Key? key, required this.fromSignUp, required this.fromHome, required this.route}) : super(key: key);

  @override
  State<WebLandingPage> createState() => _WebLandingPageState();
}

class _WebLandingPageState extends State<WebLandingPage> {
  ConfigModel? _config = Get.find<SplashController>().configModel;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    Get.find<WebLandingController>().getWebLandingContent();
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WebLandingController( WebLandingRepo( apiClient: Get.find())));
    String baseUrl = Get.find<SplashController>().configModel.content!.imageBaseUrl!;

    return GetBuilder<WebLandingController>(
      initState: (state){
        Get.find<WebLandingController>().getWebLandingContent();
      },
      builder: (webLandingController){

        if(webLandingController.webLandingContent != null){
          var textContent = Map.fromIterable(webLandingController.webLandingContent!.textContent!, key: (e) => e.keyName, value: (e) => e.liveValues);
          var imageContent = Map.fromIterable(webLandingController.webLandingContent!.imageContent!, key: (e) => e.keyName, value: (e) => e.liveValues);


          return FooterBaseView(
            bottomPadding: false,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  WebLandingSearchSection(baseUrl: baseUrl,textContent: textContent,fromSignUp:widget.fromSignUp,route: widget.route,),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE),
                  WebMidSection(
                    baseUrl: baseUrl,
                    imageContent: imageContent,
                    textContent: textContent,
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE),
                  TestimonialWidget(
                    webLandingController: webLandingController,
                    textContent: textContent,
                    baseUrl: baseUrl,
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE),
                  _config!.content!.providerSelfRegistration == '1'
                      ? RegistrationCard(isStore: true)
                      : SizedBox(),
                  SizedBox(height: _config!.content!.providerSelfRegistration == '1' ? 40 : 0),
                  Container(
                    height: 570.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: Dimensions.WEB_MAX_WIDTH,
                        child: Row(
                          mainAxisAlignment: _config!.content!.appUrlAndroid == null && _config!.content!.appUrlIos == null
                              ? MainAxisAlignment.center
                              :MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //download section image
                            CustomImage(
                              height: Dimensions.WEB_LANDING_DOWNLOAD_IMAGE_HEIGHT,
                              width:  Dimensions.WEB_LANDING_DOWNLOAD_IMAGE_HEIGHT,
                              image: "$baseUrl/landing-page/web/${imageContent['download_section_image']}",
                              fit: BoxFit.fitHeight,
                            ),
                            //download app section
                            if(imageContent.isNotEmpty &&( _config!.content!.appUrlAndroid != null || _config!.content!.appUrlIos != null)) Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(width: 50,height: 2,color:Get.isDarkMode ?Colors.white:Colors.black),
                                    SizedBox(width: 8.0,),
                                    Text(textContent['download_section_title'], textAlign: TextAlign.center, style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),),
                                  ],
                                ),
                                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                                Text(
                                 textContent['download_section_description'],
                                  textAlign: TextAlign.center,
                                  style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color,
                                      fontSize: Dimensions.fontSizeDefault),
                                ),
                                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                                  Row(
                                  children: [
                                   if( _config!.content!.appUrlAndroid != null)
                                    InkWell(
                                      onTap: () async {
                                        if(await canLaunchUrlString(_config!.content!.appUrlAndroid!)) {launchUrlString(_config!.content!.appUrlAndroid!);
                                        }},
                                      child: Image.asset(Images.playStoreIcon, height: 45),
                                    ) ,

                                    SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                                    if(_config!.content!.appUrlIos != null )
                                      InkWell(
                                      onTap: () async {
                                        if(await canLaunchUrlString(_config!.content!.appUrlIos!))
                                          launchUrlString(_config!.content!.appUrlIos!);
                                        },
                                      child: Image.asset(Images.appStoreIcon, height: 45),)

                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: Dimensions.WEB_LANDING_CONTACT_US_HEIGHT,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode?Colors.grey.withOpacity(0.1):Theme.of(context).primaryColorLight,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: Dimensions.WEB_MAX_WIDTH,
                            child: Align(
                              alignment:Get.find<LocalizationController>().isLtr ? Alignment.centerLeft: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if(textContent['web_bottom_title'] != null && textContent['web_bottom_title'] != '')
                                  Text(textContent['web_bottom_title'],style: ubuntuBold.copyWith(fontSize: 18),),
                                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      LiveChatButton(
                                          title:'chat'.tr,
                                          iconData:Icons.message,
                                          isBorderActive:false,
                                      ),
                                      SizedBox(width:Dimensions.PADDING_SIZE_DEFAULT),
                                      LiveChatButton(
                                          title:Get.find<SplashController>().configModel.content!.businessPhone!,
                                          iconData:Icons.call,
                                          isBorderActive:true,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right:Get.find<LocalizationController>().isLtr ? Get.width/7 : null,
                          left:Get.find<LocalizationController>().isLtr ?null: Get.width / 7,
                          top: - 65.0,
                          child: CustomImage(image: "$baseUrl/landing-page/web/${imageContent['support_section_image']}",
                            fit: BoxFit.cover,
                            width: Dimensions.SUPPORT_LOGO_WIDTH,height:  Dimensions.SUPPORT_LOGO_HEIGHT,),
                        ),
                      ],
                    ),
                  ),
                ],),
            ),
          );
        }else{
          return WebLandingShimmer();
        }
      },
    );
  }
}
class CustomPath extends CustomClipper<Path> {
  final bool? isRtl;
  CustomPath({required this.isRtl});

  @override
  Path getClip(Size size) {
    final path = Path();
    if(isRtl!) {
      path..moveTo(0, size.height)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width*0.7, 0)
        ..lineTo(0, 0)
        ..close();
    }else {
      path..moveTo(0, size.height)
        ..lineTo(size.width*0.3, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, size.height)
        ..close();
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}


