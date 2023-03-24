import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? title;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final bool? isPassword;
  final bool? isShowBorder;
  final bool? isAutoFocus;
  final Function(String)? onSubmit;
  final bool? isEnabled;
  final int? maxLines;
  final bool? isShowSuffixIcon;
  final TextCapitalization? capitalization;
  final Function(String text)? onChanged;
  final String? countryDialCode;
  final String? suffixIconUrl;
  final Function(CountryCode countryCode)? onCountryChanged;
  final String? Function(String? )? onValidate;

  CustomTextField(
      {this.hintText = '',
        this.controller,
        this.focusNode,
        this.nextFocus,
        this.isEnabled = true,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines = 1,
        this.isShowSuffixIcon = false,
        this.onSubmit,
        this.capitalization = TextCapitalization.none,
        this.isPassword = false,
        this.isShowBorder = false,
        this.isAutoFocus = false,
        this.countryDialCode,
        this.onCountryChanged,
        this.suffixIconUrl,
        this.onChanged,
        this.onValidate,
        this.title,
      });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: ubuntuRegular.copyWith(fontSize:Dimensions.fontSizeDefault,color: widget.isEnabled==false?Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6):Theme.of(context).textTheme.bodyText1!.color),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).hintColor,
      textCapitalization: widget.capitalization!,
      enabled: widget.isEnabled,
      autofocus: widget.isAutoFocus!,
      autofillHints: widget.inputType == TextInputType.name ? [AutofillHints.name]
          : widget.inputType == TextInputType.emailAddress ? [AutofillHints.email]
          : widget.inputType == TextInputType.phone ? [AutofillHints.telephoneNumber]
          : widget.inputType == TextInputType.streetAddress ? [AutofillHints.fullStreetAddress]
          : widget.inputType == TextInputType.url ? [AutofillHints.url]
          : widget.inputType == TextInputType.visiblePassword ? [AutofillHints.password] : null,
      obscureText: widget.isPassword! ? _obscureText : false,
      inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))] : null,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(Get.find<LocalizationController>().isLtr ? Dimensions.PADDING_SIZE_DEFAULT : Dimensions.PADDING_SIZE_LARGE),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary)),
        hintText: widget.hintText,
        hintStyle: ubuntuRegular.copyWith(
            fontSize: Dimensions.fontSizeDefault,
            color: Theme.of(context).hintColor.withOpacity(Get.isDarkMode ? .5:1)),
        prefixIcon:widget.title != null ? SizedBox(
            width: Dimensions.TAB_MINIMUM_SIZE * 0.2,
            child: Align(
              alignment:Get.find<LocalizationController>().isLtr ?  Alignment.centerLeft : Alignment.centerRight,
              child: Text(
                  widget.title!,
                  textAlign: TextAlign.start,
                  style: ubuntuRegular.copyWith(
                    fontSize:  Dimensions.fontSizeDefault,
                    color: widget.isEnabled==false?Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6):Theme.of(context).textTheme.bodyText1!.color,)),
            )) : null,
        suffixIcon: widget.isPassword! ?
        IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).hintColor.withOpacity(0.3)),
          onPressed: _toggle,
        ) : null,
      ),
      onFieldSubmitted: (text) => widget.nextFocus != null ?
      FocusScope.of(context).requestFocus(widget.nextFocus) :
      widget.onSubmit != null ? widget.onSubmit!(text) : null,
      onChanged: widget.onChanged,
      validator: widget.onValidate != null ? widget.onValidate!: null,

    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}