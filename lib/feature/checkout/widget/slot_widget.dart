import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class SlotWidget extends StatelessWidget {
  final String? title;
  final bool? isSelected;
  final Function()? onTap;
  SlotWidget({required this.title, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
      child: InkWell(
        onTap: onTap!,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected! ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            boxShadow: [ BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200]!, spreadRadius: 0.5, blurRadius: 0.5)],),
          child: Text(
            title!,
            style: ubuntuRegular.copyWith(color: isSelected! ? Theme.of(context).cardColor : Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ),
      ),
    );
  }
}
