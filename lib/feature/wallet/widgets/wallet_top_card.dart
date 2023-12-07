import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/wallet/controller/wallet_controller.dart';
import 'package:demandium/feature/wallet/widgets/wallet_uses_manual_dialog.dart';
import 'package:get/get.dart';

class WalletTopCard extends StatelessWidget {
  const WalletTopCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(builder: (walletController){

      double walletBalance = walletController.walletTransactionModel?.content?.walletBalance??0;

      return Container(height: Dimensions.walletTopCardHeight,
        margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight,
            colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withOpacity(0.9)],
          ),
        ),

        child: Stack(alignment: AlignmentDirectional.bottomEnd,children: [
          Image.asset(Images.walletBackground,height: Dimensions.walletTopCardHeight*0.6,),
          Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(Images.myWallet,width:30),
                  const SizedBox(),
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
                          return const WalletUsesManualDialog();
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
              Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: Text(PriceConverter.convertPrice(walletBalance),style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeForReview,color: Colors.white),),
                ),
              ),
              Text('your_balance'.tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Colors.white.withOpacity(0.8))),
              const Row()

            ]),
          )
        ]),
      );
    });
  }
}
