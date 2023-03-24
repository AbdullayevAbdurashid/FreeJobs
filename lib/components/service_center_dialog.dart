import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class ServiceCenterDialog extends StatefulWidget {
  final Service? service;
  final CartModel? cart;
  final int? cartIndex;
  final bool? isFromDetails;

  ServiceCenterDialog({
    required this.service,
    this.cart,
    this.cartIndex,
    this.isFromDetails = false});

  @override
  State<ServiceCenterDialog> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ServiceCenterDialog> {
  @override
  void initState() {
    Get.find<CartController>().setInitialCartList(widget.service!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(ResponsiveHelper.isDesktop(context))
    return  Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
      insetPadding: EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: pointerInterceptor(),
    );
    return pointerInterceptor();
  }

  pointerInterceptor(){
    return Padding(
      padding: EdgeInsets.only(top: ResponsiveHelper.isWeb()? 0 :Dimensions.CART_DIALOG_PADDING),
      child: PointerInterceptor(
        child: Container(
          width:ResponsiveHelper.isDesktop(context)? Dimensions.WEB_MAX_WIDTH/2:Dimensions.WEB_MAX_WIDTH,
          padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
          ),
          child:  GetBuilder<CartController>(builder: (cartControllerInit) {
              return GetBuilder<ServiceController>(builder: (serviceController) {
                if(widget.service!.variationsAppFormat!.zoneWiseVariations != null)
                  return Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: Dimensions.PADDING_SIZE_DEFAULT,
                          left:  Dimensions.PADDING_SIZE_DEFAULT,
                          top:  150,),
                        child: SingleChildScrollView(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: ResponsiveHelper.isDesktop(context) ? 0 : Dimensions.PADDING_SIZE_DEFAULT,
                                    bottom:  Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,
                                  ),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: cartControllerInit.initialCartList.length,
                                            itemBuilder: (context, index) {
                                              //variation item
                                              return Padding(
                                                padding:  EdgeInsets.symmetric(vertical:Dimensions.PADDING_SIZE_SMALL),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(vertical:Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context).hoverColor,
                                                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_DEFAULT))
                                                  ),
                                                  child: GetBuilder<CartController>(builder: (cartController){
                                                    return Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                cartControllerInit.initialCartList[index].variantKey.replaceAll('-', ' '), style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                                                maxLines: 2, overflow: TextOverflow.ellipsis,
                                                              ),
                                                              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                                                              Text(
                                                                  PriceConverter.convertPrice(double.parse(cartControllerInit.initialCartList[index].price.toString()),isShowLongPrice:true),
                                                                  style: ubuntuMedium.copyWith(color:  Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeSmall)),
                                                            ],
                                                          ),
                                                        ),
                                                        // Expanded(child: SizedBox()),
                                                        Expanded( flex:1,
                                                          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                                            cartControllerInit.initialCartList[index].quantity > 0 ? InkWell(
                                                              onTap: (){
                                                                cartController.updateQuantity(index, false);
                                                              },
                                                              child: Container(
                                                                height: 30, width: 30,
                                                                margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                                                                decoration: BoxDecoration(shape: BoxShape.circle, color:  Theme.of(context).colorScheme.secondary),
                                                                alignment: Alignment.center,
                                                                child: Icon(Icons.remove , size: 15, color:Theme.of(context).cardColor,),
                                                              ),
                                                            ) : SizedBox(),

                                                            cartControllerInit.initialCartList[index].quantity > 0 ? Text(
                                                              cartControllerInit.initialCartList[index].quantity.toString(),
                                                            ) : SizedBox(),

                                                            GestureDetector(
                                                              onTap: (){
                                                                cartController.updateQuantity(index, true);
                                                              },
                                                              child: Container(
                                                                height: 30, width: 30,
                                                                margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color:  Theme.of(context).colorScheme.secondary
                                                                ),
                                                                alignment: Alignment.center,
                                                                child: Icon(
                                                                  Icons.add ,
                                                                  size: 15,
                                                                  color:Theme.of(context).cardColor,
                                                                ),
                                                              ),
                                                            )
                                                          ]),
                                                        ),
                                                      ]),
                                                    );
                                                  },
                                                  ),
                                                ),
                                              );
                                            }),
                                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                                      ]),
                                ),
                              ]),
                        ),
                      ),
                      Positioned(child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: Dimensions.PADDING_SIZE_LARGE,),
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_DEFAULT)),
                                    child: CustomImage(
                                      image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${widget.service!.thumbnail}',
                                      height: Dimensions.IMAGE_SIZE_MEDIUM,
                                      width: Dimensions.IMAGE_SIZE_MEDIUM,
                                    ),
                                  ),
                                  Container(
                                    height: 40, width: 40, alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white70.withOpacity(0.6),
                                        boxShadow:Get.isDarkMode?null:[BoxShadow(
                                          color: Colors.grey[300]!, blurRadius: 2, spreadRadius: 1,
                                          )]
                                      ),
                                    child: InkWell(
                                      onTap: () => Get.back(),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.black54,

                                      )
                                    ),
                                  )
                                ]),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: Dimensions.PADDING_SIZE_RADIUS,),
                                  Text(
                                    widget.service!.name!,
                                    style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: Dimensions.PADDING_SIZE_MINI,),
                                  Text(
                                    "${widget.service!.variationsAppFormat!.zoneWiseVariations!.length} ${'options_available'.tr}",
                                    style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5)),
                                  ),
                                ]),
                          ],
                        ),
                      ),),
                      Positioned(
                        left:0,
                        right: 0,
                        bottom:  0,
                        child:  Container(
                          height: 70,
                          color: Theme.of(context).cardColor,
                        ),),
                      Positioned(
                        left: Dimensions.PADDING_SIZE_DEFAULT,
                        right: Dimensions.PADDING_SIZE_DEFAULT,
                        bottom:  Dimensions.PADDING_SIZE_DEFAULT,
                        child:  GetBuilder<CartController>(builder: (cartController) {
                        bool _addToCart = true;
                        return cartController.isLoading ? Center(child: CircularProgressIndicator()) : CustomButton(
                          height: ResponsiveHelper.isDesktop(context)? 50 : 45,
                            onPressed:cartControllerInit.isButton ? () async{
                              if(_addToCart) {
                                _addToCart = false;
                                if(Get.find<AuthController>().isLoggedIn()){
                                  await cartController.addMultipleCartToServer();
                                  await cartController.getCartListFromServer();
                                  // Get.back();

                                }else{
                                  cartController.addDataToCart();
                                }
                              }
                            }: null,
                            buttonText:(cartController.cartList.length > 0 && cartController.cartList.elementAt(0).serviceId == widget.service!.id) ? 'update_cart'.tr : 'add_to_cart'.tr);
                      }),)
                    ],
                  );
                return Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 20,
                      child: Container(
                        height: 40, width: 40, alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white70.withOpacity(0.6),
                            boxShadow:[BoxShadow(
                              color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]!, blurRadius: 2, spreadRadius: 1,
                            )]
                        ),
                        child: InkWell(
                            onTap: () => Get.back(),
                            child: Icon(Icons.close)),
                      ),
                    ),
                    Container(
                        height: Get.height / 7,
                        child: Center(child: Text('no_variation_is_available'.tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),)))
                  ],
                );
              });
            }
          ),
        ),
      ),
    );
  }
}
