import 'package:codegopay/utils/input_fields/custom_color.dart';
import 'package:codegopay/widgets/custom_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomContainerButton extends StatelessWidget {
  final String imagePath;
  final String buttonText;
  final VoidCallback onPressed;

  const CustomContainerButton({
    super.key,
    required this.imagePath,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48),
          border: Border.all(color: CustomColor.whiteColor, width: 1),
          color: CustomColor.dashboardSendContainerColor,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFEBDCFD), // Shadow color
              offset: Offset(0, 0), // No offset
              spreadRadius: 2,
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageWidget(
              imagePath: imagePath,
              imageType: 'svg',
              height: 24,
            ),
            SizedBox(width: 4), // Gap
            Text(
              buttonText,
              style: GoogleFonts.inter(
                color: CustomColor.black,
                fontWeight: FontWeight.w400,
                fontSize: 16, // Adjust font size as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
