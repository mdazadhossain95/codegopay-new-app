import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Screens/Dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:codegopay/constant_string/User.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:codegopay/utils/input_fields/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/assets.dart';
import '../../widgets/buttons/default_back_button_widget.dart';
import '../../widgets/custom_image_widget.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final DashboardBloc _dashboardBloc = DashboardBloc();

  @override
  void initState() {
    super.initState();
    _dashboardBloc.add(DashboarddataEvent());
    User.Screen = 'Notification Screen';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.notificationBgColor,
      body: BlocListener(
          bloc: _dashboardBloc,
          listener: (context, DashboardState state) async {
            if (state.statusModel?.status == 0) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.rightSlide,
                desc: state.statusModel?.message,
                btnCancelText: 'OK',
                buttonsTextStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'pop',
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                btnCancelOnPress: () {},
              ).show();
            }
          },
          child: BlocBuilder(
              bloc: _dashboardBloc,
              builder: (context, DashboardState state) {
                return SafeArea(
                  child: ProgressHUD(
                    inAsyncCall: state.isloading,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appBarSection(context, state),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Local",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: CustomColor.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "For domestic transfers only",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color:
                                        CustomColor.transactionDetailsTextColor,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "Share",
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      color: CustomColor.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: CustomColor.whiteColor,
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              children: [
                                BeneficiaryInfoWidget(
                                  label:  "Beneficiary",
                                  title:  "Ranjit Singh",
                                  onCopy: () {},
                                ),
                                BeneficiaryInfoWidget(
                                  label: "IBAN",
                                  title: "AE485378957393845739",
                                  onCopy: () {},
                                ),
                                BeneficiaryInfoWidget(
                                  label: "BIC/SWIFT Code",
                                  title: "REVOLT21",
                                  onCopy: () {},
                                ),
                                BeneficiaryInfoWidget(
                                  label: "Bank and Name Address",
                                  title: "Etihad Airways Centre 5th Floor Abu Dhabi, UAE",
                                  onCopy: () {},
                                ),
                              ],
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                color: CustomColor.whiteColor,
                                borderRadius: BorderRadius.circular(16)),

                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child:
                                  Row(
                                    children: [
                                      Container(
                                        margin:EdgeInsets.only(right: 10),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12.0),
                                            color: CustomColor.primaryColor,
                                          ),
                                          child: CustomImageWidget(
                                            imagePath: StaticAssets.shieldDollar,
                                            imageType: 'svg',
                                            height: 30,
                                          )),

                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Protected Deposit",
                                              style: GoogleFonts.inter(
                                                color: CustomColor.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "Your money is protected by the Lithuanian Deposit Guarantee Scheme. Learn more.",
                                              style: GoogleFonts.inter(
                                                color: CustomColor.primaryTextHintColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),




                                    ],
                                  ),
                                ),
                                Divider(
                                  color: CustomColor.dashboardProfileBorderColor,
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child:
                                  Row(
                                    children: [
                                      Container(
                                        margin:EdgeInsets.only(right: 10),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12.0),
                                            color: CustomColor.primaryColor,
                                          ),
                                          child: CustomImageWidget(
                                            imagePath: StaticAssets.light,
                                            imageType: 'svg',
                                            height: 30,
                                          )),

                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Cross-platform transfer",
                                              style: GoogleFonts.inter(
                                                color: CustomColor.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "Receive transfers from Euro bank into your Revolut Payments Account using these details.",
                                              style: GoogleFonts.inter(
                                                color: CustomColor.primaryTextHintColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),




                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })),
    );
  }

  appBarSection(BuildContext context, state) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultBackButtonWidget(
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Text(
            'Deposit',
            style: GoogleFonts.inter(
                color: CustomColor.black,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          Container(
            width: 20,
          )
        ],
      ),
    );
  }
}

class BeneficiaryInfoWidget extends StatelessWidget {
  final String label;
  final String title;
  VoidCallback onCopy;

  BeneficiaryInfoWidget({
    super.key,
    required this.label,
    required this.title,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: CustomColor.touchIdSubtitleTextColor,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: CustomColor.transactionDetailsTextColor,
                  ),
                ),
              ),
              InkWell(
                onTap: onCopy,
                child: CustomImageWidget(
                  imagePath: StaticAssets.copy,
                  imageType: 'svg',
                  height: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
