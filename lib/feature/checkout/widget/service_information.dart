import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class ServiceInformation extends StatelessWidget {
  ServiceInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
        initState: (state) async {
        await Get.find<LocationController>().getAddressList();

         },
        builder: (controller) {
      if (controller.selectedAddress != null) {
        AddressModel? addressModel = controller.selectedAddress;
        print("selected_address:${controller.selectedAddress!.toJson()}");

        return Column(
          children: [
            Text('service_information'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
            const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
            Container(
              padding: EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_DEFAULT),
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
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                          if (addressModel!.contactPersonName != null && !addressModel.contactPersonName.toString().contains('null'))
                            Padding(
                              padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: Text(
                                addressModel.contactPersonName.toString(),
                                style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                              ),
                            ),
                          SizedBox(height: 8.0,),
                          if (addressModel.contactPersonNumber != null && !addressModel.contactPersonNumber.toString().contains('null'))
                            Padding(
                              padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: Text(
                                addressModel.contactPersonNumber,
                                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),
                              ),
                            ),
                          if (addressModel.address != null)
                            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
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
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                          if(addressModel.country != null && addressModel.street != null && addressModel.city != null && addressModel.zipCode != null)
                            Padding(
                              padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: Text(addressModel.country,style: ubuntuRegular.copyWith(
                                  color: Theme.of(context).textTheme.bodyLarge!.color!,
                                  fontSize: Dimensions.fontSizeExtraSmall
                              ),),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
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
              height: Dimensions.PADDING_SIZE_DEFAULT,
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
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween, crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text('service_address'.tr),
                      InkWell(
                          onTap: (){
                            Get.toNamed(RouteHelper.getAddressRoute('checkout'));
                          },
                          child: Image.asset(Images.editButton, width: 20.0,height: 20.0,)),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
                Container(
                  color: Theme.of(context).hoverColor,
                  width: Get.width,

                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('service_address'.tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
                        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                        Text('select_your_address'.tr),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
          ],
        );
      }
    });
  }
}
