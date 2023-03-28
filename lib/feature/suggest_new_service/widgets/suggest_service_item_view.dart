import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/suggest_new_service/model/suggest_service_model.dart';
import 'package:get/get.dart';

class SuggestServiceItemView extends StatelessWidget {
  final SuggestedService suggestedService;

  const SuggestServiceItemView({Key? key, required this.suggestedService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EIGHT),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).cardColor , borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
          border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3)),
        ),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
          Row(children: [

            ClipRRect(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                child: CustomImage(height: 40, width: 40, fit: BoxFit.cover, image:
                "${Get.find<SplashController>().configModel.content!.imageBaseUrl}/category/${suggestedService.category?.image??""}"
                ),
            ),

            Expanded(child: Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(suggestedService.category?.name??"", style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
            )),
          ],),

          Padding(padding: const EdgeInsets.fromLTRB(0,Dimensions.PADDING_SIZE_DEFAULT,0,Dimensions.PADDING_SIZE_TINE),
            child: Text("suggested_service".tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).secondaryHeaderColor.withOpacity(0.8))),
          ),
          Text(suggestedService.serviceName??"", style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),

          Padding(padding: const EdgeInsets.fromLTRB(0,Dimensions.PADDING_SIZE_DEFAULT,0,Dimensions.PADDING_SIZE_TINE),
            child: Text("description".tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).secondaryHeaderColor.withOpacity(0.8))),
          ),

          Text(suggestedService.serviceDescription??"",
              style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
            maxLines: 100,
            overflow: TextOverflow.ellipsis,
            textAlign: Get.find<LocalizationController>().isLtr? TextAlign.justify:TextAlign.right,
          ),
        ]),
      ),
    );
  }
}

