import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Screens/Dashboard_screen/Dashboard_screen.dart';
import 'package:codegopay/Screens/transfer_screen/binficiary_screen.dart';
import 'package:codegopay/Screens/transfer_screen/bloc/transfer_bloc.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({super.key});

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  final TransferBloc _transferBloc = TransferBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white),
        child: BlocListener(
          bloc: _transferBloc,
          listener: (context, TransferState state) {
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
                btnCancelOnPress: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      alignment: Alignment.center,
                      isIos: true,
                      duration: const Duration(milliseconds: 200),
                      child: const BeneficiaryListScreen(),
                    ),
                  );
                },
              ).show();
            } else if (state.statusModel?.status == 1) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.rightSlide,
                dismissOnTouchOutside: false,
                btnOkColor: Colors.green,
                desc: state.statusModel?.message,
                btnCancelText: 'OK',
                buttonsTextStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'pop',
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                btnCancelOnPress: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      alignment: Alignment.center,
                      isIos: true,
                      duration: const Duration(milliseconds: 200),
                      child: const DashboardScreen(),
                    ),
                  );
                },
              ).show();
            }
          },
          child: BlocBuilder(
            bloc: _transferBloc,
            builder: (context, TransferState state) {
              return ProgressHUD(
                inAsyncCall: state.isloading,
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: SafeArea(
                    bottom: false,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 70),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'To complete your payment open your email and proceed with biometric recognition',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'pop',
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff2C2C2C),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Image.asset(
                                'images/Vector.png',
                                width: 198,
                                height: 198,
                              ),
                            ),
                            Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11)),
                              child: ElevatedButton(
                                  onPressed: () {
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> SliderScreen()));

                                    _transferBloc.add(
                                        ApproveibanTransactionEvent(
                                            uniqueId: "",
                                            completed: 'Completed',
                                            lat: '',
                                            long: ''));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff10245C),
                                      elevation: 0,
                                      disabledBackgroundColor:
                                          const Color(0xffC4C4C4),
                                      shadowColor: Colors.transparent,
                                      minimumSize: const Size.fromHeight(40),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(11))),
                                  child: const Text(
                                    'Next',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'pop',
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                            const SizedBox(
                              height: 1,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
