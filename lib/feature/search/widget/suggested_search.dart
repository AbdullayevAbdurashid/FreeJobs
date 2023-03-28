import 'package:demandium/components/ripple_button.dart';
import 'package:demandium/core/core_export.dart';
import 'package:get/get.dart';

class SuggestedSearch extends StatelessWidget {
  const SuggestedSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('suggest_for_you'.tr,style: ubuntuMedium.copyWith(
            fontSize: Dimensions.fontSizeLarge,
            color: Theme.of(context).colorScheme.primary),),

        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

        Wrap(
          children: [
            SuggestedSearchItem(title: 'all_service',),
            SuggestedSearchItem(title: 'popular_services',),
            SuggestedSearchItem(title: 'trending_services',),
          ],
        )
      ],
    );
  }
}

class SuggestedSearchItem extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const SuggestedSearchItem({Key? key, required this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color:Get.isDarkMode?Colors.grey.withOpacity(0.2): Theme.of(context).primaryColor.withOpacity(0.1)
          ),
          padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL-3, horizontal: Dimensions.PADDING_SIZE_SMALL,),
          margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL, bottom:Dimensions.PADDING_SIZE_SMALL),
          child: Text(title.tr, style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5)),),
        ),
        Positioned.fill(child: RippleButton(onTap: () {

          Get.toNamed(RouteHelper.allServiceScreenRoute(title));
          // Get.find<SearchController>().suggestedSearchData(title: title);
          // Get.find<SearchController>().populatedSearchController(title);
        }))
      ],
    );
  }
}

