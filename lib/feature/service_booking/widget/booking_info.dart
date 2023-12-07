import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/service_booking/controller/invoice_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class BookingInfo extends StatelessWidget {
  final BookingDetailsContent bookingDetailsContent;
  final BookingDetailsTabsController bookingDetailsTabController;
  const BookingInfo({Key? key, required this.bookingDetailsContent, required this.bookingDetailsTabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${'booking'.tr} #${bookingDetailsContent.readableId}',
                      style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).textTheme.bodyLarge!.color,decoration: TextDecoration.none),),

                    Padding(
                      padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                      child: ElevatedButton(
                        onPressed: () async {
                          Get.dialog(const CustomLoader());
                          var pdfFile = await InvoiceController.generateUint8List(bookingDetailsContent,
                              bookingDetailsTabController.invoiceItems,
                              bookingDetailsTabController
                          );
                          Printing.layoutPdf(
                            onLayout: (PdfPageFormat format) {
                              return pdfFile;
                            },
                          );
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                        ),

                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall-2,horizontal: Dimensions.paddingSizeSmall),
                          child: Center(child: Text("invoice".tr, style: ubuntuMedium.copyWith(
                              color: Theme.of(context).primaryColorLight,
                              fontSize: Dimensions.fontSizeDefault),)),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall-2,horizontal: Dimensions.paddingSizeSmall),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Theme.of(context).hoverColor),
                      child: Text(""
                          "${bookingDetailsContent.bookingStatus!}".tr,
                        style:ubuntuMedium.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.fontSizeSmall,
                          color: bookingDetailsContent.bookingStatus=="ongoing" ? const Color(0xff2B95FF) :
                          bookingDetailsContent.bookingStatus=="pending" ? Theme.of(context).colorScheme.primary:
                          bookingDetailsContent.bookingStatus=="accepted" ? const Color(0xff0461A5):
                          bookingDetailsContent.bookingStatus=="completed" ? const Color(0xff16B559):
                          const Color(0xffFF3737),),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
            BookingItem(
              img: Images.iconCalendar,
              title: "${'booking_date'.tr} : ",
              date: DateConverter.dateMonthYearTimeTwentyFourFormat(DateConverter.isoUtcStringToLocalDate(bookingDetailsContent.createdAt!)),),
            Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),
            BookingItem(
                img: Images.iconCalendar,
                title: "${'service_schedule_date'.tr} : ",
                date:   DateConverter.dateMonthYearTimeTwentyFourFormat(DateTime.tryParse(bookingDetailsContent.serviceSchedule!)!)),
            Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),
            BookingItem(
              img: Images.iconLocation,
              title: '${'address'.tr} : ${bookingDetailsContent.serviceAddress != null?
              bookingDetailsContent.serviceAddress!.address! : 'no_address_found'.tr}',
              date: '',
            ),
            Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
            Text(
                "payment_method".tr,
                style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color)),
            Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),



            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(bookingDetailsContent.paymentMethod!.tr,
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5))),
                RichText(text: TextSpan(
                      text: "${'payment_status'.tr} : ",
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5)),
                      children: <TextSpan>[
                        TextSpan(
                          text: bookingDetailsContent.isPaid == 1 ? "paid".tr : "unpaid".tr,
                          style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeSmall,color:bookingDetailsContent.isPaid == 1 ? Colors.green: Theme.of(context).colorScheme.error),
                        )
                      ]
                  ),
                ),
              ],
            ),
            Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),


            if(bookingDetailsContent.transactionId != "cash-payment")
            Text("${'transaction_id'.tr} : ${bookingDetailsContent.transactionId}",
              style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).hintColor),),
            Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),
            Row(
              children: [
                Text("${'amount'.tr}:",
                  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)),),
                const SizedBox(width: Dimensions.paddingSizeSmall,),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(PriceConverter.convertPrice(bookingDetailsContent.totalBookingAmount!.toDouble()),
                    style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)),),
                ),
              ],
            ),

            Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
          ],
        ),
      ),
    );
  }
}
