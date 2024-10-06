import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/utils/assets.dart';
import 'package:codegopay/utils/input_fields/custom_color.dart';
import 'package:codegopay/widgets/custom_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../buttons/primary_button_widget.dart';

class CustomDialogWidget {
  // Success Dialog
  static void showSuccessDialog({
    required BuildContext context,
    required String title,
    required String subTitle,
    String? btnOkText,
    VoidCallback? btnOkOnPress,
    bool dismissOnTouchOutside = true,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      dismissOnTouchOutside: dismissOnTouchOutside,
      body: _customBodyWidget(
          image: StaticAssets.dialogWarning,
          title: title,
          subTitle: subTitle,
          color: CustomColor.green.withOpacity(0.2)),
      btnOkText: btnOkText ?? 'Great!',
      btnOkOnPress: btnOkOnPress ?? () {},
    ).show();
  }

  // Error Dialog
  static void showErrorDialog({
    required BuildContext context,
    required String title,
    required String subTitle,
    required VoidCallback onTap,
    required String btnText,
    bool dismissOnTouchOutside = true,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: CustomColor.whiteColor,
      animType: AnimType.rightSlide,
      dismissOnTouchOutside: dismissOnTouchOutside,
      body: _customBodyWidget(
          image: StaticAssets.dialogWarning,
          title: title,
          subTitle: subTitle,
          color: CustomColor.errorColor.withOpacity(0.2)),
      // btnOkText: btnOkText ?? 'Retry',
      // btnCancelText: btnCancelText ?? 'Cancel',
      btnOk: PrimaryButtonWidget(
        onPressed: onTap,
        buttonText: btnText,
      ),
      // btnOkOnPress: btnOkOnPress ?? () {},
      // btnCancelOnPress: btnCancelOnPress,
    ).show();
  }

  // Not Found Dialog
  static void showNotFoundDialog({
    required BuildContext context,
    required String title,
    required String subTitle,
    String? btnOkText,
    VoidCallback? btnOkOnPress,
    bool dismissOnTouchOutside = true,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.infoReverse,
      animType: AnimType.topSlide,
      dismissOnTouchOutside: dismissOnTouchOutside,
      body: _customBodyWidget(
          image: StaticAssets.dialogWarning,
          title: title,
          subTitle: subTitle,
          color: CustomColor.green.withOpacity(0.2)),
      btnOkText: btnOkText ?? 'Close',
      dialogBackgroundColor: CustomColor.whiteColor,
      btnOkOnPress: btnOkOnPress ?? () {},
    ).show();
  }

  // Warning Dialog
  static void showWarningDialog({
    required BuildContext context,
    required String title,
    required String subTitle,
    String? btnOkText,
    String? btnCancelText,
    VoidCallback? btnOkOnPress,
    VoidCallback? btnCancelOnPress,
    bool dismissOnTouchOutside = true,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      dismissOnTouchOutside: dismissOnTouchOutside,
      body: _customBodyWidget(
          image: StaticAssets.dialogWarning,
          title: title,
          subTitle: subTitle,
          color: CustomColor.green.withOpacity(0.2)),
      btnOkText: btnOkText ?? 'Understood',
      btnCancelText: btnCancelText ?? 'Cancel',
      btnOkOnPress: btnOkOnPress ?? () {},
      btnCancelOnPress: btnCancelOnPress,
    ).show();
  }

  // Custom container widget that you can modify to include extra data
  static Widget _customBodyWidget(
      {required String image,
      required String title,
      required Color color,
      required String subTitle}) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Container(
            alignment: Alignment.center,
            width: 56,
            height: 56,
            margin: EdgeInsets.all(8),
            // padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomImageWidget(
              imagePath: image,
              imageType: 'svg',
              height: 30,
              width: 30,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: CustomColor.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: CustomColor.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
