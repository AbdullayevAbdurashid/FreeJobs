import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/review/repo/submit_review_repo.dart';

class SubmitReviewController extends GetxController {
  final SubmitReviewRepo submitReviewRepo ;
  SubmitReviewController({required this.submitReviewRepo});


  bool _isLoading = false;
  get isLoading => _isLoading;

  bool _loading = false;
  get loading => _loading;

  Map<String,Map<String, dynamic>> listOfReview = {};


  List<BookingContentDetailsItem> uniqueServiceList =[];
  List<String> serviceIdList =[];

  TextEditingController reviewController = TextEditingController();
  Map<String, TextEditingController> textControllers =  Map();
  Map<String, int> selectedRating =  Map();
  Map<String, bool> isEditable =  Map();
  Map<String, String> reviewComments =  Map();

  int _selectedIndex = -1;
  int get selectedIndex => _selectedIndex;

   selectReview(int rating,serviceId){
     selectedRating[serviceId] = rating;
    update();
  }

  void setIndex(int index){
    _selectedIndex= index;
    update();
  }

  Future<void> submitReview(ReviewBody reviewBody,String serviceId,String review, int rating)async{
    _isLoading = true;
    update();
    Response response =await submitReviewRepo.submitReview(reviewBody: reviewBody);
    if(response.statusCode == 200){

      isEditable[serviceId] = false;
      reviewComments[serviceId]=review;
      customSnackBar('review_submitted_successfully'.tr,isError: false);
    }
    _isLoading = false;
    update();
  }


  Future<void> getReviewList(String bookingId)async{
    _loading = true;
    update();
    Response response =await submitReviewRepo.getReviewList(bookingId: bookingId);
    if(response.statusCode == 200){
      print('===>${response.body['content']}');
      if(response.body['content'].isNotEmpty){
        serviceIdList.forEach((id) {
         if( response.body['content'][id]!=null){
           listOfReview[id]= response.body['content'][id][0];
           selectedRating[id] = response.body['content'][id][0]['review_rating'];
           textControllers[id]!.text = response.body['content'][id][0]['review_comment'];
           reviewComments[id] = response.body['content'][id][0]['review_comment'];

           if(response.body['content'][id][0]['review_comment']!=null || response.body['content'][id][0]['review_comment']!=""){
             isEditable[id] = false;
           }
           }
        });
      }
      print(listOfReview.toString());
    }
    _loading = false;
    update();
  }

  void  uniqueService(BookingDetailsContent bookingDetailsContent){
     serviceIdList =[];
     uniqueServiceList =[];
    bookingDetailsContent.detail!.forEach((element) {
      if(!serviceIdList.contains(element.serviceId)){
        serviceIdList.add(element.serviceId!);
        uniqueServiceList.add(element);
      }
    });
    uniqueServiceList.forEach((_method) => textControllers[_method.serviceId!] = TextEditingController());
    uniqueServiceList.forEach((_method) => selectedRating[_method.serviceId!] = 5);
    uniqueServiceList.forEach((_method) => isEditable[_method.serviceId!] = true);
  }

  void updateEditableValue(String serviceId,bool value,{bool isUpdate= false}){
    isEditable[serviceId] = value;
    if(isUpdate){
      update();
    }
    print(isEditable[serviceId]);

  }
}