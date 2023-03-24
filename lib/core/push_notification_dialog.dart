import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:demandium/core/core_export.dart';

class PushNotificationDialog extends StatefulWidget {
  final String? title;
  final String? body;
  final String? bookingID;
  PushNotificationDialog({required this.title, required this.body, required this.bookingID});

  @override
  State<PushNotificationDialog> createState() => _NewRequestDialogState();
}

class _NewRequestDialogState extends State<PushNotificationDialog> {

  @override
  void initState() {
    super.initState();
    if(Get.find<AuthController>().isLoggedIn()){
      if(Get.find<AuthController>().isNotificationActive()){
        print(Get.find<AuthController>().isNotificationActive());
        print("Notification Sound");
        _startAlarm();
      }
    }
  }
  void _startAlarm() async {
    AudioCache _audio = AudioCache();
    _audio.play('notification.wav');
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      child: Container(
        width: Dimensions.PUSH_NOTIFICATION_DIALOG_WIDTH,
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.notifications_active, size: 60, color: Theme.of(context).colorScheme.primary),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                child: Text(
                  widget.title!,
                  textAlign: TextAlign.center,
                  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
          Row(
              children: [
                Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize: Size(1170, 40), padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),),
                      child: Text(
                        'cancel'.tr,
                        textAlign: TextAlign.center,
                        style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyText1!.color),
              ),
            )),
            SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
            Expanded(child: CustomButton(
              height: 40,
              buttonText: 'go'.tr,
              onPressed: () {
                Get.back();
                if(widget.bookingID != null && widget.bookingID != ''){
                  Get.toNamed(RouteHelper.getBookingDetailsScreen(widget.bookingID!,'fromNotification'));
                }else{
                  Get.toNamed(RouteHelper.getNotificationRoute());
                }
              }),
            ),
          ]),

        ]),
      ),
    );
  }
}
