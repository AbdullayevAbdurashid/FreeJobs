import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class NotificationDialog extends StatelessWidget {
  final NotificationData? notificationModel;
  NotificationDialog({@required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Get.isDarkMode?Theme.of(context).primaryColorDark:null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_SMALL))),
      insetPadding: EdgeInsets.all(30),
      titlePadding:EdgeInsets.all(0.0),
      contentPadding:EdgeInsets.all(0.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      title: Align(alignment: Alignment.topRight,
        child: IconButton(icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      content:  SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: Column(
                  children: [
                    notificationModel!.title!=null?Text(notificationModel!.title!,style: ubuntuMedium.copyWith(color: Theme.of(context).
                    textTheme.bodyText1!.color!.withOpacity(0.7) ,
                        fontSize: Dimensions.fontSizeDefault
                    )): SizedBox.shrink(),

                    SizedBox(height: notificationModel!.title!=null? Dimensions.PADDING_SIZE_DEFAULT:0,),

                    Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                            color: Theme.of(context).primaryColor.withOpacity(0.20)
                        ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage.assetNetwork(
                          placeholder: Images.placeholder,
                          image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}''/push-notification/${notificationModel!.coverImage}',
                          fit: BoxFit.contain,
                          imageErrorBuilder: (c, o, s) => Image.asset(
                            Images.placeholder, height: MediaQuery.of(context).size.width - 130,
                            width: MediaQuery.of(context).size.width, fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: notificationModel!.description!=null? Dimensions.PADDING_SIZE_DEFAULT:0,),
                    notificationModel!.description!=null?Text(notificationModel!.description!,style: ubuntuRegular.copyWith(color: Theme.of(context).
                    textTheme.bodyText1!.color!.withOpacity(0.5) ,
                      fontSize: Dimensions.fontSizeDefault,
                    ),textAlign: TextAlign.justify,):SizedBox.shrink(),

                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
