import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class WebLandingShimmer extends StatelessWidget {
  const WebLandingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FooterBaseView(
      child: SizedBox(
        width: Dimensions.WEB_MAX_WIDTH,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
              //web landing search shimmer
              Stack(
                children: [
                  Shimmer(
                    duration: Duration(seconds: 2),
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        color: Colors.grey[Get.isDarkMode ? 700 : 300],
                        boxShadow:  cardShadow,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT).copyWith(left: 300),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[400],
                                          border: Border.all(color: Colors.white,width: 2),
                                        ),
                                        height: 200,
                                        width: 370,
                                    ),
                                    Container(
                                        width: 485,
                                        height: 200,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[400],
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(12.0)),
                                            border: Border.all(color: Colors.white,width: 2),
                                        ),
                                        ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(flex: 2, child: SizedBox()),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[400],
                                            border: Border.all(color: Colors.white,width: 2),
                                        ),

                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        height: 200,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[400],
                                              border: Border.all(color: Colors.white,width: 2),
                                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(12.0))
                                        ),

                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 30.0,
                    bottom: 50.0,
                    top: 100.0,
                    child: Shimmer(
                      duration: Duration(seconds: 2),
                      child: Container(
                        height: 260,
                        width: 750,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                border: Border.all(color: Colors.white,width: 2),
                              ),
                              height: 15,
                              width: 500,
                            ),
                            SizedBox(height: 20.0,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                border: Border.all(color: Colors.white,width: 2),
                              ),
                              height: 15,
                              width: 500,
                            ),
                            SizedBox(height: 40.0,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                border: Border.all(color: Colors.white,width: 2),
                              ),
                              height: 60,
                              width: 600,
                            ),
                          ],
                        ),

                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,),
              //web mid shimmer
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  color: Colors.grey[Get.isDarkMode ? 700 : 300],
                  boxShadow:  cardShadow,
                ),
                child: Shimmer(
                  duration: Duration(seconds: 2),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                          height: 60,
                          width: 600,
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
                        Container(
                          height: 400,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 500,
                                width: 400,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                              ),
                              Container(
                                height: 400,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                          ),
                                          height: 15,
                                          width: 500,
                                        ),
                                        SizedBox(height: 20,),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                          ),
                                          height: 50,
                                          width: 500,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                          ),
                                          height: 15,
                                          width: 500,
                                        ),
                                        SizedBox(height: 20,),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                          ),
                                          height: 50,
                                          width: 500,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                          ),
                                          height: 15,
                                          width: 500,
                                        ),
                                        SizedBox(height: 20,),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                          ),
                                          height: 50,
                                          width: 500,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //testimonial section
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  color: Colors.grey[Get.isDarkMode ? 700 : 300],
                  boxShadow:  cardShadow,
                ),
                child: Shimmer(
                  duration: Duration(seconds: 2),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(height: 10,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              ),
                              height: 60,
                              width: 600,
                            ),
                            SizedBox(height: 10,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              ),
                              height: 20,
                              width: 600,
                            ),
                            SizedBox(height: 10,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              ),
                              height: 20,
                              width: 100,
                            ),
                          ],
                        ),
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
