import 'package:flutter/material.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class InboxShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      itemBuilder: (context, index) {
        return Shimmer(
          duration: Duration(seconds: 3),
          interval: Duration(seconds: 5),
          color: Theme.of(context).backgroundColor,
          colorOpacity: 0,
          enabled: true,
          child: Padding(
            padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
            child: Row(children: [
              CircleAvatar(backgroundColor: Theme.of(context).shadowColor,child: Icon(Icons.person), radius: 20),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                  child: Column(children: [
                    Container(height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                          color: Theme.of(context).shadowColor),
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}