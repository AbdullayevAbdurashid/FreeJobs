import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/service_booking/widget/booking_summery_widget.dart';
import 'package:demandium/feature/service_booking/widget/provider_info.dart';
import 'package:demandium/feature/service_booking/widget/service_man_info.dart';
import 'booking_screen_shimmer.dart';

class BookingDetailsSection extends StatelessWidget {
  final String bookingID;
  BookingDetailsSection({Key? key, required this.bookingID }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BookingDetailsTabsController>(
          builder: (bookingDetailsTabController) {
        if(bookingDetailsTabController.bookingDetailsContent != null){
          BookingDetailsContent? bookingDetailsContent =  bookingDetailsTabController.bookingDetailsContent;
            return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_RADIUS,),
                  BookingInfo(bookingDetailsContent: bookingDetailsContent!, bookingDetailsTabController: bookingDetailsTabController),
                  //Booking Summary


                  Gaps.verticalGapOf(Dimensions.PADDING_SIZE_DEFAULT),
                  BookingSummeryWidget(bookingDetailsContent: bookingDetailsContent),


                  if(bookingDetailsContent.provider != null)
                    ProviderInfo(provider: bookingDetailsContent.provider!),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                  if(bookingDetailsContent.serviceman != null)
                    ServiceManInfo(user: bookingDetailsContent.serviceman!.user!),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  bookingDetailsTabController.isCancelling?
                  Container(child: Center(child: CircularProgressIndicator()),):
                  bookingDetailsContent.bookingStatus == 'pending' || bookingDetailsContent.bookingStatus == 'accepted'?
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: ()  {
                        Get.dialog(
                            ConfirmationDialog(
                                icon: Images.deleteProfile,
                                title: 'are_you_sure_to_cancel_your_order'.tr,
                                description: 'your_order_will_be_cancel'.tr,
                                descriptionTextColor: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5),
                                onYesPressed: () {
                                  bookingDetailsTabController.bookingCancel(bookingId: bookingDetailsContent.id!);
                                  Get.back();
                                }
                            ),
                            useSafeArea: false);

                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).errorColor.withOpacity(.2),
                              borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_LARGE))),
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15),
                            child: Text('cancel'.tr,style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeLarge,
                                color: Theme.of(context).errorColor),),
                          )
                      ),
                    ),
                  ) : SizedBox(),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE*4),
                ],
              ),
            ),
          );
        }else{
          return SingleChildScrollView(child: BookingScreenShimmer());
        }
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GetBuilder<BookingDetailsTabsController>(builder: (bookingDetailsController){
        if(bookingDetailsController.bookingDetailsContent!=null){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: Dimensions.PADDING_SIZE_DEFAULT,left: Dimensions.PADDING_SIZE_DEFAULT,right: Dimensions.PADDING_SIZE_DEFAULT),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                        hoverColor: Colors.transparent,
                        elevation: 0.0,
                        child: new Icon(Icons.message_rounded,
                            color: Theme.of(context).primaryColorLight),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          BookingDetailsContent bookingDetailsContent = bookingDetailsController.bookingDetailsContent!;

                          if (bookingDetailsContent.provider != null ||
                              bookingDetailsContent.provider != null) {

                            showModalBottomSheet(
                                useRootNavigator: true,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) => CreateChannelDialog(
                                  customerID: bookingDetailsContent.customerId,
                                  providerId: bookingDetailsContent.provider != null
                                      ? bookingDetailsContent.provider!.userId!
                                      : null,
                                  serviceManId: bookingDetailsContent.serviceman != null
                                      ? bookingDetailsContent.serviceman!.userId!
                                      : null,
                                  referenceId: bookingDetailsContent.readableId.toString(),
                                )
                            );
                          } else {
                            customSnackBar('provider_or_service_man_assigned'.tr);
                          }
                        }),
                  ],
                ),
              ),

              if(bookingDetailsController.bookingDetailsContent!.bookingStatus=='completed')
                CustomButton(
                  radius: 0,
                  buttonText: 'review'.tr,
                  onPressed: (){

                    showModalBottomSheet(
                        context: context,
                        useRootNavigator: true,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => ReviewRecommendationDialog(
                            id: bookingDetailsController.bookingDetailsContent!.id!
                        )
                    );
                  },
                )
            ],
          );
        }else{
          return SizedBox();
        }
      }),
    );
  }

}
