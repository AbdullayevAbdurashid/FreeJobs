import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/core/onboard_data.dart';
import 'package:demandium/feature/onboarding/controller/on_board_pager_controller.dart';

class OnBoardPopulated extends GetView<OnBoardController> {
  const OnBoardPopulated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  controller.onPageChanged(value);
                },
                itemCount: onBoardPagerData.length,
                itemBuilder: (context, index) => PagerContent(
                  image: onBoardPagerData[index]["image"]!,
                  text: onBoardPagerData[index]["text"]!,
                  subText: onBoardPagerData[index]["subTitle"]!,
                ),
              ),
            ),
            Container(
              height: 100,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  children: [
                    Gaps.verticalGapOf(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          onBoardPagerData.length,
                          (index) => GetBuilder<OnBoardController>(
                                  builder: (onBoardController) {
                                return PagerDot(index: index, currentIndex: onBoardController.pageIndex);
                              })),
                    ),

                    const Spacer(),
                  ],
                ),
              ),
            ),
            GetBuilder<OnBoardController>(
              builder: (onBoardController) {
                if(onBoardController.pageIndex != 0)
                return Align(alignment: Alignment.bottomRight, child: ElevatedButton(
                  onPressed: () {
                    Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
                  },
                  child: Text("next".tr,style: ubuntuRegular.copyWith(color: Theme.of(context).primaryColorLight)),
                ));
                return Align(alignment: Alignment.bottomRight, child: InkWell(
                  onTap: () {
                    Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
                    },
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "skip".tr,
                        style: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeExtraLarge,
                          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6),
                        ),
                      ),
                    ),
                  ),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
