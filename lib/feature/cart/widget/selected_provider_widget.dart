import 'package:demandium/core/core_export.dart';
import 'package:get/get.dart';

class SelectedProductWidget extends StatelessWidget {
  const SelectedProductWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController){
      return Container(
        height:  ResponsiveHelper.isDesktop(context)? 50 : 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.5),width: 0.7),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
        child: Center(child: Row(
          children:  [

            ClipRRect( borderRadius: BorderRadius.circular(Dimensions.RADIUS_EXTRA_MORE_LARGE),
              child: CustomImage(
                image: "${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${cartController.selectedProviderProfileImages}",
                height: 25,width: 25,),),
            SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
            Icon(Icons.star,color: Theme.of(context).colorScheme.primary,size: 15,),
            Directionality(textDirection: TextDirection.ltr,
              child: Text( cartController.selectedProviderRating,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
            )

          ],
        )),
      );
    });
  }
}
