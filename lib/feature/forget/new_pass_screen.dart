import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';


class NewPassScreen extends StatefulWidget {
  final String phoneOrEmail;
  final String otp;
  const NewPassScreen({Key? key,required this.phoneOrEmail, required this.otp}) : super(key: key);

  @override
  State<NewPassScreen> createState() => _NewPassScreenState();
}

class _NewPassScreenState extends State<NewPassScreen> {
  final GlobalKey<FormState> newPassKey = GlobalKey<FormState>();


  @override
  void initState() {
    Get.find<AuthController>().newPasswordController.clear();
    Get.find<AuthController>().confirmNewPasswordController.clear();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find<AuthController>();
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar: CustomAppBar(title:'change_password'.tr, onBackPressed: (){
        Get.find<AuthController>().updateVerificationCode('');
        Get.back();
      },),
      body: SafeArea(child: FooterBaseView(
        isCenter: true,
        child: WebShadowWrap(
          child: Center(child: Form(
            key: newPassKey,
            autovalidateMode: ResponsiveHelper.isDesktop(context) ?AutovalidateMode.onUserInteraction:AutovalidateMode.disabled,
            child: Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.isDesktop(context)?Dimensions.WEB_MAX_WIDTH/6:
                    ResponsiveHelper.isTab(context)? Dimensions.WEB_MAX_WIDTH/8:Dimensions.PADDING_SIZE_LARGE
                ),
                child: Column(children: [
                  CustomTextField(
                      title: 'new_password'.tr,
                      hintText: '**************',
                      controller: controller.newPasswordController,
                      inputType: TextInputType.visiblePassword,
                      isPassword: true,
                      onValidate: (String? value){
                        return FormValidation().isValidPassword(value!);
                      }
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                  CustomTextField(
                    title: 'confirm_new_password'.tr,
                    hintText: '**************',
                    controller: controller.confirmNewPasswordController,
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.visiblePassword,
                    isPassword: true,
                    onValidate: (String? value){
                      return FormValidation().isValidPassword(value!);
                    },
                    onSubmit: (text) => GetPlatform.isWeb ? _resetPassword(controller.confirmNewPasswordController.text,controller.confirmNewPasswordController.text) : null,
                  ),
                  SizedBox(height: 30),

                  GetBuilder<UserController>(builder: (userController) {
                    return GetBuilder<AuthController>(builder: (authBuilder) {
                      if(authBuilder.isLoading! && userController.isLoading){
                        return  Center(child: CircularProgressIndicator());
                      }else{
                        return CustomButton(
                          buttonText: 'change_password'.tr,
                          onPressed: () {
                            if(isRedundentClick(DateTime.now())){
                              return;
                            }
                            else{
                              _resetPassword(
                                  controller.newPasswordController.value.text,
                                  controller.confirmNewPasswordController.value.text);
                            }
                          },
                        );
                      }
                    });
                  }),

                ]),
              ),


            ]),
          )),
        ),
      )),
    );
  }

  void _resetPassword(newPassword, confirmNewPassword) {
    if(newPassKey.currentState!.validate()){
      print("$newPassword $confirmNewPassword");
      if(newPassword != confirmNewPassword){
        customSnackBar('confirm_password_not_matched'.tr);
      }else{
        Get.find<AuthController>().resetPassword(widget.phoneOrEmail);
      }
    }
  }
}




