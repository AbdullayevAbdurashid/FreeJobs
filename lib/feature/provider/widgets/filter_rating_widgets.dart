import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/provider/controller/provider_booking_controller.dart';
import 'package:get/get.dart';

class FilterRatingWidgets extends StatelessWidget {
  final bool clickable;
  const FilterRatingWidgets({Key? key,this.clickable = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProviderBookingController>(builder: (providerBookingController){
      return Container(
        height: 50.0,
        child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return starWidget(index,context,providerBookingController);
          },shrinkWrap: true,
          physics: NeverScrollableScrollPhysics()
          ,),
      );
    });
  }

  Widget starWidget(int index, BuildContext context,ProviderBookingController controller) {
    return IconButton(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
      onPressed: clickable? () {
          controller.updateRatingIndex(index+1);
      }:null,
      icon: Image.asset(
        index < controller.selectedRatingIndex ? Images.starFill:Images.starBorder,color: Theme.of(context).colorScheme.primary,
        width: 24.0,
        height: 24.0,
      ),
    );
  }
}
