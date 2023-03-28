import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/provider/controller/provider_booking_controller.dart';
import 'package:demandium/feature/provider/model/provider_details_model.dart';
import 'package:get/get.dart';
class ProviderDetailsTopCard extends StatelessWidget {
  final bool? isAppbar;
  final String subcategories;
  final String providerId;
  const ProviderDetailsTopCard({Key? key, this.isAppbar=true, required this.subcategories, required this.providerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProviderBookingController>(
        builder: (providerController){
          Provider providerDetails = providerController.providerDetailsContent!.provider!;
      return Column(children: [
        Container(decoration: BoxDecoration(color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
          border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3)),
        ),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_DEFAULT),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
            ClipRRect(borderRadius: BorderRadius.circular(Dimensions.RADIUS_EXTRA_MORE_LARGE),
                child: CustomImage(height: 50, width: 50, fit: BoxFit.cover,
                    image: "${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${providerDetails.logo}")),

            SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
            Expanded(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
                Text(providerDetails.companyName??'', style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                    maxLines: 1, overflow: TextOverflow.ellipsis),

                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Text(subcategories,
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).secondaryHeaderColor),
                  maxLines: 2,overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_EIGHT),
                Row(
                  children: [
                    Container(
                      height: 20,
                      child: Row(
                        children: [
                          RatingBar(rating: providerDetails.avgRating),
                          Gaps.horizontalGapOf(5),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              providerDetails.avgRating!.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,height: 10,
                      margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                    ),
                    InkWell(
                      onTap: ()=>Get.toNamed(RouteHelper.getProviderReviewScreen(subcategories,providerId)),
                      child: Text('${providerDetails.ratingCount} ${'reviews'.tr}', style: ubuntuBold.copyWith(
                        fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).secondaryHeaderColor,
                        decoration: TextDecoration.underline,
                      )),
                    ),

                  ],
                ),
              ],),
            )
          ],),
        ),
        if(isAppbar==true)
          Expanded(child: SizedBox()),
      ],
      );
    });
  }
}
