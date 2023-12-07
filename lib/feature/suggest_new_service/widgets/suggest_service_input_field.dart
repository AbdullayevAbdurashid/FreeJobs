import 'package:demandium/components/custom_text_form_field.dart';
import 'package:demandium/components/text_field_title.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/suggest_new_service/controller/suggest_service_controller.dart';
import 'package:get/get.dart';

class SuggestServiceInputField extends StatefulWidget {
  const SuggestServiceInputField({Key? key}) : super(key: key);

  @override
  State<SuggestServiceInputField> createState() => _SuggestServiceInputFieldState();
}

class _SuggestServiceInputFieldState extends State<SuggestServiceInputField> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SuggestServiceController>(builder: (suggestedServiceController){
      return Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

        TextFieldTitle(title: "service_category".tr,requiredMark: true),
        Container(width: Get.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              border: Border.all(color: Theme.of(context).disabledColor,width: 1)
          ),
          child: DropdownButtonHideUnderline(

            child: DropdownButton(

                dropdownColor: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(5), elevation: 2,

                hint: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                  child: Text(suggestedServiceController.selectedCategoryName==''?
                  "select_category".tr:suggestedServiceController.selectedCategoryName,
                    style: ubuntuRegular.copyWith(
                        color: suggestedServiceController.selectedCategoryName==''?
                        Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6):
                        Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)
                    ),
                  ),
                ),
                icon: const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                  child: Icon(Icons.keyboard_arrow_down),
                ),
                items:suggestedServiceController.serviceCategoryList.map((CategoryModel items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Row(
                      children: [
                        Text(items.name??"",
                          style: ubuntuRegular.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (CategoryModel? newValue) => suggestedServiceController.setIdentityType(newValue?.id??"")
            ),
          ),
        ),

        TextFieldTitle(title:"service_name".tr),

        CustomTextFormField(
          hintText: 'service_name'.tr,
          controller: suggestedServiceController.serviceNameController,
          inputType: TextInputType.text,
          inputAction: TextInputAction.next,
        ),

        TextFieldTitle(title:"provide_some_details".tr),
        CustomTextFormField(
          hintText: "write_something".tr,
          inputType: TextInputType.text,
          maxLines: 3,
          controller: suggestedServiceController.serviceDetailsController,
        ),
      ],
      );
    });
  }
}
