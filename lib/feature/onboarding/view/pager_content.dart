import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class PagerContent extends StatelessWidget {
  const PagerContent({Key? key, required this.image, required this.text, required this.subText}) : super(key: key);

  final String image;
  final String text;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(),
        SizedBox( child: Image.asset(image)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Text(text,
                textAlign: TextAlign.center,
                style: ubuntuBold.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: Dimensions.fontSizeLarge),),
              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                child: Text(subText,
                  textAlign: TextAlign.center,
                  style: ubuntuRegular.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: Dimensions.fontSizeDefault),),
              ),
            ],
          )
        ),
        SizedBox(height: context.height*0.15),
      ],
    );
  }
}