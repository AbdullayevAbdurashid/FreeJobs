import 'dart:typed_data';
import 'package:demandium/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:demandium/core/helper/date_converter.dart';
import 'package:demandium/feature/service_booking/controller/booking_details_tabs_controller.dart';
import 'package:demandium/feature/service_booking/model/booking_details_model.dart';
import 'package:demandium/feature/service_booking/model/invoice.dart';
import 'package:demandium/feature/splash/controller/splash_controller.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class InvoiceController {
   static Future<Uint8List> generateUint8List(
       BookingDetailsContent bookingDetailsContent,
       List<InvoiceItem> items,
       BookingDetailsTabsController controller) async{
     final pdf = Document();
     final netImage = await networkImage('${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
         '/business/${Get.find<SplashController>().configModel.content!.logo}');

     final date = DateTime.now();
     var invoice = Invoice(
       provider: Provider(
       name: bookingDetailsContent.provider != null? bookingDetailsContent.provider!.companyName! :'',
       address: bookingDetailsContent.provider != null? bookingDetailsContent.provider!.companyAddress!: '',
       phone: bookingDetailsContent.provider != null? bookingDetailsContent.provider!.companyPhone!: '',
      ),
      serviceman: Serviceman(
        name: bookingDetailsContent.serviceman != null? "${bookingDetailsContent.serviceman!.user!.firstName!} ${bookingDetailsContent.serviceman!.user!.lastName!}":'',
        phone: bookingDetailsContent.serviceman != null? bookingDetailsContent.serviceman!.user!.phone!: '',
      ),
      info: InvoiceInfo(
        date: date,
        description: 'Payment Status : ',
        number: bookingDetailsContent.readableId.toString(),
        paymentStatus: bookingDetailsContent.isPaid == 0 ?"Unpaid": 'Paid',
      ),
      items: items,
    );



    pdf.addPage(MultiPage(
      build: (context) => [
        buildInvoiceImage(netImage,bookingDetailsContent,invoice),
        SizedBox(height: 0.6 * PdfPageFormat.cm),
        invoiceIDSchedule(invoice.info.number,invoice.info.date),
        buildHeader(invoice,bookingDetailsContent),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        buildInvoice(invoice),
        SizedBox(height:Dimensions.paddingSizeDefault),
        buildTotal(bookingDetailsContent,controller,invoice.info.paymentStatus),
      ],
      footer: (context) => buildFooter(bookingDetailsContent),
    ));

    return pdf.save();
  }

  static Widget invoiceIDSchedule(String invoiceID, DateTime invoiceSchedule) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("Invoice # $invoiceID",style: pw.TextStyle(fontWeight: FontWeight.bold)),
      Text("Service Schedule : ${DateConverter.formatDate(invoiceSchedule)}"),
    ]
  );

  static Widget buildHeader(Invoice invoice,BookingDetailsContent content) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 1 * PdfPageFormat.cm),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          serviceAddress(
            name: "${content.customer?.firstName??""} ${content.customer?.lastName??""}",
            address: content.serviceAddress != null ?
            "${content.serviceAddress!.address!.contains('null') ? '':
            content.serviceAddress!.address}" : '',
            email: content.customer?.email??"",
            phone:content.customer!.phone != null ?  content.customer!.phone! : '',
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
            SizedBox(height: Dimensions.paddingSizeSmall),
            buildProviderSection(invoice.provider,invoice.serviceman),
          ])
        ],
      ),
    ],
  );

  static Widget serviceAddress({
    required String name,
    required String email,
    required String phone,
    required String address}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Service Address", style: TextStyle(fontWeight: FontWeight.bold)),
        buildSimpleText(title: 'Customer Name', value: name),
        if(email!='')
        buildSimpleText(title: 'Email', value: email),
        if(phone!='')
        buildSimpleText(title: 'Phone', value: phone),
        if(address != '' )
          SizedBox(
              width: Get.width*.4,
            child: Text('Address: $address')
          )
    ]
  );

  static Widget buildProviderSection(Provider provider,Serviceman serviceman) => Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      if(serviceman.name != '' && serviceman.phone != '')
        Text("Serviceman Details", style: TextStyle(fontWeight: FontWeight.bold)),
      Text(serviceman.name),
      // Text(provider.address),
      Text(serviceman.phone),
      SizedBox(height: Dimensions.paddingSizeDefault),
      if(provider.name != '' && provider.phone != '')
        Text("Provider Details", style: TextStyle(fontWeight: FontWeight.bold)),
      Text(provider.name),
      // Text(provider.address),
      Text(provider.phone),
    ],
  );
  static Widget buildServiceManSection(Serviceman serviceman) => Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [

    ],
  );

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    final titles = <String>[
      'Invoice Number:',
      'Invoice Date:',
      'Payment Status:',
    ];

    final data = <String>[
      info.number,
      DateConverter.dateStringMonthYear(info.date),
      info.paymentStatus,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];
        return buildText(title: title, value: value, width: 200);
      }),
    );
  }



  static Widget buildSupplierAddress(Supplier supplier) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 1 * PdfPageFormat.mm),
      Text(supplier.address),
    ],
  );

  static Widget buildTitle(Invoice invoice) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'INVOICE',
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
      //Text(invoice.info.description),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
    ],
  );

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Description',
      'Unit Price',
      'Quantity',
      'Discount',
      'Tax',
      'Total',
    ];
    final data = invoice.items.map((item) {
      return [
        item.serviceName,
        item.unitPrice,
        item.quantity,
        item.discountAmount,
        item.tax,
        item.unitAllTotal,
      ];
    }).toList();

    return ClipRRect(
      horizontalRadius: Dimensions.paddingSizeExtraSmall,
      verticalRadius: Dimensions.paddingSizeExtraSmall,
      child:  Container(
          color:  PdfColors.grey300,
          child: Table.fromTextArray(
            headers: headers,

            data: data,
            columnWidths: {
              0: (kIsWeb) ? FixedColumnWidth(Get.width / 12) : FixedColumnWidth(Get.width / 4),
            },
            border: null,
            headerStyle: TextStyle(fontWeight: FontWeight.bold,),
            headerDecoration: const BoxDecoration(color: PdfColors.grey400),
            cellHeight: 30,
            cellAlignments: {
              0: Alignment.centerLeft,
              1: Alignment.center,
              2: Alignment.center,
              3: Alignment.center,
              4: Alignment.center,
              5: Alignment.center,
              6: Alignment.centerRight,
            },
          )
      ),
    );

  }

  static Widget buildTotal(
      BookingDetailsContent bookingDetailsContent,
      BookingDetailsTabsController controller,
      String paymentStatus) {
    double serviceDiscount = 0;
    bookingDetailsContent.detail?.forEach((service) {
      serviceDiscount = serviceDiscount + service.discountAmount!;
    });
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Payment Status",style: pw.TextStyle(fontWeight: FontWeight.bold)),
              Text(paymentStatus),
            ]
          ),
          Spacer(flex: 4),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                buildText(
                  title: 'Sub Total(VAT excluded)',
                  value: controller.allTotalCost.toString(),
                  unite: true,
                ),

                buildText(
                  title: 'Service discount',
                  value: '(-) ${serviceDiscount.toString()}',
                  unite: true,
                ),
                buildText(
                  title: 'Coupon discount',
                  value: '(-) ${bookingDetailsContent.totalCouponDiscountAmount.toString()}',
                  unite: true,
                ),
                buildText(
                  title: 'Campaign discount',
                  value: '(-) ${bookingDetailsContent.totalCampaignDiscountAmount.toString()}',
                  unite: true,
                ),
                buildText(
                  title: 'Tax',
                  value: "(+) ${bookingDetailsContent.totalTaxAmount!.toStringAsFixed(2)}",
                  unite: true,
                ),

                Divider(),
                buildText(
                  title: 'Grand Total',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: controller.bookingDetailsContent!.totalBookingAmount!.toStringAsFixed(2),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(BookingDetailsContent bookingDetailsContent) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text("If you require any assistance or have feedback or suggestions about our site, you can call or email us.",textAlign: TextAlign.center),
      SizedBox(height: Dimensions.paddingSizeSmall),

      Container(
        color: PdfColors.grey100,
        width: double.infinity,
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${Get.find<SplashController>().configModel.content!.businessPhone}"),
                SizedBox(width: 20),
                Text("${Get.find<SplashController>().configModel.content!.businessEmail}"),
              ]
            ),
            SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Text(AppConstants.baseUrl),
            SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Text("${Get.find<SplashController>().configModel.content!.footerText != null ? Get.find<SplashController>().configModel.content!.footerText! : null}",
             textAlign: TextAlign.center
           ),
          ]
        )
      ),
    ],
  );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        SizedBox(width: Get.width*.4,child: Text(value)),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }

   static Widget buildInvoiceImage(var netImage,BookingDetailsContent bookingDetailsContent,Invoice invoice) {
     return Container(
       width: Dimensions.invoiceImageWidth,
       height: Dimensions.invoiceImageHeight,
       child: pw.Image(netImage),);
   }
}
