import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {

  @override
  void initState() {
    Get.find<AuthController>().contactNumberController.clear();
    Get.find<AuthController>().initCountryCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar: CustomAppBar(title:'forgot_password'.tr),
      body: SafeArea(
        child: GetBuilder<AuthController>(
          builder: (authController){
            return FooterBaseView(
              isCenter: true,
              child: WebShadowWrap(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.isDesktop(context)?Dimensions.WEB_MAX_WIDTH/6:
                      ResponsiveHelper.isTab(context)? Dimensions.WEB_MAX_WIDTH/8:0
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Image.asset(
                        Images.forgotPass,
                        width: 100,
                        height: 100,),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
                      Row(
                        children: [
                          CodePickerWidget(
                            onChanged: (CountryCode countryCode) =>
                            authController.countryDialCode = countryCode.dialCode!,
                            initialSelection: authController.countryDialCode,
                            favorite: [authController.countryDialCode],
                            showDropDownButton: true,
                            padding: EdgeInsets.zero,
                            showFlagMain: true,
                            dialogBackgroundColor: Theme.of(context).cardColor,
                            barrierColor: Get.isDarkMode?Colors.black.withOpacity(0.4):null,
                            textStyle: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyText1!.color,
                            ),
                          ),
                          Expanded(
                            child: CustomTextField(
                                hintText: 'enter_phone_number'.tr,
                                controller: authController.contactNumberController,
                                inputType: TextInputType.phone,
                                countryDialCode: authController.countryDialCode,
                                onCountryChanged: (CountryCode countryCode) => authController.countryDialCode = countryCode.dialCode!,
                                onValidate: (String? value){
                                  return FormValidation().isValidLength(value!);
                                }
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      GetBuilder<AuthController>(builder: (authController) {
                          return !authController.isLoading! ? CustomButton(
                            buttonText: 'send_otp'.tr,
                            onPressed: () => _forgetPass(),
                          ) : Center(child: CircularProgressIndicator());
                        }),
                     SizedBox(height: Dimensions.PADDING_SIZE_LARGE*4),
                      ]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _forgetPass() async {

    if(Get.find<AuthController>().contactNumberController.value.text.isNotEmpty){
      Get.find<AuthController>().forgetPassword();
    }else{
      customSnackBar('enter_phone_number'.tr);
    }

  }
}

