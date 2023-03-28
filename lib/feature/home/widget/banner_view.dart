import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/home/model/banner_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(
      builder: (bannerController) {
        return (bannerController.banners != null && bannerController.banners!.length == 0) ?
        SizedBox() :
        Container(width: MediaQuery.of(context).size.width,
          height: ResponsiveHelper.isTab(context) || MediaQuery.of(context).size.width > 450 ? 350 :MediaQuery.of(context).size.width * 0.40,
          padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
          child: bannerController.banners != null ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: false,
                    viewportFraction: .92,
                    disableCenter: true,
                    autoPlayInterval: Duration(seconds: 7),
                    onPageChanged: (index, reason) {
                      bannerController.setCurrentIndex(index, true);
                    },
                  ),
                  itemCount: bannerController.banners!.length == 0 ? 1 : bannerController.banners!.length,
                  itemBuilder: (context, index, _) {
                    String? _baseUrl = Get.find<SplashController>().configModel.content!.imageBaseUrl;
                    BannerModel bannerModel = bannerController.banners![index];
                    return InkWell(
                      onTap: () {
                        String link = bannerModel.redirectLink != null ? bannerModel.redirectLink! : '';
                        String id = bannerModel.category != null ? bannerModel.category!.id! : '';
                        String name = bannerModel.category != null ? bannerModel.category!.name! : "";
                        bannerController.navigateFromBanner(bannerModel.resourceType!, id, link, bannerModel.resourceId != null ? bannerModel.resourceId! : '', categoryName: name);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                            boxShadow: shadow,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                            child: GetBuilder<SplashController>(
                              builder: (splashController) {
                                return CustomImage(
                                  image: '$_baseUrl/banner/${bannerController.banners![index].bannerImage}',
                                  fit: BoxFit.cover,
                                  placeholder: Images.placeholder,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Align(
                alignment: Alignment.center,
                child: AnimatedSmoothIndicator(
                  activeIndex: bannerController.currentIndex!,
                  count: bannerController.banners!.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: Theme.of(context).colorScheme.primary,
                    dotColor: Theme.of(context).disabledColor,
                  ),
                ),
              ),
            ],
          ) : Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: Shimmer(
              duration: Duration(seconds: 2),
              enabled: true, color: Colors.grey,
              child: Container(
                decoration: BoxDecoration(
                  color: Get.isDarkMode? Colors.grey[700]:Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  boxShadow: Get.isDarkMode?null:[BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
                ),
              )
            ),
          )
        );
      },
    );
  }
}
