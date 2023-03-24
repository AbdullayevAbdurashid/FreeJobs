import 'package:demandium/data/model/notification_body.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class SplashScreen extends StatefulWidget {
  final NotificationBody? body;
  SplashScreen({@required this.body});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool _firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection'.tr : 'connected'.tr,
            textAlign: TextAlign.center,
          ),
        ));
        if(!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
    });

    Get.find<SplashController>().initSharedData();
    Get.find<CartController>().getCartData();
    _route();

  }

  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged.cancel();
  }

  void _route() {
    Get.find<SplashController>().getConfigData().then((isSuccess) {
      if(isSuccess) {
        Timer(Duration(seconds: 1), () async {
          bool isAvailableUpdate =false;

          String _minimumVersion = "1.1.0";
          double? minimumBaseVersion =1.0;
          double? minimumLastVersion =0;

          String appVersion = AppConstants.APP_VERSION;
          double? baseVersion = double.tryParse(appVersion.substring(0,3));
          double lastVersion=0;
          if(appVersion.length>3){
             lastVersion = double.tryParse(appVersion.substring(4,5))!;
          }


          if(GetPlatform.isAndroid && Get.find<SplashController>().configModel.content!.minimumVersion!=null) {
            _minimumVersion = Get.find<SplashController>().configModel.content!.minimumVersion!.minVersionForAndroid!.toString();
            if(_minimumVersion.length==1){
              _minimumVersion = _minimumVersion+".0";
            }
            if(_minimumVersion.length==3){
              _minimumVersion = _minimumVersion+".0";
            }
            print("minimumVersion: $_minimumVersion");
            minimumBaseVersion = double.tryParse(_minimumVersion.substring(0,3));
            minimumLastVersion = double.tryParse(_minimumVersion.substring(4,5));

            if(minimumBaseVersion!>baseVersion!){
              isAvailableUpdate= true;
            }else if(minimumBaseVersion==baseVersion){
              if(minimumLastVersion!>lastVersion){
                isAvailableUpdate = true;
              }else{
                isAvailableUpdate = false;
              }
            }else{
              isAvailableUpdate = false;
            }
          }
          else if(GetPlatform.isIOS && Get.find<SplashController>().configModel.content!.minimumVersion!=null) {
            _minimumVersion = Get.find<SplashController>().configModel.content!.minimumVersion!.minVersionForIos!;
            if(_minimumVersion.length==1){
              _minimumVersion = _minimumVersion+".0";
            }
            if(_minimumVersion.length==3){
              _minimumVersion = _minimumVersion+".0";
            }
            minimumBaseVersion = double.tryParse(_minimumVersion.substring(0,3));
            if(_minimumVersion.length>3){
              minimumLastVersion = double.tryParse(_minimumVersion.substring(4,5));
            }
            if(minimumBaseVersion!>baseVersion!){
              isAvailableUpdate= true;
            }else if(minimumBaseVersion==baseVersion){
              if(minimumLastVersion!>lastVersion){
                isAvailableUpdate = true;
              }else{
                isAvailableUpdate = false;
              }
            }else{
              isAvailableUpdate = false;
            }
          }
          if(isAvailableUpdate) {
            Get.offNamed(RouteHelper.getUpdateRoute(isAvailableUpdate));
          }
          else {
            if(widget.body != null) {
                if(widget.body!.type=='general'){
                  Get.toNamed(RouteHelper.getNotificationRoute());
                }else if(widget.body!.type=='booking'
                    && widget.body!.bookingId!=null&& widget.body!.bookingId!=""){
                  Get.toNamed(RouteHelper.getBookingDetailsScreen(widget.body!.bookingId!,'fromNotification'));
                } else if(widget.body!.type=='privacy_policy'){
                  Get.toNamed(RouteHelper.getHtmlRoute("privacy-policy"));
                }else if(widget.body!.type=='terms_and_conditions'){
                  Get.toNamed(RouteHelper.getHtmlRoute("terms-and-condition"));
                }else{
                  Get.toNamed(RouteHelper.getNotificationRoute());
                }
            }
            else {
              if (Get.find<AuthController>().isLoggedIn()) {
                Get.find<AuthController>().updateToken();
                if (Get.find<LocationController>().getUserAddress() != null) {

                  Get.offNamed(RouteHelper.getInitialRoute());
                } else {
                  Get.offNamed(RouteHelper.getAccessLocationRoute('splash'));
                }
              } else {
                if(!Get.find<SplashController>().isSplashSeen()){
                  Get.offNamed(RouteHelper.getLanguageScreen('fromOthers'));
                }else{
                  Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
                }
              }
            }
          }
        });
      }else{

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: GetBuilder<SplashController>(builder: (splashController) {
        PriceConverter.getCurrency();
        return Center(
          child: splashController.hasConnection ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Images.logo,
                width: Dimensions.LOGO_SIZE,
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            ],
          ) : NoInternetScreen(child: SplashScreen(body: widget.body)),
        );
      }),
    );
  }
}
