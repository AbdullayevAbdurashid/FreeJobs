import 'package:demandium/components/text_hover.dart';
import 'package:demandium/core/helper/responsive_helper.dart';
import 'package:demandium/feature/auth/controller/auth_controller.dart';
import 'package:demandium/feature/auth/model/social_log_in_body.dart';
import 'package:demandium/feature/splash/controller/splash_controller.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/images.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

class SocialLoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Column(children: [

      Center(child: Text('or'.tr, style: ubuntuRegular.copyWith(
          color:  Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
          fontSize: Dimensions.fontSizeSmall))),
      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

      Center(child: Text('sign_in_with'.tr, style: ubuntuRegular.copyWith(
          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
          fontSize: Dimensions.fontSizeSmall))),
      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [

        if(Get.find<SplashController>().configModel.content!.googleSocialLogin.toString() == '1')
          InkWell(
            onTap: () async {
              await Get.find<AuthController>().socialLogin();
              String id = '', token = '', email = '', medium ='';
              if(Get.find<AuthController>().googleAccount != null){
                print(Get.find<AuthController>().googleAccount!);
                id = Get.find<AuthController>().googleAccount!.id;
                email = Get.find<AuthController>().googleAccount!.email;
                token = Get.find<AuthController>().auth!.idToken!;
                medium = 'google';
              }
              Get.find<AuthController>().loginWithSocialMedia(SocialLogInBody(
                email: email, token: token, uniqueId: id, medium: medium,
              ));
            },
            child: TextHover(
              builder: (hovered){
                return  Container(
                  height: ResponsiveHelper.isDesktop(context)?50 :ResponsiveHelper.isTab(context)? 40:40,
                  width: ResponsiveHelper.isDesktop(context)? 130 :ResponsiveHelper.isTab(context)? 110: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: hovered?Theme.of(context).primaryColor.withOpacity(0.1) :Theme.of(context).shadowColor,
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_LARGE)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Images.google,
                        height: ResponsiveHelper.isDesktop(context)?30 :ResponsiveHelper.isTab(context)? 25:20,
                        width: ResponsiveHelper.isDesktop(context)? 30 :ResponsiveHelper.isTab(context)? 25: 20,
                      ),
                      !ResponsiveHelper.isMobile(context)?
                      Row(
                        children: [
                          SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                          Text('google'.tr,style: ubuntuRegular.copyWith(),)
                        ],
                      ):SizedBox.shrink()
                    ],
                  ),
                );
              },
            ),
          ),

        if(Get.find<SplashController>().configModel.content!.googleSocialLogin.toString() == '1' && Get.find<SplashController>().configModel.content!.facebookSocialLogin.toString() == '1')
          SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),


        if(Get.find<SplashController>().configModel.content!.facebookSocialLogin.toString() == '1')
          InkWell(
          onTap: () async{
            LoginResult _result = await FacebookAuth.instance.login();
            if (_result.status == LoginStatus.success) {
              Map _userData = await FacebookAuth.instance.getUserData();
              Get.find<AuthController>().loginWithSocialMedia(SocialLogInBody(
                email: _userData['email'], token: _result.accessToken!.token, uniqueId: _result.accessToken!.userId, medium: 'facebook',
              ));
            }
          },
          child: TextHover(
            builder: (hovered){
              return Container(
                height: ResponsiveHelper.isDesktop(context)?50 :ResponsiveHelper.isTab(context)? 40:40,
                width: ResponsiveHelper.isDesktop(context)? 130 :ResponsiveHelper.isTab(context)? 110: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: hovered?Theme.of(context).primaryColor.withOpacity(0.1) :Theme.of(context).shadowColor,
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_LARGE)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.facebook,
                      height: ResponsiveHelper.isDesktop(context)?30 :ResponsiveHelper.isTab(context)? 25:20,
                      width: ResponsiveHelper.isDesktop(context)? 30 :ResponsiveHelper.isTab(context)? 25: 20,
                    ),

                    !ResponsiveHelper.isMobile(context)?
                    Row(
                      children: [
                        SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                        Text('facebook'.tr,style: ubuntuRegular.copyWith(),)
                      ],
                    ):SizedBox.shrink()
                  ],
                ),
              );
            },
          ),
        ),
      ]),
    ]);
  }
}
