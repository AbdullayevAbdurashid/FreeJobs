import 'package:flutter/material.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';

class CustomDialog extends StatelessWidget {
  final String icon;
  final String? title;
  final String description;
  final Function()? onYesPressed;
  final Function()? onNoPressed;
  const CustomDialog({required this.icon,this.title,required this.description,this.onYesPressed, this.onNoPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      insetPadding:  const  EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(width: 500, child: Padding(
        padding:  EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Padding(
            padding:  EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Image.asset(icon, width: 50, height: 50),
          ),

          title != null ? Padding(
            padding:  EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
            child: Text(
              title!, textAlign: TextAlign.center,
              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.red),
            ),
          ) : const SizedBox(),

          Padding(
            padding:  EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Text(description, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge), textAlign: TextAlign.center),
          ),
          const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
            TextButton(
              onPressed:onNoPressed,
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize:  Size(Dimensions.PADDING_SIZE_LARGE, 40),
                padding:  EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL,horizontal: Dimensions.PADDING_SIZE_LARGE ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE)),
              ),
              child: Text(
                "No", textAlign: TextAlign.center,
                style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyText1!.color),
              ),
            ),

            const SizedBox(width: Dimensions.PADDING_SIZE_LARGE),

            TextButton(
              onPressed: onYesPressed,
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor, minimumSize:  Size(Dimensions.PADDING_SIZE_LARGE, 40),
                padding:  EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL,horizontal: Dimensions.PADDING_SIZE_LARGE ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE)),
              ),
              child: Text(
                "Yes", textAlign: TextAlign.center,
                style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyText1!.color),
              ),
            ),
          ]),
        ]),
      )),
    );
  }
}