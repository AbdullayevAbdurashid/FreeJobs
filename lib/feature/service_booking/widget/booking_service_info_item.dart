import 'package:demandium/core/core_export.dart';

class BookingServiceInfoItem extends StatelessWidget {
  final BookingContentDetailsItem bookingContentDetailsItem;
  const BookingServiceInfoItem({Key? key,required this.bookingContentDetailsItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if(bookingContentDetailsItem.service != null)
              Container(
                width: 215,
                child: Text("${bookingContentDetailsItem.service!.name!}",
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyText1!.color),
                  overflow: TextOverflow.ellipsis,),),
              Text("\$${bookingContentDetailsItem.totalCost}",
                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).textTheme.bodyText1!.color),),
            ],
          ),
          Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          Text("${bookingContentDetailsItem.variantKey}",
            style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,color: Theme.of(context).hintColor),),
          Text("Qty :${bookingContentDetailsItem.quantity}",
            style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,color: Theme.of(context).hintColor),),
          Gaps.horizontalGapOf(Dimensions.PADDING_SIZE_SMALL),
        ],
      ),
    );
  }
}