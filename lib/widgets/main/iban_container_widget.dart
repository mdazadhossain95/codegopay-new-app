import 'package:codegopay/utils/assets.dart';
import 'package:codegopay/widgets/custom_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/input_fields/custom_color.dart';

class IbanCardWidget extends StatelessWidget {
  final String label;
  final String iban;
  final String bic;
  final String balance;
  final String currency;
  final VoidCallback onTap;
  final VoidCallback onTapIbanCopy;
  final VoidCallback onTapBicCopy;

  const IbanCardWidget({
    super.key,
    required this.label,
    required this.iban,
    required this.bic,
    required this.balance,
    required this.currency,
    required this.onTap,
    required this.onTapIbanCopy,
    required this.onTapBicCopy,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          // Border radius
          border: Border.all(color: CustomColor.dashboardProfileBorderColor),
          // Border color
          color: Color(0xFFFBFBFB), // Background color
        ),
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Color(0xFFDCE1EE),
                ),
                child: CustomImageWidget(
                  imagePath: StaticAssets.securityUser,
                  imageType: 'svg',
                  height: 38,
                )),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      color: CustomColor.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: onTapIbanCopy,
                        child: CustomImageWidget(
                          imagePath: StaticAssets.copy,
                          imageType: 'svg',
                          height: 12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text(
                          iban,
                          style: GoogleFonts.inter(
                            color: CustomColor.primaryTextHintColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: onTapBicCopy,
                        child: CustomImageWidget(
                          imagePath: StaticAssets.copy,
                          imageType: 'svg',
                          height: 12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text(
                          bic,
                          style: GoogleFonts.inter(
                            color: CustomColor.primaryTextHintColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  balance,
                  style: GoogleFonts.inter(
                    color: CustomColor.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  currency,
                  style: GoogleFonts.inter(
                    color: Color(0xff039257),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
