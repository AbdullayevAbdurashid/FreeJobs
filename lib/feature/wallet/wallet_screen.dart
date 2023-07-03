import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/wallet/controller/wallet_controller.dart';
import 'package:demandium/feature/wallet/widgets/wallet_top_card.dart';
import 'package:demandium/feature/wallet/widgets/wallet_list_view.dart';
import 'package:demandium/feature/wallet/widgets/wallet_uses_manual_dialog.dart';
import 'package:get/get.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      appBar: CustomAppBar(title: 'my_wallet'.tr,actionWidget: InkWell(
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,0, 15, 0),
          child: Image.asset(Images.info,width: 20,height: 20,color: Colors.white,),
        ),
      ),),
      body: GetBuilder<WalletController>(
        initState: (_){
          Get.find<WalletController>().getWalletTransactionData(1);
        },
        builder: (walletController){
          return FooterBaseView(
            isScrollView: true,
            child:walletController.walletTransactionModel!=null ?const SizedBox(
              width: Dimensions.webMaxWidth,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                WalletTopCard(),

                WalletListView(),

              ]),
            ):Center(
              child: SizedBox(height: ResponsiveHelper.isDesktop(context)?100: Get.height*0.85,
                  child: const Center(child: CircularProgressIndicator())),
            ),
          );
      }),
    );
  }
}
