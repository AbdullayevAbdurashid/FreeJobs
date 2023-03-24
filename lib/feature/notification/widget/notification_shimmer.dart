import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: Duration(seconds: 3),
      interval: Duration(seconds: 5),
      color: Colors.white,
      colorOpacity: 0,
      enabled: true,
      direction: ShimmerDirection.fromLTRB(),
      child: Container(
        height: context.height,
        width: context.width,
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:Theme.of(context).shadowColor,
                        ),
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                      Expanded(
                          child: Container(
                              width: 200,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).shadowColor,
                              )))
                    ],
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                  Container(
                      height: 25,
                      width: context.width*.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:Theme.of(context).shadowColor,
                      )
                  )
                ],
              ),
            );
          },
        ),
      ),

    );
  }
}