import 'package:codegopay/constant_string/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({super.key});

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  bool completed = false;

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
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            bottom: false,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                padding: const EdgeInsets.only(left: 25, right: 25, top: 40),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 300,
                            alignment: Alignment.center,
                            child: Image.asset(
                              'images/applogo.png',
                            ),
                          ),
                          const SizedBox(
                            height: 42,
                          ),

                          // Container(
                          //   width: 100,
                          //   alignment: Alignment.center,
                          //   child: Image.asset(
                          //     'images/proof-address.png',
                          //   ),
                          // ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    User.kycmessage,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'pop',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Container(
                    //   height: 60,
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(11)),
                    //   child: ElevatedButton(
                    //       onPressed: () {
                    //         Navigator.pushNamedAndRemoveUntil(
                    //             context, '/', (route) => false);
                    //       },
                    //       style: ElevatedButton.styleFrom(
                    //           backgroundColor: const Color(0xff10245C),
                    //           elevation: 0,
                    //           shadowColor: Colors.transparent,
                    //           minimumSize: const Size.fromHeight(40),
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(11))),
                    //       child: const Text(
                    //         'Proceed',
                    //         style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 15,
                    //             fontFamily: 'pop',
                    //             fontWeight: FontWeight.w500),
                    //       )),
                    // ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
