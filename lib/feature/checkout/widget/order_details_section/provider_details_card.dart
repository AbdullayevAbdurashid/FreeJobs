import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/cart/widget/available_provider_widgets.dart';
import 'package:get/get.dart';

class ProviderDetailsCard extends StatelessWidget {
  const ProviderDetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController){
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Theme.of(context).hoverColor),
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),

            child:  Row(children: [
              ClipRRect( borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                child: CustomImage(
                  image: "${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${cartController.selectedProviderProfileImages}",
                  height: 60,width: 60,),
              ),
              const SizedBox(width: Dimensions.paddingSizeDefault,),

              Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,children: [
                Text(cartController.selectedProviderName, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                  child: Text('Computer repair,Laptop Repair',
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).secondaryHeaderColor),),
                ),
                Text.rich(TextSpan(
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8)),
                    children:  [


                      WidgetSpan(child: Icon(Icons.star,color: Theme.of(context).colorScheme.primaryContainer,size: 15,), alignment: PlaceholderAlignment.middle),
                      const TextSpan(text: " "),
                      TextSpan(text: cartController.selectedProviderRating.toString(),style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault))

                    ])),
              ],)
            ]),
          ),
          Positioned(
            top: 20,
            right: Get.find<LocalizationController>().isLtr?15:null,
            left: Get.find<LocalizationController>().isLtr? null :15,
            child: InkWell(
                onTap: (){
                  showModalBottomSheet(
                      useRootNavigator: true,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context, builder: (context) => const AvailableProviderWidget()
                  );
                }, child: Image.asset(Images.editButton,width: 20.0,height: 20.0,)),
          ),
        ],
      );
    });
  }
}
