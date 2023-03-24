import 'package:demandium/components/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class NotLoggedInScreen extends StatelessWidget {
  final String fromPage;
  const NotLoggedInScreen({Key? key, required this.fromPage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,

      appBar: CustomAppBar(title: fromPage,),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(Images.guest,
              width: MediaQuery.of(context).size.height*0.25,
              height: MediaQuery.of(context).size.height*0.25,
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.01),
            Text('sorry'.tr,
              style: ubuntuBold.copyWith(fontSize: MediaQuery.of(context).size.height*0.023, color: Theme.of(context).colorScheme.primary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.01),
            Text('you_are_not_logged_in'.tr,
              style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.height*0.0175, color: Theme.of(context).disabledColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.04),
            SizedBox(width: 200,
              child: CustomButton(buttonText: 'login_to_continue'.tr, height: 40, onPressed: () {
                Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
              }),
            ),

          ]),
        ),
      ),
    );
  }
}
