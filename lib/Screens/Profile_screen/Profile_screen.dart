import 'package:codegopay/Screens/Profile_screen/bloc/profile_bloc.dart';
import 'package:codegopay/constant_string/User.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:codegopay/utils/assets.dart';
import 'package:codegopay/utils/input_fields/custom_color.dart';
import 'package:codegopay/widgets/custom_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/buttons/custom_floating_action_button.dart';
import '../../widgets/toast/toast_util.dart';
import '../Dashboard_screen/deposit_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileBloc _profileBloc = ProfileBloc();

  String? label = "";
  String? message = "";
  int? sof = 0;

  @override
  void initState() {
    super.initState();

    _profileBloc.add(getprofileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.notificationBgColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: BlocListener(
          bloc: _profileBloc,
          listener: (context, ProfileState state) {
            if (state.statusModel?.status == 0) {
              CustomToast.showError(
                  context, "Sorry!", state.statusModel!.message!);
            }

            if (state.profileModel?.sof?.sourceOfWealth == 1) {
              label = state.profileModel?.sof?.label.toString();
              message = state.profileModel?.sof?.sourceOfWealthMsg.toString();
              sof = 1;
            } else if (state.profileModel?.sof?.sourceOfWealth == 2) {
              label = state.profileModel?.sof?.label.toString();
              message = state.profileModel?.sof?.sourceOfWealthMsg.toString();

              sof = 2;
            }

            if (state.logoutModel?.status == 1) {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            }
          },
          child: BlocBuilder(
            bloc: _profileBloc,
            builder: (context, ProfileState state) {
              return ProgressHUD(
                inAsyncCall: state.isloading,
                child: SafeArea(
                    bottom: false,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: ListView(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(bottom: 15, top: 10),
                            child: Text(
                              'Profile',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                  color: CustomColor.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              color: CustomColor.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x0D000000),
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  spreadRadius: -2,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 96,
                                      height: 96,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: CustomColor
                                                .profileImageContainerColor,
                                            width: 5, // Border width
                                          ),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(state
                                                  .profileModel!.profileimage!),
                                              fit: BoxFit.cover)),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                            color: CustomColor.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle_outline,
                                              color: CustomColor.whiteColor,
                                              size: 20,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 3),
                                              child: Text(
                                                state.profileModel!
                                                    .accountStatus!,
                                                style: GoogleFonts.inter(
                                                    color:
                                                        CustomColor.whiteColor,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: CustomColor
                                          .profileImageContainerColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                            color: Color(0xffE3FFEA)
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: Color(0xffAEEBBD))),
                                        child: Text(
                                          state.profileModel!.planName!,
                                          style: GoogleFonts.inter(
                                              color: Color(0xff34C759),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          CustomImageWidget(
                                            imagePath: StaticAssets.wallet,
                                            imageType: 'svg',
                                            height: 15,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Text(
                                              'My Balance',
                                              style: GoogleFonts.inter(
                                                  color: CustomColor.black
                                                      .withOpacity(0.5),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // ignore: prefer_const_constructors
                                          // Text(
                                          //   '€',
                                          //   style: const TextStyle(
                                          //       color: Color(0xff2C2C2C),
                                          //       fontSize: 10,
                                          //       fontWeight: FontWeight.w700,
                                          //       fontFamily: 'pop'),
                                          // ),
                                          Text(
                                            "€ ${state.profileModel!.balance!}",
                                            style: GoogleFonts.inter(
                                              color: CustomColor.black,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        state.profileModel!.email!,
                                        style: GoogleFonts.inter(
                                          color: CustomColor.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      if (state.profileModel!.needShowUpgrade ==
                                          1)
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      if (state.profileModel!.needShowUpgrade ==
                                          1)
                                        InkWell(
                                          onTap: () {
                                            User.planpage = 1;
                                            User.planlink =
                                                state.profileModel!.planurl;

                                            Navigator.pushNamed(
                                                context, 'planscreen');
                                          },
                                          child: Text(
                                            'Upgrade Plan',
                                            style: GoogleFonts.inter(
                                                color: CustomColor.green,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 8),
                            child: Text(
                              "My Address",
                              style: GoogleFonts.inter(
                                  color: CustomColor.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              var data = state.profileModel!;

                              Navigator.push(
                                context,
                                PageTransition(
                                  child: DashboardDepositScreen(
                                    name: data.name!,
                                    iban: data.iban!,
                                    bic: data.bic!,
                                    bankName: data.bankName!,
                                    bankAddress: data.bankAddress!,
                                  ),
                                  type: PageTransitionType.rightToLeft,
                                  alignment: Alignment.center,
                                  duration: const Duration(milliseconds: 300),
                                  reverseDuration:
                                      const Duration(milliseconds: 200),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              decoration: BoxDecoration(
                                color: CustomColor.whiteColor,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x0D000000),
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                    spreadRadius: -2,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        decoration: BoxDecoration(
                                            color: Color(0xff0A52E1),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: CustomImageWidget(
                                          imagePath: StaticAssets.location,
                                          imageType: 'svg',
                                          height: 20,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${state.profileModel!.name!} ${state.profileModel!.surname!}",
                                                style: GoogleFonts.inter(
                                                    color: CustomColor.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 5),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                    color: Color(0xff0A52E1)
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Text(
                                                  "Main Address",
                                                  style: GoogleFonts.inter(
                                                      color: CustomColor
                                                          .primaryColor,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "IBAN Account : ${state.profileModel!.iban!}",
                                                style: GoogleFonts.inter(
                                                    color: CustomColor.black
                                                        .withOpacity(0.7),
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  CustomImageWidget(
                                    imagePath: StaticAssets.arrowRight,
                                    imageType: 'svg',
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (sof == 1)
                            InkWell(
                              onTap: () async {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, 'Step4', (route) => true);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Color(0xffFFFCF0),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x0D000000),
                                      offset: Offset(0, 2),
                                      blurRadius: 4,
                                      spreadRadius: -2,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomImageWidget(
                                          imagePath: StaticAssets.timeRewind,
                                          imageType: 'svg',
                                          height: 21,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                label!,
                                                style: GoogleFonts.inter(
                                                    color: CustomColor.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                message!,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                style: GoogleFonts.inter(
                                                    color: CustomColor.black
                                                        .withOpacity(0.7),
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (sof == 2)
                            InkWell(
                              onTap: () async {
                                // Navigator.pushNamedAndRemoveUntil(
                                //     context, 'Step4', (route) => false);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                decoration: BoxDecoration(
                                  color: Color(0xffFFFCF0),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x0D000000),
                                      offset: Offset(0, 2),
                                      blurRadius: 4,
                                      spreadRadius: -2,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomImageWidget(
                                          imagePath: StaticAssets.timeRewind,
                                          imageType: 'svg',
                                          height: 21,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                label!,
                                                style: GoogleFonts.inter(
                                                    color: CustomColor.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                message!,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.inter(
                                                    color: CustomColor.black
                                                        .withOpacity(0.7),
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5, left: 5),
                            child: Text(
                              'Details',
                              style: GoogleFonts.inter(
                                  color: CustomColor.black.withOpacity(0.3),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              color: CustomColor.whiteColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color:
                                      CustomColor.primaryInputHintBorderColor),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x0D000000),
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  spreadRadius: -2,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                CustomActionButton(
                                  icon: StaticAssets.lock,
                                  label: 'Change Password',
                                  onTap: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      'changePasswordScreen',
                                      (route) => true,
                                    );
                                  },
                                ),
                                Divider(
                                  color: CustomColor.black.withOpacity(0.2),
                                ),
                                CustomActionButton(
                                  icon: StaticAssets.contactUs,
                                  label: 'Contact Us',
                                  onTap: () async {
                                    await launchUrl(Uri.parse(
                                        state.profileModel!.contactUs!));
                                  },
                                ),
                                Divider(
                                  color: CustomColor.black.withOpacity(0.2),
                                ),
                                CustomActionButton(
                                  icon: StaticAssets.info,
                                  label: 'Help & FAQs',
                                  onTap: () async {
                                    await launchUrl(Uri.parse(
                                        state.profileModel!.helpFaq!));
                                  },
                                ),
                                Divider(
                                  color: CustomColor.black.withOpacity(0.2),
                                ),
                                InkWell(
                                  onTap: () {
                                    _profileBloc.add(LogoutEvent());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            CustomImageWidget(
                                              imagePath: StaticAssets.logout,
                                              imageType: 'svg',
                                              height: 25,
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              "Log Out",
                                              style: GoogleFonts.inter(
                                                  color: CustomColor.errorColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Container()
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              );
            },
          ),
        ),
        floatingActionButton: CustomFloatingActionButton());
  }
}

class BottomSheetContentStep4 extends StatelessWidget {
  BottomSheetContentStep4(
      {super.key,
      required this.iban,
      required this.name,
      required this.address});

  String name, address, iban;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColor.whiteColor,
      borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16)), // Rounded top corners
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CustomImageWidget(
                      imagePath: StaticAssets.closeBlack,
                      imageType: 'svg',
                      height: 20,
                    )),
                Text(
                  'Details',
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
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColor.hubContainerBgColor,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Name',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.inter(
                          color: CustomColor.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        name,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.inter(
                          color: CustomColor.black.withOpacity(0.7),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Address',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.inter(
                          color: CustomColor.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          address,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.inter(
                            color: CustomColor.black.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'IBAN ACCOUNT',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.inter(
                          color: CustomColor.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        iban,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.inter(
                          color: CustomColor.black.withOpacity(0.7),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomActionButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const CustomActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CustomImageWidget(
                  imagePath: icon,
                  imageType: 'svg',
                  height: 18,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  label,
                  style: GoogleFonts.inter(
                      color: CustomColor.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            CustomImageWidget(
              imagePath: StaticAssets.arrowRight,
              imageType: 'svg',
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
