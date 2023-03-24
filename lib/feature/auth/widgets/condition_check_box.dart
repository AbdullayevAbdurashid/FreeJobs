import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class ConditionCheckBox extends StatelessWidget {
  ConditionCheckBox();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController){
        return Row(
            mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            width: 24.0,
            child: Checkbox(
              activeColor: Theme.of(context).colorScheme.primary,
              value:  Get.find<AuthController>().acceptTerms,
              onChanged: (bool? isChecked) =>  Get.find<AuthController>().toggleTerms(),
            ),
          ),
          Text('i_agree_with_the'.tr, style: ubuntuRegular.copyWith(
            fontSize: Dimensions.fontSizeSmall,
            color: Theme.of(context).colorScheme.primary,
          )),
          InkWell(
            onTap: () => Get.toNamed(RouteHelper.getHtmlRoute('terms-and-condition')),
            child: Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: Text('terms_and_conditions'.tr, style: ubuntuBold.copyWith(
                fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).colorScheme.primary,
                decoration: TextDecoration.underline,
              )),
            ),
          ),
        ]);
      }
    );
  }
}
