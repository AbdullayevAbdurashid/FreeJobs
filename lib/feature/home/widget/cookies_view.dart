import 'package:demandium/core/core_export.dart';
import 'package:get/get.dart';

class CookiesView extends StatelessWidget {
  const CookiesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _padding = (MediaQuery.of(context).size.width - Dimensions.WEB_MAX_WIDTH) / 2;
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(Get.isDarkMode?1:0.8),
      ),
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
        horizontal: ResponsiveHelper.isDesktop(context) ? _padding : Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Padding(padding:  EdgeInsets.symmetric(horizontal: ResponsiveHelper.isDesktop(context)?0: Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,children: [
          Text('your_privacy_matters'.tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Colors.white),),
          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
          Padding(padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
            child: Text(Get.find<SplashController>().configModel.content?.cookiesText??"",
                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.white70,),
              maxLines: 10,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Row(mainAxisAlignment: MainAxisAlignment.end,children: [

            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(50,30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: (){
                Get.find<AuthController>().saveCookiesData(false);
              }, child:  Text(
              'no_thanks'.tr,
              style: ubuntuRegular.copyWith(color: Colors.white70,fontSize: Dimensions.fontSizeSmall),
            ),),


            SizedBox(width: ResponsiveHelper.isDesktop(context)?Dimensions.PADDING_SIZE_EXTRA_LARGE:Dimensions.PADDING_SIZE_LARGE,),

            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.zero,
                minimumSize: Size(80,35),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: (){
                Get.find<AuthController>().saveCookiesData(true);
              }, child:  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,vertical: 5),
                child: Center(
                  child: Text(
                  'yes_accept'.tr,
                    style: ubuntuRegular.copyWith(color: Colors.white70,fontSize: Dimensions.fontSizeSmall),
            ),
                ))),

          ],)

        ],),
      ),
    );
  }
}
