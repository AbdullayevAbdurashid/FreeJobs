import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/loyalty_point/controller/loyalty_point_controller.dart';
import 'package:demandium/feature/loyalty_point/widgets/loyalty_uses_manual_dialog.dart';
import 'package:get/get.dart';

class LoyaltyPointTopCard extends StatelessWidget {
  const LoyaltyPointTopCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoyaltyPointController>(builder: (loyaltyPointController){
      return Container(height: Dimensions.WALLET_TOP_CARD_HEIGHT,
        margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
          gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight,
            colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withOpacity(0.9)],
          ),
        ),

        child: Stack(alignment: AlignmentDirectional.bottomEnd,children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: Image.asset(Images.loyaltyPointBackground,height: Dimensions.WALLET_TOP_CARD_HEIGHT*0.6,),
          ),
          Padding(padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(Images.myPoint,width:30),
                  SizedBox(),
                  if(ResponsiveHelper.isDesktop(context))
                  InkWell(
                    onTap: (){
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        transitionDuration: const Duration(milliseconds: 500),
                        barrierLabel: MaterialLocalizations.of(context).dialogLabel,
                        barrierColor: Colors.black.withOpacity(0.5),
                        pageBuilder: (context, _, __) {
                          return const LoyaltyPointUsesManualDialog();
                        },
                        transitionBuilder: (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOut,
                            ).drive(Tween<Offset>(
                              begin: const Offset(0, -1.0),
                              end: Offset.zero,
                            )),
                            child: child,
                          );
                        },
                      );
                    },
                    child: Image.asset(Images.info,width: 20,height: 20,color: Colors.white,),
                  )
                ],
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                    child: Text(loyaltyPointController.loyaltyPointModel?.content?.loyaltyPoint?.toStringAsFixed(2)??"0",style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeForReview,color: Colors.white),)),
              ),
              Text('your_loyalty_point'.tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Colors.white.withOpacity(0.8))),
              Row()

            ]),
          )
        ]),
      );
    });
  }
}
