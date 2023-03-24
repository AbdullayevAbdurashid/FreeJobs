import 'package:get/get.dart';
import 'package:demandium/core/common_model/provider_model.dart';
import 'package:demandium/core/core_export.dart';

class ProviderInfo extends StatelessWidget {
  final ProviderModel provider;
  const ProviderInfo({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: Text("provider_info".tr, style: ubuntuMedium.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color:Get.isDarkMode? Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6): Theme.of(context).primaryColor))),
        Gaps.verticalGapOf(Dimensions.PADDING_SIZE_DEFAULT),


        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
          child: Container(
            width:double.infinity,
            child: Column(
              children: [
                Gaps.verticalGapOf(Dimensions.PADDING_SIZE_DEFAULT),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE)),
                  child: Container(
                    width: Dimensions.IMAGE_SIZE,
                    height: Dimensions.IMAGE_SIZE,
                    child:  CustomImage(image:"${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${provider.logo}"),

                  ),
                ),
                Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Text("${provider.companyName}",style:ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Text("${provider.companyPhone}",style:ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                Gaps.verticalGapOf(Dimensions.PADDING_SIZE_DEFAULT),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
              color: Theme.of(context).hoverColor,
            ),
          ),
        )

      ],
    );
  }
}
