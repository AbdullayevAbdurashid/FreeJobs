import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/home/web/web_banner_shimmer.dart';
import 'package:get/get.dart';

class WebCampaignView extends GetView<BannerController> {
  @override
  Widget build(BuildContext context) {
    bool isLtr = Get.find<LocalizationController>().isLtr;

    final PageController _pageController = PageController();
    return GetBuilder<CampaignController>(
      initState: (state){
        Get.find<CampaignController>().getCampaignList(false);
      },
      builder: (campaignController){
        if(campaignController.campaignList != null && campaignController.campaignList!.length == 0){
          return SizedBox();
        }else{
          return Container(
            alignment: Alignment.center,
            child: SizedBox(
                width: Dimensions.WEB_MAX_WIDTH,
                height: 250,
                child: campaignController.campaignList != null ?

            campaignController.campaignList!.length == 1 ?

            InkWell(
              onTap: () {
                if(isRedundentClick(DateTime.now())){
                  return;
                }
                campaignController.navigateFromCampaign(campaignController.campaignList![0].id!,campaignController.campaignList![0].discount!.discountType!);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                child: CustomImage(
                  image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}/campaign/${campaignController.campaignList![0].coverImage}',
                  fit: BoxFit.fill,
                  height: 220,
                ),
              ),
            ):

            Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [

                PageView.builder(
                  controller: _pageController,
                  itemCount: (campaignController.campaignList!.length/2).ceil(),
                  itemBuilder: (context, index) {
                    String? _baseUrl =  Get.find<SplashController>().configModel.content!.imageBaseUrl;
                    int index1 = index * 2;
                    int index2 = (index * 2) + 1;
                    bool _hasSecond = index2 < campaignController.campaignList!.length;
                    return Row(children: [
                      Expanded(child: InkWell(
                        onTap: () {
                          if(isRedundentClick(DateTime.now())){
                            return;
                          }
                          campaignController.navigateFromCampaign(campaignController.campaignList![index1].id!,campaignController.campaignList![index1].discount!.discountType!);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          child: CustomImage(
                            image: '$_baseUrl/campaign/${campaignController.campaignList![index1].coverImage}', fit: BoxFit.cover, height: 220,
                          ),
                        ),
                      )),

                      SizedBox(width: Dimensions.PADDING_SIZE_LARGE),

                      Expanded(child: _hasSecond ? InkWell(
                        onTap: () {
                          if(isRedundentClick(DateTime.now())){
                            return;
                          }
                          campaignController.navigateFromCampaign(campaignController.campaignList![index2].id!,campaignController.campaignList![index2].discount!.discountType!);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          child: CustomImage(
                            image: '$_baseUrl/campaign/${campaignController.campaignList![index2].coverImage}', fit: BoxFit.cover, height: 220,
                          ),
                        ),
                      ) :(!_hasSecond && campaignController.campaignList!.length> 2 ) ? InkWell(
                        onTap: () {
                          if(isRedundentClick(DateTime.now())){
                            return;
                          }
                          campaignController.navigateFromCampaign(campaignController.campaignList![0].id!,campaignController.campaignList![0].discount!.discountType!);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          child: CustomImage(
                            image: '$_baseUrl/campaign/${campaignController.campaignList![0].coverImage}', fit: BoxFit.cover, height: 220,
                          ),
                        ),
                      ) :SizedBox()),

                    ]);
                  },
                  onPageChanged: (int index) => campaignController.setCurrentIndex(index, true),
                ),

                campaignController.currentIndex != 0 ?
                Positioned(
                  top: 0, bottom: 0, left: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    child: InkWell(
                      onTap: () => _pageController.previousPage(duration: Duration(seconds: 1), curve: Curves.easeInOut),
                      child: Container(
                        height: 40, width: 40, alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white70.withOpacity(0.6),
                            boxShadow:cardShadow,
                        ),
                        child: Padding(
                          padding:  EdgeInsets.only(
                            left: isLtr ?  Dimensions.PADDING_SIZE_SMALL : 0.0,
                            right: !isLtr ?  Dimensions.PADDING_SIZE_SMALL : 0.0,
                          ),
                          child: Icon(
                              Icons.arrow_back_ios,
                              size: Dimensions.WEB_ARROW_SIZE,
                              color: dark.cardColor
                          ),
                        ),
                      ),
                    ),
                  ),
                ) :
                SizedBox(width: 0.0,),

                campaignController.currentIndex != ((campaignController.campaignList!.length/2).ceil()-1) ?
                Positioned(
                  top: 0, bottom: 0, right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    child: InkWell(
                      onTap: () => _pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.easeInOut),
                      child: Container(
                        height: 40, width: 40, alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white70.withOpacity(0.6),
                            boxShadow:cardShadow,
                        ),
                        child: Icon(
                            Icons.arrow_forward_ios,
                            size: Dimensions.WEB_ARROW_SIZE,
                            color: dark.cardColor
                        ),
                      ),
                    ),
                  ),
                ) :
                SizedBox(width: 0.0,),

              ],
            ) :
            WebBannerShimmer()),
          );
        }

      },
    );
  }
}


class WebCampaignShimmer extends StatelessWidget {
  final bool enabled;
  WebCampaignShimmer({required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.WEB_MAX_WIDTH / 3.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
          Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey[Get.isDarkMode?700:300],
              borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_DEFAULT,)),
            ),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                child: Container(
                  height: 130, width: 200,
                  margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode? Colors.grey[700]:Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    boxShadow: Get.isDarkMode?null:[BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
                  ),
                  child: Shimmer(
                    duration: Duration(seconds: 2),
                    interval: Duration(seconds: 1),
                    enabled: enabled,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start, children: [

                      Container(
                        height: 120, width: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                            color: Colors.grey[Get.isDarkMode?400:300]
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start, children: [
                          Container(height: 15, width: 100, color: Colors.grey[Get.isDarkMode?400:300]),
                          SizedBox(height: 5),
                          RatingBar(rating: 0.0, size: 12, ratingCount: 0),
                          SizedBox(height: 5),
                          Container(height: 10, width: 130, color: Colors.grey[Get.isDarkMode?400:300]),
                          SizedBox(height: 20),
                          Container(height: 10, width: 30, color: Colors.grey[Get.isDarkMode?400:300]),
                        ]),
                      ),
                    ]),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}