import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:demandium/feature/review/controller/submit_review_controller.dart';
import 'package:demandium/feature/review/widgets/select_rating.dart';
import 'package:demandium/core/core_export.dart';

class RateReviewScreen extends StatefulWidget{
  final String id;
  RateReviewScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<RateReviewScreen> createState() => _RateReviewScreenState();
}
class _RateReviewScreenState extends State<RateReviewScreen> {

  _loadData() async {
   await Get.find<BookingDetailsTabsController>().getBookingDetails(bookingId: widget.id);
    Get.find<SubmitReviewController>().uniqueService(Get.find<BookingDetailsTabsController>().bookingDetailsContent!);
   await Get.find<SubmitReviewController>().getReviewList(widget.id);
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar: CustomAppBar(title: 'review'.tr,),
      body: GetBuilder<BookingDetailsTabsController>(builder: (bookingController){
       if(bookingController.bookingDetailsContent!=null){
         return GetBuilder<SubmitReviewController>(builder: (submitReviewController){
           if(submitReviewController.loading){
             return Center(child: CircularProgressIndicator(),);
           }else{
             return FooterBaseView(
               child: SizedBox(
                 width: Dimensions.WEB_MAX_WIDTH,
                 child: SingleChildScrollView(
                   child: Column(
                     children: [
                       Stack(children: [
                         Container(
                           height:ResponsiveHelper.isDesktop(context)? 280: 120.0,
                           width: Get.width,
                           decoration: BoxDecoration(
                               image: DecorationImage(fit: BoxFit.fill, image: AssetImage(Images.reviewTopBanner))
                           ),),
                         Container(
                           height:ResponsiveHelper.isDesktop(context)? 280: 120.0,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                               ResponsiveHelper.isDesktop(context)?Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: ReviewBookingDetailsCard(bookingDetailsContent: bookingController.bookingDetailsContent!),
                               ):SizedBox(),
                             ],
                           ),
                         )
                       ],),

                       SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
                       !ResponsiveHelper.isDesktop(context)
                           ?ReviewBookingDetailsCard(bookingDetailsContent: bookingController.bookingDetailsContent!):SizedBox(),

                       ListView.builder(itemBuilder: (context,index) {

                         List<String> variationList=[];
                         Get.find<BookingDetailsTabsController>().bookingDetailsContent!.detail?.forEach((bookingDetailsItem) {
                           if(submitReviewController.uniqueServiceList[index].serviceId==bookingDetailsItem.serviceId){
                             variationList.add(bookingDetailsItem.variantKey??"");
                           }
                         });
                         String variations = variationList.toString().replaceAll('[', '');
                         variations = variations.replaceAll(']', '');

                         return Padding(
                           padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.isDesktop(context)?0:Dimensions.PADDING_SIZE_DEFAULT),
                           child: submitReviewController.isEditable[submitReviewController.uniqueServiceList[index].serviceId]!
                               ? EditableReview(submitReviewController: submitReviewController, index: index, variations: variations)
                               : NonEditableReview(submitReviewController: submitReviewController, index: index, variations: variations),
                         );
                       },
                         shrinkWrap: true,
                         physics: NeverScrollableScrollPhysics(),
                         itemCount:submitReviewController. uniqueServiceList.length,
                       ),

                       SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,)

                     ],
                   ),
                 ),
               ),
             );
           }
         }
         );
       }else{
         return Center(child: CircularProgressIndicator(),);
       }
      }
      ),
    );
  }
}

class ReviewBookingDetailsCard extends StatelessWidget {
  const ReviewBookingDetailsCard({
    Key? key,
    required this.bookingDetailsContent,
  }) : super(key: key);
  final BookingDetailsContent bookingDetailsContent;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL,vertical: Dimensions.PADDING_SIZE_SMALL),
      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        boxShadow:Get.isDarkMode ? null: cardShadow,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${'booking_no'.tr} # ${bookingDetailsContent.readableId}",
                style: ubuntuBold.copyWith(
                    fontSize: Dimensions.fontSizeLarge,
                    color: Theme.of(context).colorScheme.primary),),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                    "${PriceConverter.convertPrice(bookingDetailsContent.totalBookingAmount!.toDouble())}",
                    style: ubuntuBold.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        color: Theme.of(context).textTheme.bodyLarge!.color
                    )
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  '${DateConverter.formatDate(DateConverter.isoUtcStringToLocalDate(bookingDetailsContent.createdAt!))}',
                  style: ubuntuRegular.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)
                  ),
              ),
              Text("${bookingDetailsContent.bookingStatus}".tr, style: ubuntuMedium.copyWith(color: Colors.green),),
            ],
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,)
        ],

      ),
    );
  }
}

