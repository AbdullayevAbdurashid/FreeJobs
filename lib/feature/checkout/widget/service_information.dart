import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class ServiceInformation extends StatelessWidget {
  const ServiceInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
        initState: (state) async {
          await Get.find<LocationController>().getAddressList();

        },
        builder: (controller) {
          if (controller.selectedAddress != null) {
            AddressModel? addressModel = controller.selectedAddress;

            return Column(
              children: [
                Text('service_address'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeDefault),
                  width: Get.width,
                  color: Theme.of(context).hoverColor,
                  child: Center(
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween, crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: Dimensions.paddingSizeSmall,),
                              if (addressModel!.contactPersonName != null && !addressModel.contactPersonName.toString().contains('null'))
                                Padding(
                                  padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
                                  child: Text(
                                    addressModel.contactPersonName.toString(),
                                    style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                  ),
                                ),
                              const SizedBox(height: 8.0,),
                              if (addressModel.contactPersonNumber != null && !addressModel.contactPersonNumber.toString().contains('null'))
                                Padding(
                                  padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
                                  child: Text(
                                    addressModel.contactPersonNumber??"",
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),
                                  ),
                                ),
                              if (addressModel.address != null)
                                const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_pin,
                                    size: 15,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  Expanded(
                                    child: Text(
                                      addressModel.address!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                              if(addressModel.country != null && addressModel.street != null && addressModel.city != null && addressModel.zipCode != null)
                                Padding(
                                  padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
                                  child: Text(addressModel.country??"",style: ubuntuRegular.copyWith(
                                      color: Theme.of(context).textTheme.bodyLarge!.color!,
                                      fontSize: Dimensions.fontSizeExtraSmall
                                  ),),
                                )
                              else
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                                  child: Text("some_information_is_missing".tr,style: ubuntuRegular.copyWith(
                                      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),
                                      fontSize: Dimensions.fontSizeExtraSmall),),
                                )
                            ],
                          ),
                        ),
                        Center(
                          child: InkWell(
                              onTap: () {
                                Get.toNamed(RouteHelper.getAddressRoute('checkout'));
                              },
                              child: Image.asset(Images.editButton,height: 20,width: 20,)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const SizedBox(height: Dimensions.paddingSizeLarge,),
                    Container(
                      color: Theme.of(context).hoverColor,
                      width: Get.width,

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('service_address'.tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
                            const SizedBox(height: Dimensions.paddingSizeDefault,),


                            DottedBorder(
                              dashPattern: const [6, 3],
                              strokeWidth: 1,
                              borderType: BorderType.RRect,
                              color: Theme.of(context).colorScheme.primary,
                              radius: const Radius.circular(10),
                              child: GestureDetector(
                                onTap: (){
                                  Get.toNamed(RouteHelper.getAddressRoute('checkout'));
                                },
                                child: SizedBox(
                                  width: 250,
                                  child: Center(
                                    child: Padding(padding: const EdgeInsets.all(8.0),
                                      child: Text("add_service_address".tr,
                                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault,),
              ],
            );
          }
        });
  }
}