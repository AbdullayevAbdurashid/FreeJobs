import 'package:demandium/core/core_export.dart';
import 'package:get/get.dart';

class ReferHintView extends StatelessWidget {
  final List<String> hintList;
  const ReferHintView({Key? key, required this.hintList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Dimensions.WEB_MAX_WIDTH,
        child: Container(

          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.2), width: 2),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20),
              ),
            ),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: Dimensions.PADDING_SIZE_EXTRA_SMALL , width: 30,
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

              Row(children: [
                Image.asset(Images.iMark, height: Dimensions.PADDING_SIZE_LARGE,),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),

                Text('how_you_it_works'.tr,
                  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).textTheme.bodyLarge!.color),
                ),

              ],),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

              Column(children: hintList.map((hint) => Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.05),
                          blurRadius: 6, offset: Offset(0, 3),
                        )]
                    ),
                    child: Text('${hintList.indexOf(hint) + 1}',style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge,)),
                  ),
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),

                  Flexible(
                    child: Text(hint, style: ubuntuRegular.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5),
                    ),
                    ),
                  ),
                ],
              ),).toList(),)
            ],),
          ),
        ),
      ),
    );
  }
}
