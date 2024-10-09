// ignore_for_file: camel_case_types, must_be_immutable

import 'package:codegopay/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/custom_style.dart';
import '../../utils/input_fields/custom_color.dart';
import '../buttons/custom_icon_button_widget.dart';

class CurrencySelector extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final List currencies;

  const CurrencySelector({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.currencies,
  });

  @override
  State<CurrencySelector> createState() => _CurrencySelectorState();
}

class _CurrencySelectorState extends State<CurrencySelector> {
  FocusNode myFocusNode = FocusNode();
  bool bordershoww = false;

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              color: myFocusNode.hasFocus
                  ? CustomColor.primaryColor
                  : CustomColor.inputFieldTitleTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextFormField(
          controller: widget.controller,
          focusNode: myFocusNode,
          readOnly: true,
          onTap: () {
            showModalBottomSheet(
              context: context,
              isDismissible: true,
              enableDrag: true,
              isScrollControlled: true,
              backgroundColor: CustomColor.whiteColor,
              barrierColor: Colors.black.withOpacity(0.2),
              useRootNavigator: true,
              builder: (context) {
                return StatefulBuilder(
                  builder: (buildContext, StateSetter setStater) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      padding: EdgeInsets.only(
                        top: 20,
                        right: 16,
                        left: 16,
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomIconButtonWidget(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                svgAssetPath: StaticAssets
                                    .closeBlack, // Replace with your asset path
                              ),
                              Text(
                                'Select Currency',
                                style: GoogleFonts.inter(
                                  color: CustomColor.primaryColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: ListView.builder(
                              itemCount: widget.currencies.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    widget.controller.text =
                                        widget.currencies[index].name;
                                    bordershoww = true;
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 20,
                                    ),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: CustomColor
                                              .primaryInputHintBorderColor,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.network(
                                          widget.currencies[index].image!,
                                          width: 24,
                                          height: 24,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          widget.currencies[index].name!,
                                          style: GoogleFonts.inter(
                                            color: CustomColor.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
          maxLines: 1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: CustomStyle.loginInputTextStyle,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16),
              hintText: widget.hint,
              hintStyle: CustomStyle.loginInputTextHintStyle,
              filled: true,
              fillColor: myFocusNode.hasFocus
                  ? CustomColor.whiteColor
                  : CustomColor.primaryInputHintColor,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: bordershoww
                      ? CustomColor.primaryColor
                      : CustomColor.primaryInputHintBorderColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(11),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:  BorderSide(
                  color: CustomColor.primaryColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(11),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(
                  StaticAssets.chevronDown,
                  // width: 10,
                  // height: 10,
                  colorFilter: ColorFilter.mode(
                    CustomColor.black,
                    // Use API-provided color if available, otherwise use default
                    BlendMode.srcIn,
                  ),
                ),
              )),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