class EditableReview extends StatelessWidget {
 final  SubmitReviewController submitReviewController;
 final int index;
 final String variations;
  const EditableReview({Key? key,required this.submitReviewController, required this.index, required this.variations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
        Row(
          children: [
            Text(
              submitReviewController.uniqueServiceList[index].serviceName??"",
              style: ubuntuMedium.copyWith(
                fontSize: Dimensions.fontSizeLarge,
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
        Text(
          variations,
          style: ubuntuRegular.copyWith(
            fontSize: Dimensions.fontSizeSmall,
            color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            SelectRating(revivedId: submitReviewController.uniqueServiceList[index].serviceId.toString(),),
            SizedBox()
          ],
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Theme.of(context).hoverColor),
          child: Center(
            child: TextFormField(maxLines: 4,
              controller: submitReviewController.textControllers[submitReviewController.uniqueServiceList[index].serviceId],
              decoration: InputDecoration(
                hintText: 'write_your_review'.tr,
                border: InputBorder.none,
                hintStyle: ubuntuRegular,
              ),
            ),
          ),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
        GetBuilder<SubmitReviewController>(builder: (submitReviewController){
          return submitReviewController.isLoading && submitReviewController.selectedIndex==index
              ?Center(child: CircularProgressIndicator(),):
          CustomButton(
            height: 40,
            width: ResponsiveHelper.isDesktop(context)?200:ResponsiveHelper.isTab(context)?150:120,
            radius: 50,
            buttonText: 'submit'.tr,
            onPressed: (){
              String review = submitReviewController.textControllers[submitReviewController.uniqueServiceList[index].serviceId]!.value.text;
              if(isRedundentClick(DateTime.now())){
                return;
              }
              submitReviewController.setIndex(index);
              if(review.isNotEmpty) {
                ReviewBody  reviewBody = ReviewBody(
                    bookingID: submitReviewController.uniqueServiceList[index].bookingId!,
                    serviceID: submitReviewController.uniqueServiceList[index].serviceId!,
                    rating: submitReviewController.selectedRating[submitReviewController.uniqueServiceList[index].serviceId!].toString(),
                    comment: review);
                submitReviewController.submitReview(
                    reviewBody, submitReviewController.uniqueServiceList[index].serviceId!, review,
                    submitReviewController.selectedRating[submitReviewController.uniqueServiceList[index].serviceId!]!
                );
              } else{
                customSnackBar('please_write_a_review'.tr);
              }
            },
          );
        }),
      ],
    );
  }
}


class NonEditableReview extends StatelessWidget {
  final  SubmitReviewController submitReviewController;
  final int index;
  final String variations;
  const NonEditableReview({Key? key,required this.submitReviewController, required this.index, required this.variations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Stack(
        children:[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
              Row(
                children: [
                  Text(
                    submitReviewController.uniqueServiceList[index].serviceName??"",
                    style: ubuntuMedium.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                    ),
                  ),

                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),

                  Image.asset(Images.accepted,width: 15,),
                ],
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
              Padding(
                padding: Get.find<LocalizationController>().isLtr
                    ? EdgeInsets.only(right: Dimensions.PADDING_SIZE_EXTRA_LARGE*2)
                    : EdgeInsets.only(right: 0),
                child: Text(
                  variations,
                  style: ubuntuRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  SelectRating(revivedId: submitReviewController.uniqueServiceList[index].serviceId.toString(),clickable: false,),
                  SizedBox()
                ],
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_DEFAULT),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Theme.of(context).hoverColor),
                child: Text(
                    submitReviewController.reviewComments[submitReviewController.uniqueServiceList[index].serviceId]??"",
                  style: ubuntuRegular.copyWith(),
                ),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,),
            ],
          ),
          Get.find<LocalizationController>().isLtr?
          Positioned(
              right: 0,
              child: IconButton(
                  onPressed:() {
                    submitReviewController.updateEditableValue(submitReviewController.uniqueServiceList[index].serviceId!, true,isUpdate: true);
              }, icon: Image.asset(Images.edit,width: 15,)
              )
          ): Positioned(
              left: 0,
              child: IconButton(
                  onPressed:() {
                    submitReviewController.updateEditableValue(submitReviewController.uniqueServiceList[index].serviceId!, true,isUpdate: true);
                  }, icon: Image.asset(Images.edit,width: 15,)
              )
          )
        ]
    );
  }
}

