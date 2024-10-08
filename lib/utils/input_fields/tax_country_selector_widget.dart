// ignore_for_file: camel_case_types, must_be_immutable

import 'package:codegopay/constant_string/User.dart';
import 'package:codegopay/utils/assets.dart';
import 'package:codegopay/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/buttons/custom_icon_button_widget.dart';
import '../../widgets/custom_image_widget.dart';
import '../custom_style.dart';
import 'custom_color.dart';



class TextCountrySelectorWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label, hint, selectString;
  bool? nationality = true;
  final String? variable;
  final List listitems;

  TextCountrySelectorWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.listitems,
    required this.selectString,
    this.nationality,
    this.variable,
  });

  @override
  State<TextCountrySelectorWidget> createState() => _TextCountrySelectorWidgetState();
}

class _TextCountrySelectorWidgetState extends State<TextCountrySelectorWidget> {
  FocusNode myFocusNode = FocusNode();
  bool bordershoww = false;
  TextEditingController searchController = TextEditingController();
  List filteredItems = [];

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      setState(() {});
    });

    // Initialize the filtered items list to show all items initially
    filteredItems = widget.listitems;

    searchController.addListener(() {
      setState(() {
        // Filter the list based on search input
        filteredItems = widget.listitems
            .where((item) => item.countryName
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
            filteredItems = widget.listitems;
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
                      height: MediaQuery.of(context).size.height * 0.9,
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
                                svgAssetPath: StaticAssets.xClose,
                              ),
                              Text(
                                widget.selectString,
                                style: GoogleFonts.inter(
                                  color: CustomColor.primaryColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Search bar
                          TextField(
                            controller: searchController,
                            onChanged: (value) {
                              setState(() {
                                filteredItems = widget.listitems
                                    .where((item) => item.countryName
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                    .toList();
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Search Country",
                              hintStyle: CustomStyle.loginInputTextHintStyle,
                              filled: true,
                              fillColor: CustomColor.primaryInputHintColor,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                    CustomColor.primaryInputHintBorderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: CustomColor.errorColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: CustomColor.errorColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color:
                                    CustomColor.primaryInputHintBorderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12)),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color:
                                    CustomColor.primaryInputHintBorderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color:
                                    CustomColor.primaryInputHintBorderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12)),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: CustomImageWidget(
                                  imagePath: StaticAssets.searchMd,
                                  imageType: 'svg',
                                  height: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: ListView.builder(
                              itemCount: filteredItems.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    widget.controller.text =
                                        filteredItems[index].countryName;
                                    widget.nationality == true
                                        ? User.TaxCountry =
                                        filteredItems[index].countryId
                                        : User.TaxCountry =
                                        filteredItems[index].countryId;
                                    User.TaxCountry =
                                        filteredItems[index].countryId;
                                    setState(() {
                                      bordershoww = true;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
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
                                        Padding(
                                          padding: const EdgeInsets.only(right: 8),
                                          child: Image.network(
                                            filteredItems[index].image,
                                            height: 24,
                                            width: 36,
                                          ),
                                        ),
                                        Text(
                                          filteredItems[index].countryName,
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
          maxLines: 2,
          minLines: 1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return Validator.validateValues(
              value: value,
            );
          },
          onChanged: (v) {
            setState(() {
              v.isNotEmpty ? bordershoww = true : bordershoww = false;
            });
          },
          style: CustomStyle.loginInputTextStyle,
          decoration: InputDecoration(
            errorStyle: TextStyle(color: CustomColor.errorColor),
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
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: CustomColor.errorColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(11),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: CustomColor.errorColor,
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
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: CustomColor.primaryColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(11),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: CustomColor.primaryColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(11),
            ),
            enabled: true,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset(
                StaticAssets.chevronDown,
                colorFilter: const ColorFilter.mode(
                  CustomColor.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
