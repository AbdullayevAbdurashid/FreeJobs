import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:get/get.dart';
import '../../../core/core_export.dart';

class ServiceDetailsFaqSection extends StatelessWidget {
  const ServiceDetailsFaqSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceDetailsController>(
      builder: (serviceDetailsController){
        if(!serviceDetailsController.isLoading){
          List<Faqs>? faqs = serviceDetailsController.service!.faqs;
          return WebShadowWrap(
            child: Container(
              width: Dimensions.WEB_MAX_WIDTH,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: faqs!.length,
                padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
                itemBuilder: (context, index){


                  return CustomExpansionTile(
                    expandedAlignment: Alignment.centerLeft,
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                      child: Text(
                        faqs.elementAt(index).question!,
                        style: ubuntuRegular.copyWith(color:Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6)),
                      ),
                    ),

                    children: [
                      Container(
                        child: Padding(
                          padding:
                          EdgeInsets.only(left: 35,right: 35,bottom:10),
                          child: Text(
                          faqs.elementAt(index).answer!,
                              style: ubuntuRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6))),
                        ),
                      )
                    ],
                  );
                },),
            ),
          );
        }else{
         return SizedBox(child: Text("ok"),);
        }
      }
    );
  }
}