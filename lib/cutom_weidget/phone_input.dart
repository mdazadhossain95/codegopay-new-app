import 'package:codegopay/utils/assets.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/custom_style.dart';
import '../utils/input_fields/custom_color.dart';

class CustomPhoneInputFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final Function(String)? onChange;
  final Function()? onTap;
  final bool readOnly;

  const CustomPhoneInputFieldWidget({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    this.onChange,
    this.onTap,
    this.readOnly = false,
  }) : super(key: key);

  @override
  State<CustomPhoneInputFieldWidget> createState() =>
      _CustomPhoneInputFieldWidgetState();
}

class _CustomPhoneInputFieldWidgetState
    extends State<CustomPhoneInputFieldWidget> {
  FocusNode _focusNode = FocusNode();
  bool _showBorder = false;
  String _selectedCountryCode = '+39'; // Default country code

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _focusNode.hasFocus || _showBorder
                  ? CustomColor.primaryColor
                  : CustomColor.inputFieldTitleTextColor,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: _focusNode.hasFocus
                ? CustomColor.whiteColor
                : CustomColor.primaryInputHintColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _focusNode.hasFocus
                  ? CustomColor.primaryColor
                  : CustomColor.primaryInputHintBorderColor,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(
                        color: CustomColor.inputFieldTitleTextColor, width: 1),
                  ),
                ),
                child: CountryCodePicker(
                  onChanged: (countryCode) {
                    setState(() {
                      _selectedCountryCode = countryCode.dialCode!;
                    });
                    if (widget.onChange != null) {
                      widget.onChange!(_selectedCountryCode);
                    }
                  },
                  initialSelection: 'IT',
                  // Italy as default
                  favorite: ['+39', 'IT'],
                  showFlag: true,
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                  padding: EdgeInsets.only(left: 10),
                  // Custom design of country code picker
                  builder: (countryCode) {
                    return Row(
                      children: [
                        if (countryCode?.flagUri != null)
                          Image.asset(
                            countryCode!.flagUri!,
                            package: 'country_code_picker',
                            width: 24,
                            height: 16,
                          ),
                        const SizedBox(width: 8),
                        Text(
                          countryCode?.dialCode ?? '',
                          style: CustomStyle.loginInputTextStyle,
                        ),
                        const SizedBox(width: 4),
                        SvgPicture.asset(
                          StaticAssets.chevronDown,
                          width: 12,
                          height: 12,
                        ), // Down icon for country code selection
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.phone,
                  readOnly: widget.readOnly,
                  onChanged: (value) {
                    setState(() {
                      _showBorder = value.isNotEmpty;
                    });
                    if (widget.onChange != null) {
                      widget.onChange!(value);
                    }
                  },
                  onTap: widget.onTap,
                  style: CustomStyle.loginInputTextStyle,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16),
                    hintText: widget.hint,
                    hintStyle: CustomStyle.loginInputTextHintStyle,
                    border: InputBorder.none, // Remove default borders
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
