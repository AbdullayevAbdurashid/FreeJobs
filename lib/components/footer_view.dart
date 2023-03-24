import 'package:demandium/feature/web_landing/controller/web_landing_controller.dart';
import 'package:demandium/feature/web_landing/model/web_landing_model.dart';
import 'package:demandium/feature/web_landing/repository/web_landing_repo.dart';
import 'package:get/get.dart';
import 'package:demandium/components/text_hover.dart';
import 'package:demandium/core/core_export.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FooterView extends StatefulWidget {
  @override
  State<FooterView> createState() => _FooterViewState();
}

class _FooterViewState extends State<FooterView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WebLandingController( WebLandingRepo( apiClient: Get.find())));
    ConfigModel? _config = Get.find<SplashController>().configModel;


    Color _color = Theme.of(context).primaryColorLight;
    return Container(
      color: Theme.of(context).primaryColorDark,
      width: double.maxFinite,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: Dimensions.PADDING_SIZE_LARGE * 2),
                          Image.asset(Images.webAppbarLogoDark,width: 180,),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          Row(
                            children: [
                              Image.asset(Images.footerAddress,width: 18,),
                              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                              Text(
                                Get.find<SplashController>().configModel.content!.businessAddress??"",
                                style: ubuntuRegular.copyWith(color: _color,fontSize: Dimensions.fontSizeExtraSmall,),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          GetBuilder<WebLandingController>(
                              initState: (_){
                                Get.find<WebLandingController>().getWebLandingContent();
                              },
                              builder: (weblandingController){
                                if(weblandingController.socialMedia != null &&  weblandingController.socialMedia!.length > 0){
                                  List<SocialMedia>? _socialMediaList = Get.find<WebLandingController>().socialMedia;
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('follow_us_on'.tr, style: ubuntuRegular.copyWith(color: _color,fontSize: Dimensions.fontSizeExtraSmall)),
                                      Container(height: 50,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,

                                          itemBuilder: (BuildContext context, index){
                                            String? icon = Images.facebookIcon;
                                            if(_socialMediaList![index].media=='facebook'){
                                              icon = Images.facebookIcon;
                                            }else if(_socialMediaList[index].media=='linkedin'){
                                              icon = Images.linkedinIcon;
                                            } else if(_socialMediaList[index].media=='youtube'){
                                              icon = Images.youtubeIcon;
                                            }else if(_socialMediaList[index].media=='twitter'){
                                              icon = Images.twitterIcon;
                                            }else if(_socialMediaList[index].media=='instagram'){
                                              icon = Images.instagramIcon;
                                            }else if(_socialMediaList[index].media=='pinterest'){
                                              icon = Images.pinterestIcon;
                                            }

                                            return 1 > 0 ?
                                            InkWell(
                                              onTap: (){
                                                _launchURL('${_socialMediaList[index].link}');
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(right: 15.0),
                                                child: Container(
                                                  padding: EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white
                                                  ),
                                                  child: Center(
                                                    child: Image.asset(
                                                      icon!,
                                                      height: 15,
                                                      width: 15,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ):SizedBox();

                                          },
                                          itemCount: _socialMediaList != null ? _socialMediaList.length: 0,),
                                      ),
                                      SizedBox(height: 20,)
                                    ],
                                  );
                                }else{
                                  return SizedBox();
                                }
                              })

                        ],
                      )),
                  SizedBox(width: Dimensions.PADDING_SIZE_LARGE,),
                  if( _config.content!.appUrlAndroid != null || _config.content!.appUrlIos != null)
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: Dimensions.PADDING_SIZE_LARGE * 2),
                          Text( 'download_our_app'.tr, style: ubuntuRegular.copyWith(color: _color,fontSize: Dimensions.fontSizeLarge)),
                          const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          Text( 'download_our_app_from_google_play_store'.tr, style: ubuntuRegular.copyWith(color: _color,fontSize: Dimensions.fontSizeExtraSmall)),
                          const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                          Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if(_config.content!.appUrlAndroid != null )
                                InkWell(onTap:(){
                                  _launchURL(Get.find<SplashController>().configModel.content!.appUrlAndroid!);
                                },child: Image.asset(Images.playStoreIcon,height: 40,fit: BoxFit.contain)),
                              SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                              if(_config.content!.appUrlIos != null )
                                InkWell(onTap:(){
                                  _launchURL(Get.find<SplashController>().configModel.content!.appUrlIos!);
                                },child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Image.asset(Images.appStoreIcon,height: 40,fit: BoxFit.contain),
                                )),
                            ],)
                        ],
                      ),
                    ),
                  Expanded(flex: 2,child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimensions.PADDING_SIZE_LARGE * 2),
                      Text('useful_link'.tr, style: ubuntuRegular.copyWith(color: _color,fontSize: Dimensions.fontSizeLarge)),
                      SizedBox(height: 5.0,),
                      Container(
                        height: 1,
                        width: 60,
                        color: Theme.of(context).colorScheme.primary,),
                      const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      FooterButton(title: 'privacy_policy'.tr, route: RouteHelper.getHtmlRoute('privacy-policy')),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      FooterButton(title: 'terms_and_conditions'.tr, route: RouteHelper.getHtmlRoute('terms-and-condition')),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      FooterButton(title: 'about_us'.tr, route: RouteHelper.getHtmlRoute('about_us')),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      FooterButton(title: 'contact_us'.tr, route: RouteHelper.getSupportRoute()),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    ],),
                  ),
                  Expanded(flex: 2,child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimensions.PADDING_SIZE_LARGE * 2),
                      Text('quick_links'.tr, style: ubuntuRegular.copyWith(color: Colors.white,fontSize: Dimensions.fontSizeLarge)),
                      SizedBox(height: 5.0,),
                      Container(
                        height: 1,
                        width: 60,
                        color: Theme.of(context).colorScheme.primary,),
                      const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      FooterButton(title: 'current_offers'.tr, route: RouteHelper.getOffersRoute('')),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      FooterButton(title: 'popular_services'.tr, route: RouteHelper.allServiceScreenRoute("fromPopularServiceView")),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      FooterButton(title: 'categories'.tr, route: RouteHelper.getCategoryRoute('fromPage', '123')),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      FooterButton(title: 'become_a_provider'.tr,
                          url: true,
                          route: '${AppConstants.BASE_URL}/provider/auth/sign-up'),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    ],)),
                ],
              ),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                    width: double.maxFinite,
                    color:Color(0xff253036),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Center(child: Text(
                        Get.find<SplashController>().configModel.content!.footerText??"",
                        style: ubuntuRegular.copyWith(color: Colors.white,fontSize: Dimensions.fontSizeSmall),
                      )),
                    )
                ),
                Positioned(
                  top: -32,
                  left: Get.find<LocalizationController>().isLtr?(MediaQuery.of(context).size.width-Dimensions.WEB_MAX_WIDTH)/2:0,
                  right: !Get.find<LocalizationController>().isLtr?0:(MediaQuery.of(context).size.width-Dimensions.WEB_MAX_WIDTH)/2,
                  child: Center(
                    child: Container(
                      width: Dimensions.WEB_MAX_WIDTH,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal:Dimensions.PADDING_SIZE_DEFAULT,
                              vertical: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            child: Row(
                              children: [
                                ContactUsWidget(
                                  title: "email_us".tr,
                                  subtitle: Get.find<SplashController>().configModel.content!.businessEmail??"",
                                ),
                                SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                                ContactUsWidget(
                                  title: "call_us".tr,
                                  subtitle: Get.find<SplashController>().configModel.content!.businessPhone??"",
                                ),
                                SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                              ],
                            ),
                          ),
                          Expanded(child: SizedBox())
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
_launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

class ContactUsWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const ContactUsWidget({Key? key, required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: ubuntuMedium.copyWith(
            fontSize: Dimensions.fontSizeSmall,
            color: light.cardColor.withOpacity(0.8),
          ),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
        Text(
          subtitle,
          style: ubuntuRegular.copyWith(
            fontSize: Dimensions.fontSizeExtraSmall,
            color: light.cardColor.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}


class FooterButton extends StatelessWidget {
  final String title;
  final String route;
  final bool url;
  const FooterButton({required this.title, required this.route, this.url = false});

  @override
  Widget build(BuildContext context) {
    return TextHover(builder: (hovered) {
      return InkWell(
        hoverColor: Colors.transparent,
        onTap: route.isNotEmpty ? () async {
          if(url) {
            if(await canLaunchUrlString(route)) {
              launchUrlString(route, mode: LaunchMode.externalApplication);
            }
          }else {
            Get.toNamed(route);
          }
        } : null,
        child: Text(title, style: hovered ? ubuntuMedium.copyWith(
            color: Theme.of(context).errorColor,
            fontSize: Dimensions.fontSizeSmall)
            : ubuntuRegular.copyWith(
            color: Colors.white,
            fontSize: Dimensions.fontSizeExtraSmall)),
      );
    });
  }
}