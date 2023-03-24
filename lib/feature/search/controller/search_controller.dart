import 'package:demandium/feature/search/suggested_service_moel.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';


class SearchController extends GetxController implements GetxService {
  final SearchRepo searchRepo;
  SearchController({required this.searchRepo});

  List<Service>? _searchServiceList;
  String? _searchText = '';
  List<String>? _historyList = [];
  List<String>? _sortList = ['ascending'.tr, 'descending'.tr];
  bool? _isAvailableFoods = false;
  bool? _isDiscountedFoods = false;
  bool? _isLoading = false;
  bool _isSearchComplete = false;
  bool _isActiveSuffixIcon = false;

  List<Service>? get searchServiceList => _searchServiceList;
  String? get searchText => _searchText;
  List<String>? get historyList => _historyList;
  List<String>? get sortList => _sortList;
  bool? get isAvailableFoods => _isAvailableFoods;
  bool? get isDiscountedFoods => _isDiscountedFoods;
  bool? get isLoading => _isLoading;
  bool get isSearchComplete => _isSearchComplete;
  bool get isActiveSuffixIcon => _isActiveSuffixIcon;

  List<SuggestedService>? _searchHistoryListFromServer;
  List<SuggestedService>? get historyListFromServer=> _searchHistoryListFromServer;

  SuggestedServiceContent? _suggestedServiceContent;


  bool? _isLoggedIn;
  var searchController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if(_isLoggedIn!) {
      getSuggestedServicesFromServer();
    }
    getHistoryList();
    searchController.text = '';
  }

  void toggleAvailableFoods() {
    _isAvailableFoods = !_isAvailableFoods!;
    update();
  }

  void toggleDiscountedFoods() {
    _isDiscountedFoods = !_isDiscountedFoods!;
    update();
  }

  void setSearchText(String text) {
    _searchText = text;
    update();
  }

  Future<void> navigateToSearchResultScreen()async{
    if(searchController.value.text.trim().isNotEmpty){
      if(Get.currentRoute.contains('/search?query=')){
        Get.offNamed(RouteHelper.getSearchResultRoute(queryText: searchController.value.text.trim()));
      }else{
        Get.toNamed(RouteHelper.getSearchResultRoute(queryText: searchController.value.text.trim()));
      }
    }
  }

  Future<void> clearSearchController()async{
    if(searchController.value.text.trim().isNotEmpty){
      searchController.clear();
      _isSearchComplete = false;
      _isActiveSuffixIcon = false;
      update();
    }
  }

  Future<void> populatedSearchController(String historyText)async{
    searchController.clear();
    searchController = TextEditingController(text: historyText);
    _isActiveSuffixIcon = true;
    update();

  }

  void suggestedSearchData({String title='all'}){
    //_searchServiceList = [];
    _searchServiceList = null;
    _isSearchComplete = true;
      if(title=='all'){
        _searchServiceList = Get.find<ServiceController>().allService;
      }else if(title=='popular'){
        _searchServiceList = Get.find<ServiceController>().popularServiceList;
      }
      else if(title=='trending'){
        _searchServiceList = Get.find<ServiceController>().allService;
      }

      print(_searchServiceList!.length);
      update();
  }


  Future<void> searchData(String query, {bool shouldUpdate = true}) async {
    if(query.isNotEmpty ) {
      _searchText = query;
      _searchServiceList = null;
      if (!_historyList!.contains(query)) {
        _historyList!.insert(0, query);
      }
      searchRepo.saveSearchHistory(_historyList!);
      if(shouldUpdate) {
        update();
      }
      Response response = await searchRepo.getSearchData(query);
      if (response.statusCode == 200) {
        if (query.isEmpty) {
          _searchServiceList = [];
        } else {
          _searchServiceList = [];
          _searchServiceList!.addAll(ServiceModel.fromJson(response.body).content!.serviceList!);
        }
        await getSuggestedServicesFromServer();
      } else {
        ApiChecker.checkApi(response);
      }
      _isSearchComplete = true;
      update();
    }
  }

  Future<void> getSuggestedServicesFromServer() async {
    Response response = await searchRepo.getSuggestedServicesFromServer();
    if(response.statusCode==200  &&  response.body['response_code']=='default_200'){
      if(response.body['content']!=null){

        _searchHistoryListFromServer =[];
        _suggestedServiceContent = SuggestedServiceModel.fromJson(response.body).content;
        _searchHistoryListFromServer!.addAll(_suggestedServiceContent!.data!);

      }else{
        _searchHistoryListFromServer= [];
      }
    }else{
      _searchHistoryListFromServer= [];
    }
    update();
  }

  Future<void> removeSuggestedServicesFromServer({String? id,int? index}) async {
    Response response = await searchRepo.removeSuggestedServicesFromServer(id: id);
    if(response.statusCode==200  &&  response.body['response_code']=='default_delete_200'){
      if(index==null){
        _searchHistoryListFromServer = [];
      }else{
        _searchHistoryListFromServer?.removeAt(index);
      }
    }else{

    }
    update();
  }




  void showSuffixIcon(context,String text){
    if(text.length > 0){
      _isActiveSuffixIcon = true;
    }else if(text.length == 0){
      _isActiveSuffixIcon = false;
    }
    update();
  }


  void getHistoryList() {
    _searchText = '';
    _historyList = [];
    if(searchRepo.getSearchAddress().isNotEmpty){
      _historyList!.addAll(searchRepo.getSearchAddress());
    }
  }

  void removeHistory(int index) {
    _historyList!.removeAt(index);
    print(_historyList);
    searchRepo.saveSearchHistory(_historyList!);
    update();
  }

  List<String>? filterHistory(String pattern, List<String>? value){
    List<String>? _list = [];

    value?.forEach((history) {
      if(history.contains(pattern.toLowerCase())) {
        _list.add(history);
      }
    });

    return _list;
  }


  void clearSearchAddress() async {
    searchRepo.clearSearchHistory();
    _historyList = [];
    update();
  }

  void removeService() async {
   _searchServiceList = [];
   _isSearchComplete = false;
  }


}
