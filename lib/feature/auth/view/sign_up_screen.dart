import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/feature/auth/widgets/social_login_widget.dart';
import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:demandium/core/core_export.dart';

class SignUpScreen extends StatefulWidget {
   SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final GlobalKey<FormState> customerSignUpKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.find<AuthController>().firstNameController.clear();
    Get.find<AuthController>().lastNameController.clear();
    Get.find<AuthController>().emailController.clear();
    Get.find<AuthController>().phoneController.clear();
    Get.find<AuthController>().passwordController.clear();
    Get.find<AuthController>().confirmPasswordController.clear();
    Get.find<AuthController>().initCountryCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
        appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
      body: GetBuilder<AuthController>(
        init: Get.find<AuthController>(),
        builder: (authController){
          return authController.isLoading! ?
          Center(child: CircularProgressIndicator(),) :
          FooterBaseView(
            child: WebShadowWrap(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                child: Column(
                  children: [
                    Form(
                      key: customerSignUpKey,
                      autovalidateMode: ResponsiveHelper.isDesktop(context) ?AutovalidateMode.onUserInteraction:AutovalidateMode.disabled,
                      child: Column(
                        children: [
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE),
                          Image.asset(
                            Images.logo,
                            width: Dimensions.LOGO_SIZE,
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE),
                          if(ResponsiveHelper.isMobile(context))
                            _firstList(authController),
                          if(ResponsiveHelper.isMobile(context))
                            _secondList(authController),
                         if(!ResponsiveHelper.isMobile(context))
                         Row(children: [
                            Expanded(child: _firstList(authController),),
                            SizedBox(width: Dimensions.PADDING_SIZE_LARGE,),
                            Expanded(
                              child: _secondList(authController),
                            ),
                          ]),
                        ]),
                      ),
                    ConditionCheckBox(),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    !authController.isLoading! ? CustomButton(
                      buttonText: 'sign_up'.tr,
                      onPressed: authController.acceptTerms
                          ? () => _register(authController)
                          : null,
                    )
                        : Center(child: CircularProgressIndicator()),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    Get.find<SplashController>().configModel.content!.googleSocialLogin.toString() == '1' ||
                        Get.find<SplashController>().configModel.content!.facebookSocialLogin.toString() == '1' ?
                    SocialLoginWidget():SizedBox(),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${'already_have_an_account'.tr} ',
                          style: ubuntuRegular.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
                          },
                          child: Text('sign_in_here'.tr, style: ubuntuRegular.copyWith(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: Dimensions.fontSizeDefault,
                          )),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('continue_as'.tr, style: ubuntuMedium.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6)),),
                        InkWell(
                          onTap: () {
                            Get.offNamed(RouteHelper.getInitialRoute());
                          },
                          child: Text('guest'.tr, style: ubuntuMedium.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: Theme.of(context).colorScheme.primary),),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,),


                  ],
                ),
              ),
              ),
          );
        },
      )
    );
  }



  Widget _firstList(AuthController authController) {
    return Column(children: [
      CustomTextField(
        title: 'first_name'.tr,
        hintText: 'enter_your_first_name'.tr,
        controller: authController.firstNameController,
        isAutoFocus: false,
        focusNode: _firstNameFocus,
        nextFocus: _lastNameFocus,
        inputType: TextInputType.name,
        capitalization: TextCapitalization.words,
        onValidate: (String? value){
          return FormValidation().isValidFirstName(value!);
        },

      ),
      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

      CustomTextField(
        title: 'last_name'.tr,
        hintText: 'enter_your_last_name'.tr,
        controller: authController.lastNameController,
        focusNode: _lastNameFocus,
        nextFocus: _emailFocus,
        inputType: TextInputType.name,
        capitalization: TextCapitalization.words,
        onValidate: (String? value){
          return FormValidation().isValidLastName(value!);
        },
      ),
      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

      CustomTextField(
        title: 'email_address'.tr,
        hintText: 'enter_email_address'.tr,
        controller: authController.emailController,
        focusNode: _emailFocus,
        nextFocus: _phoneFocus,
        inputType: TextInputType.emailAddress,
        onValidate: (String? value){
          return GetUtils.isEmail(value!) ? null:'enter_valid_email_address'.tr;
        },
      ),
      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
    ],);
  }

  Widget _secondList(AuthController authController) {
    return Column(children: [
      Row(
        children: [
          CodePickerWidget(

            onChanged: (CountryCode countryCode) =>
            authController.countryDialCodeForSignup = countryCode.dialCode!,
            initialSelection: authController.countryDialCodeForSignup,
            favorite: [authController.countryDialCodeForSignup],
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
              controller: authController.phoneController,
              focusNode: _phoneFocus,
              nextFocus: _passwordFocus,
              inputType: TextInputType.phone,
            ),
          ),
        ],
      ),
      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

      CustomTextField(
        title: 'password'.tr,
        hintText: '****************'.tr,
        controller: authController.passwordController,
        focusNode: _passwordFocus,
        nextFocus: _confirmPasswordFocus,
        inputType: TextInputType.visiblePassword,
        onValidate: (String? value) {
          return FormValidation().isValidPassword(value!);
        },
        isPassword: true,
      ),
      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

      CustomTextField(
        title: 'confirm_password'.tr,
        hintText: '****************'.tr,
        controller: authController.confirmPasswordController,
        focusNode: _confirmPasswordFocus,
        inputAction: TextInputAction.done,
        inputType: TextInputType.visiblePassword,
        isPassword: true,
        onValidate: (String? value) {
          return FormValidation().isValidPassword(value!);
        },
      ),
      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
    ],);
  }

  void _register(AuthController authController) async {
    if(customerSignUpKey.currentState!.validate()) {
      if(authController.passwordController.value.text != authController.confirmPasswordController.value.text){
        customSnackBar('password_and_confirm_does_not_match'.tr);
      }else{
        authController.registration();
      }
    }
  }
}

