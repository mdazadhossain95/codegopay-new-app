// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Models/dashboard/iban_currency_model.dart';
import '../../utils/assets.dart';
import '../../utils/custom_style.dart';
import '../../utils/input_fields/custom_color.dart';
import '../buttons/custom_icon_button_widget.dart';

class IbanSelector extends StatefulWidget {
  final TextEditingController ibanController;
  final String label;
  final String hint;
  final List<Iban> ibans;

  const IbanSelector({
    Key? key,
    required this.ibanController,
    required this.label,
    required this.hint,
    required this.ibans,
  }) : super(key: key);

  @override
  State<IbanSelector> createState() => _IbanSelectorState();
}

class _IbanSelectorState extends State<IbanSelector> {
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
          controller: widget.ibanController,
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
                                svgAssetPath: StaticAssets.closeBlack, // Replace with your asset path
                              ),
                              Text(
                                'Select IBAN',
                                style: GoogleFonts.inter(
                                  color: CustomColor.primaryColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: ListView.builder(
                              itemCount: widget.ibans.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    widget.ibanController.text = widget.ibans[index].name ?? '';
                                    setState(() {
                                      bordershoww = true;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: CustomColor.primaryInputHintBorderColor,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        // Display any relevant icon or image here if needed
                                        const SizedBox(width: 10),
                                        Text(
                                          widget.ibans[index].name!,
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
              borderSide: const BorderSide(
                color: CustomColor.primaryColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(11),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset(
                StaticAssets.chevronDown, // Adjust this to your asset path
                colorFilter: ColorFilter.mode(
                  CustomColor.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
