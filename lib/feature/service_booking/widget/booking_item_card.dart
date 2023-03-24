import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class BookingItemCard extends StatelessWidget {
  final BookingModel bookingModel;
  const BookingItemCard({Key? key, required this.bookingModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String bookingStatus = bookingModel.bookingStatus!;
    return GestureDetector(
      onTap: (){
        Get.toNamed(RouteHelper.getBookingDetailsScreen(bookingModel.id!,'others'));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_RADIUS),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow:Get.isDarkMode ? null: cardShadow,
          ), //boxShadow: shadow),
          padding:  EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_RADIUS,horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                  children: [
                    Expanded(child: Text('${'booking'.tr}# ${bookingModel.readableId}', style: ubuntuBold.copyWith())),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color:
                        bookingStatus=="ongoing" ? Theme.of(context).colorScheme.primary.withOpacity(.2):
                        bookingStatus=="pending" ? Theme.of(context).colorScheme.primary.withOpacity(.2):
                        bookingStatus=="accepted" ? Theme.of(context).colorScheme.primary.withOpacity(.2):
                        bookingStatus=="completed" ? Colors.green.withOpacity(.2) :
                        Theme.of(context).errorColor.withOpacity(.2)),
                      child: Padding(padding:  EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_RADIUS),
                        child: Center(
                          child: Text(bookingStatus.tr,
                            style:ubuntuMedium.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: bookingStatus=="ongoing" ? Theme.of(context).colorScheme.primary:
                              bookingStatus=="pending" ? Get.isDarkMode ? Theme.of(context).secondaryHeaderColor :
                              Theme.of(context).colorScheme.primary :
                              bookingStatus=="accepted" ? Theme.of(context).colorScheme.primary:
                              bookingStatus=="completed" ? Colors.green: Theme.of(context).errorColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              Row(
                children: [
                  Text('${'booking_date'.tr} : ', style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,  color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6))),
                  Text("${DateConverter.dateMonthYearTimeTwentyFourFormat(DateConverter.isoUtcStringToLocalDate(bookingModel.createdAt.toString()))}",textDirection: TextDirection.ltr,
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,  color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6))),
                ],
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
              Row(
                children: [
                  Text('${'service_date'.tr} : ', style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,  color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6))),
                  Text("${DateConverter.dateMonthYearTimeTwentyFourFormat(DateTime.tryParse(bookingModel.serviceSchedule!)!)}",
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,  color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6)),
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
              Row(
                children: [
                  Text('${'total_amount'.tr} : ${PriceConverter.convertPrice(bookingModel.totalBookingAmount!.toDouble())}',
                    style: ubuntuMedium.copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  Spacer(),
                  Text('view_details'.tr,
                    style: ubuntuMedium.copyWith(color:Get.isDarkMode ? Theme.of(context).primaryColorLight.withOpacity(.7): Theme.of(context).colorScheme.primary,
                        fontSize: Dimensions.fontSizeSmall,
                        decoration: TextDecoration.underline),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



}
