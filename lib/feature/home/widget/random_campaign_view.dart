import 'dart:math';
import 'package:demandium/core/helper/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demandium/components/custom_image.dart';
import 'package:demandium/controller/theme_controller.dart';
import 'package:demandium/core/helper/help_me.dart';
import 'package:demandium/feature/home/controller/campaign_controller.dart';
import 'package:demandium/feature/splash/controller/splash_controller.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/images.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class RandomCampaignView extends StatelessWidget {
   RandomCampaignView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CampaignController>(
        builder: (campaignController) {
          int randomIndex = 1;
          if(campaignController.campaignList != null && campaignController.campaignList!.length == 0){
            return SizedBox();
          }else{
            String? _baseUrl =  Get.find<SplashController>().configModel.content!.imageBaseUrl;
            if(campaignController.campaignList != null) {
              var rng = new Random();
              randomIndex =  rng.nextInt(campaignController.campaignList!.length> 0 ? campaignController.campaignList!.length :1 );
              return InkWell(
                onTap: (){
                  if(isRedundentClick(DateTime.now())){
                    return;
                  }
                  campaignController.navigateFromCampaign(
                      campaignController.campaignList![randomIndex].id!,
                      campaignController.campaignList![randomIndex].discount!.discountType!);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_RADIUS),),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_RADIUS),
                          child: CustomImage(
                            height: ResponsiveHelper.isTab(context) || MediaQuery.of(context).size.width > 450 ? 350 :MediaQuery.of(context).size.width * 0.40,
                            width: Get.width, fit: BoxFit.cover, placeholder: Images.placeholder,
                            image:'$_baseUrl/campaign/${campaignController.campaignList![randomIndex].coverImage}',),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            else{
              return Container(
                width: MediaQuery.of(context).size.width,
                height: ResponsiveHelper.isTab(context) ? 300 : GetPlatform.isDesktop ? 500 : MediaQuery.of(context).size.width * 0.35,
                padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: Shimmer(
                  duration: Duration(seconds: 2),
                  enabled: campaignController.campaignList == null,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],)
                  ),),
              );
            }
          }
        });
  }
}
