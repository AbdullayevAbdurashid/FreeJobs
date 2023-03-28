import 'package:demandium/core/core_export.dart';

class UnselectedProductWidget extends StatelessWidget {
  const UnselectedProductWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:  ResponsiveHelper.isDesktop(context)? 50 : 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.5),width: 0.7),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      ),
      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
      child: Center(child: Hero(tag: 'provide_image',
        child: ClipRRect( borderRadius: BorderRadius.circular(Dimensions.RADIUS_EXTRA_MORE_LARGE),
          child: Image.asset(Images.providerImage,height: 30,width: 30,),
        ),
      )),
    );
  }
}
