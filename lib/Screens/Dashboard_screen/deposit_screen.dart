import 'package:codegopay/Screens/Dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:codegopay/constant_string/User.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:codegopay/utils/input_fields/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/assets.dart';
import '../../widgets/buttons/default_back_button_widget.dart';
import '../../widgets/custom_image_widget.dart';
import '../../widgets/toast/toast_util.dart';

class DashboardDepositScreen extends StatefulWidget {
  DashboardDepositScreen(
      {super.key,
      required this.name,
      required this.iban,
      required this.bic,
      required this.bankName,
      required this.bankAddress});

  String name, iban, bic, bankName, bankAddress;

  @override
  State<DashboardDepositScreen> createState() => _DashboardDepositScreenState();
}

class _DashboardDepositScreenState extends State<DashboardDepositScreen>
    with SingleTickerProviderStateMixin {
  final DashboardBloc _dashboardBloc = DashboardBloc();
  bool local = true;

  @override
  void initState() {
    super.initState();
    // _dashboardBloc.add(DashboarddataEvent());
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
              CustomToast.showError(
                  context, "Sorry!", state.statusModel!.message!);
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
                      child: ListView(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appBarSection(context, state),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: CustomColor.currencyCustomSelectorColor,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        local = true;
                                      });
                                    },
                                    child: Container(
                                      height: 41,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: local
                                            ? CustomColor.whiteColor
                                            : CustomColor
                                                .currencyCustomSelectorColor,
                                        boxShadow: local
                                            ? [
                                                BoxShadow(
                                                  color: Color(0x0D000000),
                                                  // Shadow color
                                                  offset: Offset(0, 2),
                                                  // Offset of the shadow
                                                  blurRadius: 4,
                                                  // Blur radius
                                                  spreadRadius:
                                                      0, // Spread radius (0px)
                                                ),
                                              ]
                                            : [],
                                      ),
                                      child: Text(
                                        'Local',
                                        style: GoogleFonts.inter(
                                            color: local
                                                ? CustomColor.black
                                                : CustomColor.black
                                                    .withOpacity(0.6),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        local = false;
                                      });
                                    },
                                    child: Container(
                                      height: 41,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: local
                                            ? CustomColor
                                                .currencyCustomSelectorColor
                                            : CustomColor.whiteColor,
                                        boxShadow: local
                                            ? []
                                            : [
                                                BoxShadow(
                                                  color: Color(0x0D000000),
                                                  // Shadow color
                                                  offset: Offset(0, 2),
                                                  // Offset of the shadow
                                                  blurRadius: 4,
                                                  // Blur radius
                                                  spreadRadius:
                                                      0, // Spread radius (0px)
                                                ),
                                              ],
                                      ),
                                      child: Text(
                                        'Swift',
                                        style: GoogleFonts.inter(
                                            color: local
                                                ? CustomColor.black
                                                    .withOpacity(0.6)
                                                : CustomColor.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          local
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "For domestic transfers only",
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: CustomColor
                                                  .transactionDetailsTextColor,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Text(
                                              "",
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
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Column(
                                        children: [
                                          BeneficiaryInfoWidget(
                                            label: "Beneficiary",
                                            title: widget.name ?? "",
                                            onCopy: () {
                                              copyToClipboard(
                                                  context, widget.name);
                                            },
                                          ),
                                          BeneficiaryInfoWidget(
                                            label: "IBAN",
                                            title: widget.iban ?? "",
                                            onCopy: () {
                                              copyToClipboard(
                                                  context, widget.iban);
                                            },
                                          ),
                                          BeneficiaryInfoWidget(
                                            label: "BIC/SWIFT Code",
                                            title: widget.bic ?? "",
                                            onCopy: () {
                                              copyToClipboard(
                                                  context, widget.bic);
                                            },
                                          ),
                                          BeneficiaryInfoWidget(
                                            label: "Bank and Name Address",
                                            title:
                                                "${widget.bankName}\n${widget.bankAddress}" ??
                                                    "",
                                            onCopy: () {
                                              copyToClipboard(context,
                                                  "${widget.bankName}\n${widget.bankAddress}");
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                          color: CustomColor.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            child: Row(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                      color: CustomColor
                                                          .primaryColor,
                                                    ),
                                                    child: CustomImageWidget(
                                                      imagePath: StaticAssets
                                                          .shieldDollar,
                                                      imageType: 'svg',
                                                      height: 30,
                                                    )),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Protected Deposit",
                                                        style:
                                                            GoogleFonts.inter(
                                                          color:
                                                              CustomColor.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Your money is protected by the Lithuanian Deposit Guarantee Scheme.",
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: CustomColor
                                                              .primaryTextHintColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: CustomColor
                                                .dashboardProfileBorderColor,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            child: Row(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                      color: CustomColor
                                                          .primaryColor,
                                                    ),
                                                    child: CustomImageWidget(
                                                      imagePath:
                                                          StaticAssets.light,
                                                      imageType: 'svg',
                                                      height: 30,
                                                    )),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Cross-platform transfer",
                                                        style:
                                                            GoogleFonts.inter(
                                                          color:
                                                              CustomColor.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Receive transfers from Euro bank into your Revolut Payments Account using these details.",
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: CustomColor
                                                              .primaryTextHintColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                )
                              : Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: Text(
                                      "Coming Soon...",
                                      style: GoogleFonts.inter(
                                        color: CustomColor.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
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

void copyToClipboard(BuildContext context, String textToCopy) {
  // Copy the text to the clipboard
  Clipboard.setData(ClipboardData(text: textToCopy)).then((_) {
    // Show a SnackBar to indicate that the text was copied
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied to clipboard!'),
        duration: Duration(seconds: 2), // Show for 2 seconds
      ),
    );
  });
}

class BeneficiaryInfoWidget extends StatelessWidget {
  final String label;
  String? title;
  VoidCallback onCopy;

  BeneficiaryInfoWidget({
    super.key,
    required this.label,
    this.title = "",
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
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    title!,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: CustomColor.transactionDetailsTextColor,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: onCopy,
                child: CustomImageWidget(
                  imagePath: StaticAssets.copy,
                  imageType: 'svg',
                  height: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
