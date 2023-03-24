import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class BookingStatusTabItem extends GetView<ServiceBookingController> {
  const BookingStatusTabItem({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,vertical: 5),
      decoration: BoxDecoration(
          color: controller.selectedBookingStatus.name != title ? Colors.grey.withOpacity(0.2): Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        children: [
          Image.asset(title.png),
          SizedBox(width: 5,),
          Text(
            "$title".tr,
            textAlign: TextAlign.center,
            style:ubuntuMedium.copyWith(
                fontSize: Dimensions.fontSizeSmall,
                color: controller.selectedBookingStatus.name != title?
                Theme.of(context).textTheme.bodyText1!.color: Colors.white),)
        ],
      ),
    );
  }
}

extension on String {
  String get png => 'assets/images/$this.png';
}