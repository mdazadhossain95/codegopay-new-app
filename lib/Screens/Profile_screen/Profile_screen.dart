import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Screens/Profile_screen/bloc/profile_bloc.dart';
import 'package:codegopay/constant_string/User.dart';
import 'package:codegopay/cutom_weidget/custom_navigationBar.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            statusBarColor: Color(0xffFAFAFA),
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Color(0xffFAFAFA)),
        child: Scaffold(
          backgroundColor: const Color(0xffFAFAFA),
          body: BlocListener(
            bloc: _profileBloc,
            listener: (context, ProfileState state) {
              if (state.statusModel?.status == 0) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  dismissOnTouchOutside: false,
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
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              }
            },
            child: BlocBuilder(
              bloc: _profileBloc,
              builder: (context, ProfileState state) {
                return ProgressHUD(
                  inAsyncCall: state.isloading,
                  child: SafeArea(
                      bottom: false,
                      child: ListView(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'YOUR PROFILE',
                                  style: TextStyle(
                                      color: Color(0xff090B78),
                                      fontFamily: 'pop',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  state.profileModel!.accountStatus!,
                                  style: TextStyle(
                                      color:
                                          state.profileModel!.accountStatus ==
                                                  'verified'
                                              ? const Color(0xff3EC554)
                                              : Colors.red,
                                      fontFamily: 'pop',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                width: 120,
                                height: 120,
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                      state.profileModel!.profileimage!),
                                ),
                              ),
                              const SizedBox(
                                width: 27,
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'YOUR BALANCE',
                                        style: TextStyle(
                                            color: Color(0xffC4C4C4),
                                            fontFamily: 'pop',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // ignore: prefer_const_constructors
                                          Text(
                                            '€',
                                            style: const TextStyle(
                                                color: Color(0xff2C2C2C),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'pop'),
                                          ),
                                          Text(
                                            state.profileModel!.balance!,
                                            style: const TextStyle(
                                                color: Color(0xff2C2C2C),
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'pop'),
                                          )
                                        ],
                                      ),
                                      Text(
                                        state.profileModel!.email!,
                                        style: const TextStyle(
                                            color: Color(0xffC4C4C4),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'pop'),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        state.profileModel!.planName!,
                                        style: const TextStyle(
                                            color: Color(0xff3EC554),
                                            fontFamily: 'pop',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      state.profileModel!.needShowUpgrade == 1
                                          ? InkWell(
                                              onTap: () {
                                                User.planpage = 1;
                                                User.planlink =
                                                    state.profileModel!.planurl;

                                                Navigator.pushNamed(
                                                    context, 'planscreen');
                                              },
                                              child: const Text(
                                                'Upgrade Plan',
                                                style: TextStyle(
                                                    color: Color(0xff3EC554),
                                                    fontFamily: 'pop',
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xffF6F5F5),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${state.profileModel!.name!} ${state.profileModel!.surname!}",
                                  style: const TextStyle(
                                      color: Color(0xffC4C4C4),
                                      fontFamily: 'pop',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  state.profileModel!.address!,
                                  style: const TextStyle(
                                      color: Color(0xffC4C4C4),
                                      fontFamily: 'pop',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${state.profileModel!.city!} ${state.profileModel!.countryName!}',
                                  style: const TextStyle(
                                      color: Color(0xffC4C4C4),
                                      fontFamily: 'pop',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'IBAN ACCOUNT :',
                                  style: TextStyle(
                                      color: Color(0xffC4C4C4),
                                      fontFamily: 'pop',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  state.profileModel!.iban!,
                                  style: const TextStyle(
                                      color: Color(0xffC4C4C4),
                                      fontFamily: 'pop',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          sof == 1
                              ? InkWell(
                                  onTap: () async {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, 'Step4', (route) => true);
                                  },
                                  child: Container(
                                    height: 55,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 39),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'images/sof.png',
                                              color: const Color(0xff009456),
                                              height: 30,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              label!,
                                              style: const TextStyle(
                                                  color: Color(0xff009456),
                                                  fontSize: 12,
                                                  fontFamily: 'pop',
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          // alignment: Alignment.topLeft,
                                          child: Text(
                                            message!,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 10,
                                                fontFamily: 'pop',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : sof == 2
                                  ? InkWell(
                                      onTap: () async {
                                        // Navigator.pushNamedAndRemoveUntil(
                                        //     context, 'Step4', (route) => false);
                                      },
                                      child: Container(
                                        // height: 55,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 39),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'images/sof.png',
                                                  color: Colors.grey,
                                                  height: 30,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  label!,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                      fontFamily: 'pop',
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              ],
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 5),
                                              // alignment: Alignment.topLeft,
                                              child: Text(
                                                message!,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 10,
                                                    fontFamily: 'pop',
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                          InkWell(
                            onTap: () async {
                              // changePasswordScreen
                              Navigator.pushNamedAndRemoveUntil(context,
                                  'changePasswordScreen', (route) => true);
                            },
                            child: Container(
                              // height: 50,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 39, vertical: 10),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset(
                                  //   'images/lock.png',
                                  //   height: 30,
                                  //   color: Color(0xff009456),
                                  // ),
                                  Icon(
                                    CupertinoIcons.lock_fill,
                                    size: 25,
                                    color: Color(0xff009456),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'CHANGE PASSWORD',
                                    style: TextStyle(
                                        color: Color(0xff009456),
                                        fontSize: 12,
                                        fontFamily: 'pop',
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await launchUrl(
                                  Uri.parse(state.profileModel!.contactUs!));
                            },
                            child: Container(
                              // height: 55,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 39, vertical: 10),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset(
                                  //   'images/call.png',
                                  //   height: 30,
                                  // ),
                                  Icon(
                                    CupertinoIcons.phone,
                                    size: 25,
                                    color: Color(0xff009456),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'CONTACT US',
                                    style: TextStyle(
                                        color: Color(0xff009456),
                                        fontSize: 12,
                                        fontFamily: 'pop',
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await launchUrl(
                                  Uri.parse(state.profileModel!.helpFaq!));
                            },
                            child: Container(
                              // height: 55,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 39, vertical: 10),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset(
                                  //   'images/faq.png',
                                  //   height: 30,
                                  // ),
                                  Icon(
                                    CupertinoIcons.question_circle,
                                    size: 25,
                                    color: Color(0xff009456),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'HELP & FAQ’S',
                                    style: TextStyle(
                                        color: Color(0xff009456),
                                        fontSize: 12,
                                        fontFamily: 'pop',
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _profileBloc.add(LogoutEvent());
                            },
                            child: Container(
                              // height: 55,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 39, vertical: 10),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset(
                                  //   'images/logout.png',
                                  //   height: 30,
                                  // ),
                                  Icon(
                                    CupertinoIcons.square_arrow_right,
                                    size: 25,
                                    color: Color(0xffB1000B),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'LOG OUT',
                                    style: TextStyle(
                                        color: Color(0xffB1000B),
                                        fontSize: 12,
                                        fontFamily: 'pop',
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                );
              },
            ),
          ),
          bottomNavigationBar: CustomBottomBar(index: 4),
        ));
  }
}
