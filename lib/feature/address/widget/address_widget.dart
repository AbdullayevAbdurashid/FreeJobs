import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class AddressWidget extends StatelessWidget {
  final AddressModel address;
  final bool fromAddress;
  final bool fromCheckout;
  final Function()? onRemovePressed;
  final Function()? onEditPressed;
  final Function()? onTap;
  AddressWidget({required this.address, required this.fromAddress, this.onRemovePressed, this.onEditPressed,
    this.onTap, this.fromCheckout = false});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(
             top:  Dimensions.PADDING_SIZE_DEFAULT,
              bottom:  Dimensions.PADDING_SIZE_DEFAULT,
              left: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_DEFAULT : Dimensions.PADDING_SIZE_SMALL,
              right: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_DEFAULT : Dimensions.PADDING_SIZE_SMALL,
          ),
          decoration: BoxDecoration(
            // color: Theme.of(context).hoverColor,
            color:Get.isDarkMode ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).hoverColor,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            border: fromCheckout && Get.find<LocationController>().selectedAddress?.id == address.id
                ? Border.all(color: Theme.of(context).disabledColor, width: 1) : null,
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment:CrossAxisAlignment.center,children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      address.addressLabel == "others" ?  Icon(Icons.location_on,color: Theme.of(context).hintColor,size: 30,):
                      Image.asset(address.addressLabel == "home" ? Images.homeProfile : Images.office,
                        color: Colors.grey,scale: 1.5,),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                      Text("${address.addressLabel != null ? address.addressLabel.toString().toLowerCase() : 'others'}".tr, style: ubuntuMedium.copyWith(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                  Text(address.address!,
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                ]),
              ),
            ),
            Row(children: [
              fromAddress ?  IconButton(
                icon: Icon(Icons.edit, color: Colors.blue, size: 25),
                onPressed: onEditPressed,
              ) : SizedBox(),
              if(address.id != null)
                fromAddress ?
                IconButton(icon: Icon(Icons.delete, color: Colors.red, size:  25),
                    onPressed: onRemovePressed) : SizedBox(),
            ],)
          ]),
        ),
      ),
    );
  }
}