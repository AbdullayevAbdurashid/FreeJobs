import 'package:demandium/feature/service_booking/repo/booking_details_repo.dart';
import 'package:demandium/feature/service_booking/widget/booking_screen_shimmer.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';
import 'package:demandium/core/core_export.dart';

class BookingHistory extends StatelessWidget {

   BookingHistory({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    Get.lazyPut(() => BookingDetailsTabsController(bookingDetailsRepo: BookingDetailsRepo(sharedPreferences: Get.find(), apiClient: Get.find())));
    return GetBuilder<BookingDetailsTabsController>(
      builder: (bookingDetailsTabController){
         if(bookingDetailsTabController.bookingDetailsContent!=null){
           BookingDetailsContent? bookingDetailsContent =  bookingDetailsTabController.bookingDetailsContent;
           return SingleChildScrollView(
             child: Column(
               children: [
                 Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text('${'booking_place'.tr} : ',
                       style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),
                     ),
                     Text("${DateConverter.dateMonthYearTimeTwentyFourFormat(DateConverter.isoUtcStringToLocalDate(bookingDetailsContent!.createdAt!.toString()))}",textDirection: TextDirection.ltr,
                       style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
                   ],
                 ),

                 SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                 Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_SMALL),

                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text("${'service_scheduled_date'.tr} : ",
                       style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),
                     ),
                     Text("${DateConverter.dateMonthYearTimeTwentyFourFormat(DateTime.tryParse(bookingDetailsContent.serviceSchedule!)!)}",
                       style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                       textDirection:  TextDirection.ltr,),
                   ],
                 ),
                 SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                 RichText(
                   text:  TextSpan(text: '${'payment_status'.tr} : ',
                     style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),
                     children: [
                       TextSpan(text: '${bookingDetailsContent.isPaid == 0 ? '${'unpaid'.tr}': 'paid'.tr} ',
                           style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                               color: bookingDetailsContent.isPaid == 0?Theme.of(context).colorScheme.error : Colors.green,decoration: TextDecoration.none)),
                     ],
                   ),
                 ),
                 SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                 RichText(
                   text:  TextSpan(
                     text: '${'booking_status'.tr} : ',
                     style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),
                     children: [
                       TextSpan(
                           text: "${bookingDetailsContent.bookingStatus!.tr}",
                           style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color:  Theme.of(context).colorScheme.primary)),
                     ],
                   ),
                 ),
                 Gaps.verticalGapOf(Dimensions.PADDING_SIZE_DEFAULT),


                 Padding(
                   padding:  EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                   child: Container(
                     child: HistoryStatus(
                       bookingDetailsContent: bookingDetailsContent,
                       statusHistories: bookingDetailsContent.statusHistories,
                       scheduleHistories: bookingDetailsContent.scheduleHistories,
                       increment: bookingDetailsContent.scheduleHistories!.length>1?2:1,
                     ),
                   ),
                 ),
                 SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
               ],
             ),
           );
         }else{
           return SingleChildScrollView(child: BookingScreenShimmer());
         }
      },
    );
  }
}

class HistoryStatus extends StatelessWidget {
  final BookingDetailsContent? bookingDetailsContent;
  final List<StatusHistories>? statusHistories;
  final List<ScheduleHistories>? scheduleHistories;
  final int increment;
  HistoryStatus({
    required this.statusHistories, this.scheduleHistories, required this.increment, this.bookingDetailsContent
  });
  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      theme: TimelineThemeData(
          nodePosition: 0,
          indicatorTheme: IndicatorThemeData(position: 0, size: 30.0)),
      padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: Get.find<LocalizationController>().isLtr?0:10),
      builder: TimelineTileBuilder.connected(connectionDirection: ConnectionDirection.before,

        itemCount: statusHistories!.length+increment,

        contentsBuilder: (_, index) {

          return Padding(padding:  EdgeInsets.only(left: 20.0,bottom: 20.0,top: 7,right: 10), child:
          index==0?
          Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${'service_booked_by_customer'.tr} ${scheduleHistories![index].user!=null?scheduleHistories![index].user!.firstName:"customer".tr} "
                  "${scheduleHistories![index].user!=null?scheduleHistories![index].user!.lastName:""}",
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault)
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              Text("${DateConverter.dateMonthYearTimeTwentyFourFormat(DateConverter.isoUtcStringToLocalDate(scheduleHistories![index].createdAt!))}",
                style: ubuntuRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                textDirection: TextDirection.ltr,
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            ],
          )


              :index==1 ?
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${'booking'.tr} ${statusHistories![index-1].bookingStatus.toString().tr.toLowerCase()} ${'by'.tr} "
                  "${statusHistories![index-1].user!.userType.toString().tr} ",
                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,),
              ),


              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              statusHistories![index-1].user!.userType!='provider-admin'?
              Text("${statusHistories![index-1].user!.firstName} ${statusHistories![index-1].user!.lastName}",
                style: ubuntuRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ): Text(bookingDetailsContent?.provider?.companyName??"",
                style: ubuntuRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),


              SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

              Text("${DateConverter.dateMonthYearTimeTwentyFourFormat(DateConverter.isoUtcStringToLocalDate(statusHistories![index-1].createdAt!))}",
                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).secondaryHeaderColor),
                textDirection: TextDirection.ltr,
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
            ],
          )

              :index==2 && scheduleHistories!.length>1?
          Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: (scheduleHistories!.length-1)*80,

                child: ListView.builder(itemBuilder: (_,_index){
                  return  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${'schedule_changed_by'.tr} ${scheduleHistories![_index+1].user!.userType.toString().tr}",
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                      if(scheduleHistories![_index+1].user!.userType!='provider-admin')
                      Text("${scheduleHistories![_index+1].user?.firstName.toString()} ${scheduleHistories![_index+1].user?.lastName.toString()}",
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).secondaryHeaderColor),
                        textDirection: TextDirection.ltr,
                      ),
                      if(scheduleHistories![_index+1].user!.userType=='provider-admin')
                        Text("${bookingDetailsContent?.provider?.companyName??""} ",
                          style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).secondaryHeaderColor),
                          textDirection: TextDirection.ltr,
                        ),

                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

                      Text("${DateConverter.dateMonthYearTimeTwentyFourFormat(DateTime.tryParse(scheduleHistories![_index+1].schedule!)!)}",
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).secondaryHeaderColor),
                        textDirection: TextDirection.ltr,
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

                    ],
                  );},
                  shrinkWrap:true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: scheduleHistories!.length-1,
                ),
              ),
            ],
          )
              :Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${'booking'.tr} ${statusHistories![index-increment].bookingStatus.toString().tr.toLowerCase()} ${'by'.tr} "
                  "${statusHistories![index-increment].user!.userType.toString().tr} ",
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault)
              ),

              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              Text(bookingDetailsContent?.provider?.companyName??"",
                  style: ubuntuRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).secondaryHeaderColor,
                  )
              ),

              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              Text("${DateConverter.dateMonthYearTimeTwentyFourFormat(DateConverter.isoUtcStringToLocalDate(statusHistories![index-increment].updatedAt!))}",
                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).secondaryHeaderColor),
                textDirection: TextDirection.ltr,
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
            ],
          ),
          );},

        connectorBuilder: (_, index, __) => SolidLineConnector(color: Theme.of(context).primaryColor),

        indicatorBuilder: (_, index) {
          return DotIndicator(
            color: Theme.of(context).primaryColor,
            child: Center(child : Icon(Icons.check,color:light.cardColor)),
          );
        },
      ),
    );
  }
}