import 'package:demandium/feature/home/model/banner_model.dart';
import 'package:demandium/feature/home/web/web_banner_shimmer.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class WebBannerView extends GetView<BannerController> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    bool isLtr = Get.find<LocalizationController>().isLtr;
    String? _baseUrl =  Get.find<SplashController>().configModel.content!.imageBaseUrl;
    return GetBuilder<BannerController>(
      initState: (state){
        Get.find<BannerController>().getBannerList(false);
      },
      builder: (bannerController){
        if(bannerController.banners != null && bannerController.banners!.length == 0){
          return SizedBox();
        }else{
          return Container(
            alignment: Alignment.center,
            child: SizedBox(
                width: Dimensions.WEB_MAX_WIDTH,
                height: 220,
                child: bannerController.banners != null ?
                    bannerController.banners!.length == 1 ?
                    InkWell(
                      onTap: () {
                        BannerModel bannerModel = bannerController.banners![0];
                        String link = bannerModel.redirectLink != null ? bannerModel.redirectLink! : '';
                        String id = bannerModel.category != null ? bannerModel.category!.id! : '';
                        String name = bannerModel.category != null ? bannerModel.category!.name! : "";
                        bannerController.navigateFromBanner(
                            bannerModel.resourceType!,
                            id,
                            link,
                            bannerModel.resourceId != null ? bannerModel.resourceId! : '',
                            categoryName: name
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                        child: CustomImage(
                          image: '$_baseUrl/banner/${bannerController.banners![0].bannerImage}',
                          fit: BoxFit.fill,
                           height: 220,
                        ),
                      ),
                    ) :

                Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    PageView.builder(
                      onPageChanged: (int index) => bannerController.setCurrentIndex(index, true),
                      controller: _pageController,
                      itemCount: (bannerController.banners!.length/2).ceil(),
                      itemBuilder: (context, index) {
                        String? _baseUrl =  Get.find<SplashController>().configModel.content!.imageBaseUrl;
                        int index1 = index * 2;
                        int index2 = (index * 2) + 1;
                        bool _hasSecond = index2 < bannerController.banners!.length;
                        return Row(
                            children: [
                              Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      BannerModel bannerModel = bannerController.banners![index1];
                                      String link = bannerModel.redirectLink != null ? bannerModel.redirectLink! : '';
                                      String id = bannerModel.category != null ? bannerModel.category!.id! : '';
                                      String name = bannerModel.category != null ? bannerModel.category!.name! : "";

                                      bannerController.navigateFromBanner(
                                          bannerModel.resourceType!,
                                          id,
                                          link,
                                          bannerModel.resourceId != null ? bannerModel.resourceId! : '',
                                          categoryName: name);},
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                                      child: CustomImage(
                                        image: '$_baseUrl/banner/${bannerController.banners![index1].bannerImage}',
                                        fit: BoxFit.cover,
                                        height: 220,
                          ),
                        ),
                      ),),
                              SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
                              Expanded(child: _hasSecond ?
                              InkWell(
                                onTap: () {
                                  BannerModel bannerModel = bannerController.banners![index2];
                                  String link = bannerModel.redirectLink != null ? bannerModel.redirectLink! : '';
                                  String id = bannerModel.category != null ? bannerModel.category!.id! : '';
                                  String name = bannerModel.category != null ? bannerModel.category!.name! : "";
                                  bannerController.navigateFromBanner(
                                      bannerModel.resourceType!,
                                      id,
                                      link,
                                      bannerModel.resourceId != null ? bannerModel.resourceId! : '',
                                      categoryName: name);},
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                                  child: CustomImage(
                                    image: '$_baseUrl/banner/${bannerController.banners![index2].bannerImage}',
                                    fit: BoxFit.cover,
                                    height: 220,
                          ),
                        ),):
                              (!_hasSecond && bannerController.banners!.length>2)?
                              InkWell(
                                onTap: () {
                                  BannerModel bannerModel = bannerController.banners![0];
                                  String link = bannerModel.redirectLink != null ? bannerModel.redirectLink! : '';
                                  String id = bannerModel.category != null ? bannerModel.category!.id! : '';
                                  String name = bannerModel.category != null ? bannerModel.category!.name! : "";
                                  bannerController.navigateFromBanner(
                                      bannerModel.resourceType!,
                                      id,
                                      link,
                                      bannerModel.resourceId != null ? bannerModel.resourceId! : '',
                                      categoryName: name);},
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                                  child: CustomImage(
                                    image: '$_baseUrl/banner/${bannerController.banners![0].bannerImage}',
                                    fit: BoxFit.cover,
                                    height: 220,),),):
                              SizedBox()),
                    ]);},),
                    bannerController.currentIndex != 0 ?
                    Positioned(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      child: InkWell(
                        onTap: () => _pageController.previousPage(duration: Duration(seconds: 1), curve: Curves.easeInOut),
                        child: Container(
                          height: 40, width: 40, alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white70.withOpacity(0.6),
                              boxShadow:cardShadow,
                          ),
                          child: Center(
                            child: Padding(
                              padding:  EdgeInsets.only(
                                  left: isLtr ?  Dimensions.PADDING_SIZE_SMALL : 0.0,
                                  right: !isLtr ?  Dimensions.PADDING_SIZE_SMALL : 0.0,
                              ),
                              child: Icon(
                                  Icons.arrow_back_ios,
                                  color: dark.cardColor
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ) :
                    SizedBox(),
                    bannerController.currentIndex != ((bannerController.banners!.length/2).ceil()-1) ?
                    Positioned(child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      child: InkWell(
                        onTap: () => _pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.easeInOut),
                        child: Container(
                          height: 40, width: 40, alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white70.withOpacity(0.6),
                              boxShadow: cardShadow
                          ),
                          child: Icon(
                              Icons.arrow_forward_ios,
                              size: Dimensions.WEB_ARROW_SIZE,
                              color: dark.cardColor
                          ),
                        ),
                      ),
                    ),
                  ),):
                    SizedBox(),
              ]): WebBannerShimmer()),
          );
        }
      },
    );
  }
}



