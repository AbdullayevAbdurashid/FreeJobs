import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class LocationSearchDialog extends StatelessWidget {
  final GoogleMapController? mapController;
  LocationSearchDialog({required this.mapController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Container(
      margin: EdgeInsets.only(top: ResponsiveHelper.isDesktop(context) ? 120 : 0),
      padding: EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_SMALL),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
        child: SizedBox(
          width: Dimensions.WEB_MAX_WIDTH-30, child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: _controller,
            textInputAction: TextInputAction.search,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(
              hintText: 'search_location'.tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(style: BorderStyle.none, width: 0),
              ),
              hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).disabledColor,
              ),
              filled: true, fillColor: Theme.of(context).cardColor,
            ),
            style: Theme.of(context).textTheme.headline2!.copyWith(
              color: Theme.of(context).textTheme.bodyText1!.color, fontSize: Dimensions.fontSizeLarge,
            ),
          ),
          hideSuggestionsOnKeyboardHide: true,
          suggestionsCallback: (pattern) async {
            return await Get.find<LocationController>().searchLocation(context, pattern);
          },
          itemBuilder: (context, PredictionModel suggestion) {
            return Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Row(children: [
                Icon(Icons.location_on),
                Expanded(
                  child: Text(suggestion.description!, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Theme.of(context).textTheme.bodyText1!.color, fontSize: Dimensions.fontSizeLarge,
                  )),
                ),
              ]),
            );
          },
          onSuggestionSelected: (PredictionModel suggestion) {
            Get.find<LocationController>().setLocation(suggestion.placeId!, suggestion.description!, mapController!);
            Get.back();
          },
          noItemsFoundBuilder: (value) {
            return SizedBox();
          },
        ),),
      ),
    );
  }
}
