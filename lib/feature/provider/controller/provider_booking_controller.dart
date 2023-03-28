import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/provider/model/category_model_item.dart';
import 'package:demandium/feature/provider/model/provider_details_model.dart';
import 'package:demandium/feature/provider/model/provider_model.dart';
import 'package:demandium/feature/provider/repository/provider_booking_repo.dart';
import 'package:get/get.dart';


class ProviderBookingController extends GetxController implements GetxService {
  final ProviderBookingRepo providerBookingRepo;
  ProviderBookingController({required this.providerBookingRepo});


  @override
  void onInit() async {
    super.onInit();
    getCategoryList();
  }

  bool _isLoading = false;
  get isLoading => _isLoading;

  ProviderModel? _providerModel;
  ProviderModel? get providerModel => _providerModel;

  ProviderDetailsContent? _providerDetailsContent;
  ProviderDetailsContent? get providerDetailsContent => _providerDetailsContent;

  List<CategoryModelItem> categoryItemList =[];

  List<ProviderData>? _providerList;
  List<ProviderData>? get  providerList=> _providerList;

  Future<void> getProviderList(int offset, bool reload) async {

    if(offset != 1 || _providerModel == null || reload){
      if(reload){
        _providerModel = null;
      }
      
      Map<String,dynamic> body={
        'sort_by': sortBy[selectedSortByIndex],
        'rating': selectedRatingIndex,
      }; 
      
      if(selectedCategoryId.isNotEmpty){
        body.addAll({'category_ids': selectedCategoryId});
      }

      Response response = await providerBookingRepo.getProviderList(offset,body);
      if (response.statusCode == 200) {
        if(reload){
          _providerList = [];
        }
        _providerModel = ProviderModel.fromJson(response.body);
        if(_providerModel != null && offset != 1){
          _providerList!.addAll(ProviderModel.fromJson(response.body).content?.data??[]);
        }else{
          _providerList = [];
          _providerList!.addAll(ProviderModel.fromJson(response.body).content?.data??[]);
        }
        update();
      } else {
       // ApiChecker.checkApi(response);
      }
    }
  }



  Future<void> getProviderDetailsData(String providerId, bool reload) async {

    if(_providerDetailsContent == null || reload){
      if(reload){
        categoryItemList =[];
        _providerDetailsContent = null;
      }
      Response response = await providerBookingRepo.getProviderDetails(providerId);
      if (response.statusCode == 200) {
        _providerDetailsContent = ProviderDetails.fromJson(response.body).content;

        if(_providerDetailsContent!.subCategories!=null || _providerDetailsContent!.subCategories!.isNotEmpty){
          _providerDetailsContent!.subCategories!.forEach((subcategory) {
            List<Service> serviceList = [];
            if(subcategory.services!.isNotEmpty){
              subcategory.services?.forEach((service) {
                  serviceList.add(service);
              });

              if(serviceList.length>0){
                categoryItemList.add(CategoryModelItem(
                  title: subcategory.name!, serviceList: serviceList,
                ));
              }
            }
          });
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }



  /// filter Section
  int selectedRatingIndex = 0;
  int selectedSortByIndex = 0;

  List<CategoryModel> categoryList =[];

  List<String> sortBy = ['asc',"desc"];

  List<bool> categoryCheckList =[];
  List<String> selectedCategoryId =[];

  Future<void> getCategoryList() async {
    Response response = await providerBookingRepo.getCategoryList();
    if(response.statusCode == 200){

      categoryList = [];
      categoryCheckList = [];

      List<dynamic> _serviceCategoryList = response.body['content']['data'];
      _serviceCategoryList.forEach((category) {
        categoryList.add(CategoryModel.fromJson(category));
        categoryCheckList.add(false);
      });
    }
    else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  updateSortByIndex(int rating){
    selectedSortByIndex= rating;
    update();
  }

  updateRatingIndex(int rating){
    selectedRatingIndex= rating;
    update();
  }

  void toggleFromCampaignChecked(int index) {

    categoryCheckList[index] = !categoryCheckList[index];

    if(categoryCheckList[index]==true){
      if(!selectedCategoryId.contains(categoryList[index].id)){
        selectedCategoryId.add(categoryList[index].id!);
      }
    }else{
      if(selectedCategoryId.contains(categoryList[index].id)){
        selectedCategoryId.remove(categoryList[index].id);
      }
    }
    update();
    print(selectedCategoryId.toString());
  }

  resetProviderFilterData({bool shouldUpdate= false}){
    selectedCategoryId=[];
    selectedRatingIndex=0;
    selectedRatingIndex = 0;

    categoryList.forEach((element) {
      categoryCheckList.add(false);
    });
    if(shouldUpdate){
      update();
    }
  }
}