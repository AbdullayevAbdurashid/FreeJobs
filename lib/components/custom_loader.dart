import 'package:demandium/core/core_export.dart';

class CustomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary,)));
  }
}
