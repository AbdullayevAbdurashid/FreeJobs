import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class NotAvailableWidget extends StatelessWidget {
  final bool? online;
  final double? fontSize;
  final BorderRadius? borderRadius;
  NotAvailableWidget({required this.online, this.fontSize = 8, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0, bottom: 0, right: 0,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: online! ? Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6) : Theme.of(context).disabledColor,
        ),
        child: Text(
          online! ? 'online'.tr : 'offline'.tr, textAlign: TextAlign.center,
          style: ubuntuRegular.copyWith(
            color: Colors.white,
            fontSize: (fontSize == 8 && ResponsiveHelper.isDesktop(context)) ? 12 : fontSize,
          ),
        ),
      ),
    );
  }
}
