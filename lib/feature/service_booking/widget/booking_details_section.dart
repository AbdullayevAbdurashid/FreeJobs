import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/service_booking/widget/booking_summery_widget.dart';
import 'package:demandium/feature/service_booking/widget/provider_info.dart';
import 'package:demandium/feature/service_booking/widget/service_man_info.dart';
import 'booking_screen_shimmer.dart';

class BookingDetailsSection extends StatelessWidget {
  final String bookingID;
  const BookingDetailsSection({Key? key, required this.bookingID }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BookingDetailsTabsController>(
          builder: (bookingDetailsTabController) {
        if(bookingDetailsTabController.bookingDetailsContent != null){
          BookingDetailsContent? bookingDetailsContent =  bookingDetailsTabController.bookingDetailsContent;
            return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: Dimensions.paddingSizeEight,),
                  BookingInfo(bookingDetailsContent: bookingDetailsContent!, bookingDetailsTabController: bookingDetailsTabController),
                  //Booking Summary


                  Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
                  BookingSummeryWidget(bookingDetailsContent: bookingDetailsContent),


                  if(bookingDetailsContent.provider != null)
                    ProviderInfo(provider: bookingDetailsContent.provider!),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  if(bookingDetailsContent.serviceman != null)
                    ServiceManInfo(user: bookingDetailsContent.serviceman!.user!),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  bookingDetailsTabController.isCancelling?
                  const Center(child: CircularProgressIndicator()):
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
                                descriptionTextColor: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
                                onYesPressed: () {
                                  bookingDetailsTabController.bookingCancel(bookingId: bookingDetailsContent.id!);
                                  Get.back();
                                }
                            ),
                            useSafeArea: false);

                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.error.withOpacity(.2),
                              borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusLarge))),
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15),
                            child: Text('cancel'.tr,style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeLarge,
                                color: Theme.of(context).colorScheme.error),),
                          )
                      ),
                    ),
                  ) : const SizedBox(),
                  const SizedBox(height: Dimensions.paddingSizeExtraLarge*4),
                ],
              ),
            ),
          );
        }else{
          return const SingleChildScrollView(child: BookingScreenShimmer());
        }
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GetBuilder<BookingDetailsTabsController>(builder: (bookingDetailsController){
        if(bookingDetailsController.bookingDetailsContent!=null){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: Dimensions.paddingSizeDefault,left: Dimensions.paddingSizeDefault,right: Dimensions.paddingSizeDefault),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                        hoverColor: Colors.transparent,
                        elevation: 0.0,
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
                        },
                        child: Icon(Icons.message_rounded,
                            color: Theme.of(context).primaryColorLight)),
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
          return const SizedBox();
        }
      }),
    );
  }

}
