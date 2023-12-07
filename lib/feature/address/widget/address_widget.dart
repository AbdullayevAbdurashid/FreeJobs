import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class AddressWidget extends StatelessWidget {
  final AddressModel address;
  final bool fromAddress;
  final bool fromCheckout;
  final Function()? onRemovePressed;
  final Function()? onEditPressed;
  final Function()? onTap;
  final String? selectedUserAddress;
  const AddressWidget({super.key, required this.address, required this.fromAddress, this.onRemovePressed, this.onEditPressed,
    this.onTap, this.fromCheckout = false, this.selectedUserAddress});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(
            top:  Dimensions.paddingSizeDefault,
            bottom:  Dimensions.paddingSizeDefault,
            left: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeDefault : Dimensions.paddingSizeSmall,
            right: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeDefault : Dimensions.paddingSizeSmall,
          ),
          decoration: BoxDecoration(
            // color: Theme.of(context).hoverColor,
            color:Get.isDarkMode ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).hoverColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            border:  null,
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment:CrossAxisAlignment.center,children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      address.addressLabel == "others" ?  Icon(Icons.location_on,color: Theme.of(context).hintColor,size: 30,):
                      Image.asset(address.addressLabel == "home" ? Images.homeProfile : Images.office,
                        color: Colors.grey,scale: 1.5,),
                      const SizedBox(width: Dimensions.paddingSizeSmall,),
                      Text((address.addressLabel != null ? address.addressLabel.toString().toLowerCase() : 'others').tr, style: ubuntuMedium.copyWith(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                  Text(address.address!,
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                ]),
              ),
            ),
            Row(children: [
              fromAddress ?  IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue, size: 25),
                onPressed: onEditPressed,
              ) : const SizedBox(),

              if(address.id != null)
                fromAddress ?
                IconButton(icon: const Icon(Icons.delete, color: Colors.red, size:  25),
                    onPressed: onRemovePressed) : const SizedBox(),
            ],)
          ]),
        ),
      ),
    );
  }
}




// if(address.id!=null && fromAddress)
// ( Get.find<LocationController>().getUserAddress()?.address == address.address
// && Get.find<LocationController>().getUserAddress()?.longitude == address.longitude
// && Get.find<LocationController>().getUserAddress()?.latitude == address.latitude
// && Get.find<LocationController>().getUserAddress()?.id == address.id
// )? const SizedBox():
// IconButton(icon: const Icon(Icons.delete, color: Colors.red, size:  25),
// onPressed: onRemovePressed) ,