import 'package:demandium/components/custom_image.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'web_mid_section_content_item.dart';

class WebMidSection extends StatelessWidget {
  final textContent;
  final imageContent;
  final baseUrl;
  WebMidSection({Key? key, required this.textContent,required this.imageContent, required this.baseUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.WEB_MAX_WIDTH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(textContent['web_mid_title'] != null && textContent['web_mid_title'] != '')
          Text(
            textContent['web_mid_title'],
            style: ubuntuBold.copyWith(fontSize: 26,),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(imageContent["feature_section_image"] != null)
                CustomImage(
                  height: Dimensions.FEATURE_SECTION_IMAGE_SIZE,
                  width: Dimensions.FEATURE_SECTION_IMAGE_SIZE,
                  image:"$baseUrl/landing-page/web/${imageContent['feature_section_image']}",
                  fit: BoxFit.fitHeight,
                ),
              SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
              Expanded(
                child: Column(
                  children: [
                    if(textContent['mid_sub_title_1'] != null && textContent['mid_sub_description_1'] != null)
                    WebMidSectionContentItem(title:textContent['mid_sub_title_1'],subTitle:textContent['mid_sub_description_1']),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                    if(textContent['mid_sub_title_2'] != null && textContent['mid_sub_description_2'] != null)
                      WebMidSectionContentItem(title:textContent['mid_sub_title_2'],subTitle:textContent['mid_sub_description_2']),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                    if(textContent['mid_sub_title_3'] != null && textContent['mid_sub_description_3'] != null)
                      WebMidSectionContentItem(title:textContent['mid_sub_title_3'],subTitle:textContent['mid_sub_description_3']),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
