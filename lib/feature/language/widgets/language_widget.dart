import 'package:demandium/components/ripple_button.dart';
import 'package:demandium/controller/localization_controller.dart';
import 'package:demandium/data/model/response/language_model.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;
  LanguageWidget({Key? key,
    required this.languageModel,
    required this.localizationController,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // int selectedIndex = localizationController.isLtr ? 0 : 1;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          margin: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          decoration: BoxDecoration(
              color:Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              boxShadow: cardShadow
          ),
          child: Stack(children: [
            Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  height: 65, width: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    border: Border.all(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.2), width: 1),
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    languageModel.imageUrl!, width: 36, height: 36,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                Text(languageModel.languageName!, style: ubuntuRegular),
              ]),
            ),
            localizationController.selectedIndex == index ? Positioned(
              top: 0, right: 0,
              child: Icon(Icons.check_circle, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6), size: 25),
            ) : SizedBox(),
          ]),
        ),
        Positioned.fill(child: RippleButton(onTap: () {
          localizationController.setSelectIndex(index);
        }))
      ],
    );
  }
}
