import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class CustomerInfoCard extends GetView<UserController> {
  final String name;
  final String phone;
  final String image;

  CustomerInfoCard( {Key? key, required this.name, required this.phone, required this.image}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
      child: Container(
        width:double.infinity,
        child: Column(
          children: [
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_DEFAULT),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE)),
              child: Container(
                width: Dimensions.IMAGE_SIZE,
                height: Dimensions.IMAGE_SIZE,
                child: CustomImage(image:"${Get.find<SplashController>().configModel.content!.imageBaseUrl}/serviceman/profile/$image"),
              ),
            ),
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Text("$name",style:ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault,)),
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Text("$phone",style:ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,)),
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_DEFAULT),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
          color: Theme.of(context).hoverColor,
        ),
      ),
    );
  }
}