import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ChattingShimmer extends StatelessWidget {
  const ChattingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Shimmer(
          duration: Duration(seconds: 3),
          interval: Duration(seconds: 5),
          color: Theme.of(context).backgroundColor,
          colorOpacity: 0,
          enabled: true,
          direction: ShimmerDirection.fromLTRB(),
          child: Container(
            height:Get.height*0.80,
            child: SingleChildScrollView(
                child: Column(children:[
                  Container(margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                      height: 65,
                      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                        Container(height: 50, width: 50,
                            decoration: BoxDecoration(color: Theme.of(context).shadowColor, borderRadius: BorderRadius.all(Radius.circular(100)))
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                        Container(height: 40, width: 200,
                            decoration: BoxDecoration(
                                color: Theme.of(context).shadowColor,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.RADIUS_DEFAULT),topLeft: Radius.circular(Dimensions.RADIUS_DEFAULT), bottomRight: Radius.circular(Dimensions.RADIUS_DEFAULT))
                            )),
                      ])
                  ),


                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                      height: 50,
                      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Container(height: 40, width: 200,
                            decoration: BoxDecoration(
                                color: Theme.of(context).shadowColor,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.RADIUS_DEFAULT),topLeft: Radius.circular(Dimensions.RADIUS_DEFAULT), bottomLeft: Radius.circular(Dimensions.RADIUS_DEFAULT))
                            )),
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                        Container(
                            height: 50, width: 50,
                            decoration: BoxDecoration(color: Theme.of(context).shadowColor, borderRadius: BorderRadius.all(Radius.circular(100)))
                        ),
                      ])
                  ),


                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                      child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Container(
                            height: 50, width: 50,
                            decoration: BoxDecoration(color: Theme.of(context).shadowColor,
                                borderRadius: BorderRadius.all(Radius.circular(100)))
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                        Container(
                            height: 80,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Theme.of(context).shadowColor,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.RADIUS_DEFAULT),topLeft: Radius.circular(Dimensions.RADIUS_DEFAULT), bottomRight: Radius.circular(Dimensions.RADIUS_DEFAULT))
                            )),
                      ])
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                      child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Container(
                            height: 50, width: 50,
                            decoration: BoxDecoration(color: Theme.of(context).shadowColor,
                                borderRadius: BorderRadius.all(Radius.circular(100)))
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                        Container(height: 120, width: 120,
                            decoration: BoxDecoration(
                              color: Theme.of(context).shadowColor,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.RADIUS_DEFAULT),topLeft: Radius.circular(Dimensions.RADIUS_DEFAULT), bottomRight: Radius.circular(Dimensions.RADIUS_DEFAULT),bottomLeft: Radius.circular(Dimensions.RADIUS_DEFAULT)),
                            )),
                      ])
                  ),

                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                      height: 65,
                      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Container(
                            height: 40,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Theme.of(context).shadowColor,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.RADIUS_DEFAULT),topLeft: Radius.circular(Dimensions.RADIUS_DEFAULT), bottomLeft: Radius.circular(Dimensions.RADIUS_DEFAULT))
                            )),
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                        Container(
                            height: 50, width: 50,
                            decoration: BoxDecoration(color: Theme.of(context).shadowColor,
                                borderRadius: BorderRadius.all(Radius.circular(100)))
                        ),
                      ])
                  ),

                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                      child: Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Container(height: 80, width: 250,
                            decoration: BoxDecoration(
                                color: Theme.of(context).shadowColor,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.RADIUS_DEFAULT),topLeft: Radius.circular(Dimensions.RADIUS_DEFAULT), bottomLeft: Radius.circular(Dimensions.RADIUS_DEFAULT))
                            )),
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                        Container(
                            height: 50, width: 50,
                            decoration: BoxDecoration(color: Theme.of(context).shadowColor,  borderRadius: BorderRadius.all(Radius.circular(100)))
                        ),
                      ])
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                      height: 50,
                      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                        Container(
                            height: 50, width: 50,
                            decoration: BoxDecoration(color: Theme.of(context).shadowColor,  borderRadius: BorderRadius.all(Radius.circular(100)))
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                        Container(
                            height: 40,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Theme.of(context).shadowColor,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.RADIUS_DEFAULT),topLeft: Radius.circular(Dimensions.RADIUS_DEFAULT), bottomRight: Radius.circular(Dimensions.RADIUS_DEFAULT))
                            )),
                      ])
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                      height: 50,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                height: 50, width: 50,
                                decoration: BoxDecoration(color: Theme.of(context).shadowColor,  borderRadius: BorderRadius.all(Radius.circular(100)))
                            ),
                            SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                            Container(
                                height: 40,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).shadowColor,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.RADIUS_DEFAULT),topLeft: Radius.circular(Dimensions.RADIUS_DEFAULT), bottomRight: Radius.circular(Dimensions.RADIUS_DEFAULT))
                                )),
                          ])
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                      // height: 65,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).shadowColor,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.RADIUS_DEFAULT),topLeft: Radius.circular(Dimensions.RADIUS_DEFAULT), bottomRight: Radius.circular(Dimensions.RADIUS_DEFAULT),bottomLeft: Radius.circular(Dimensions.RADIUS_DEFAULT)),
                                )),
                            SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                            Container(
                                height: 50, width: 50,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).shadowColor, borderRadius: BorderRadius.all(Radius.circular(100)))
                            ),
                          ])
                  ),
                ]
                )),
          )
      ),
      floatingActionButton: Container(
        height: 50,
        width: Get.width*.92,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
            color: Theme.of(context).shadowColor
        ),
      ),
    );
  }
}