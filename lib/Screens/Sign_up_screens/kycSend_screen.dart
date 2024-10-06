// import 'package:codegopay/Screens/Sign_up_screens/bloc/signup_bloc.dart';
// import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../utils/user_data_manager.dart';
//
// class KycSendScreen extends StatefulWidget {
//   const KycSendScreen({super.key});
//
//   @override
//   State<KycSendScreen> createState() => _KycSendScreenState();
// }
//
// class _KycSendScreenState extends State<KycSendScreen> {
//   bool completed = false;
//
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   final SignupBloc _signupBloc = SignupBloc();
//
//   @override
//   void initState() {
//     super.initState();
//
//     firebaseCloudMessaging_Listeners(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//         value: const SystemUiOverlayStyle(
//             statusBarIconBrightness: Brightness.dark,
//             statusBarBrightness: Brightness.light,
//             statusBarColor: Colors.white,
//             systemNavigationBarIconBrightness: Brightness.dark,
//             systemNavigationBarColor: Colors.white),
//         child: Scaffold(
//             resizeToAvoidBottomInset: false,
//             body: BlocListener(
//               bloc: _signupBloc,
//               listener: (context, SignupState state) async {
//                 String idProof;
//                 String idAddress;
//                 String idSelfie;
//                 idProof = await UserDataManager().getIdProofStatus();
//                 idAddress = await UserDataManager().getIdAddressProofStatus();
//                 idSelfie = await UserDataManager().getIdSelfieProofStatus();
//
//                 if (state.statusModel?.status == 1) {
//                   Navigator.pushNamedAndRemoveUntil(
//                       context, '/', (route) => false);
//                 }
//
//                 if (state.kycCreateModel?.status == 1) {
//                   if (idProof == "3" || idProof == "0") {
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, 'kycScreen', (route) => false);
//                   } else if (idAddress == "3" || idAddress == "0") {
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, 'addressProofScreen', (route) => false);
//                   } else if (idSelfie == "3" || idSelfie == "0") {
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, 'faceProofScreen', (route) => false);
//                   }
//                 } else {
//                   if (idProof == "3" || idProof == "0") {
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, 'kycScreen', (route) => false);
//                   } else if (idAddress == "3" || idAddress == "0") {
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, 'addressProofScreen', (route) => false);
//                   } else if (idSelfie == "3" || idSelfie == "0") {
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, 'faceProofScreen', (route) => false);
//                   }
//                 }
//               },
//               child: BlocBuilder(
//                   bloc: _signupBloc,
//                   builder: (context, SignupState state) {
//                     return ProgressHUD(
//                       inAsyncCall: state.isloading,
//                       child: SafeArea(
//                         bottom: false,
//                         child: GestureDetector(
//                           onTap: () {
//                             FocusScope.of(context).requestFocus(FocusNode());
//                           },
//                           child: Container(
//                             width: double.maxFinite,
//                             height: double.maxFinite,
//                             padding: const EdgeInsets.only(
//                                 left: 25, right: 25, top: 40),
//                             child: Column(
//                               children: [
//                                 Expanded(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         height: 34,
//                                         alignment: Alignment.center,
//                                         child: Image.asset(
//                                           'images/applogo.png',
//                                           height: 34,
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 42,
//                                       ),
//                                       Container(
//                                           alignment: Alignment.center,
//                                           child: Image.asset(
//                                               'images/happy-emoji.png')),
//                                       const SizedBox(
//                                         height: 22,
//                                       ),
//                                       const Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             "We're almost",
//                                             style: TextStyle(
//                                                 color: Color(0xff2C2C2C),
//                                                 fontFamily: 'pop',
//                                                 fontSize: 25,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                           Text(
//                                             " done.",
//                                             style: TextStyle(
//                                                 color: Color(0xff009456),
//                                                 fontFamily: 'pop',
//                                                 fontSize: 25,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(
//                                         height: 50,
//                                       ),
//                                       const Text(
//                                         "Let's complete you KYC",
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontFamily: 'pop',
//                                             fontSize: 26,
//                                             fontWeight: FontWeight.w500),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 // Container(
//                                 //   alignment: Alignment.centerLeft,
//                                 //   child: const Text(
//                                 //     "*Link expire in 30 minutes",
//                                 //     style: TextStyle(
//                                 //         color: Colors.black,
//                                 //         fontSize: 12,
//                                 //         fontFamily: 'pop',
//                                 //         fontWeight: FontWeight.w500),
//                                 //   ),
//                                 // ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Container(
//                                   height: 60,
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(11)),
//                                   child: ElevatedButton(
//                                       onPressed: () async {
//
//                                         String idProof;
//                                         String idAddress;
//                                         String idSelfie;
//                                         idProof = await UserDataManager().getIdProofStatus();
//                                         idAddress = await UserDataManager().getIdAddressProofStatus();
//                                         idSelfie = await UserDataManager().getIdSelfieProofStatus();
//                                         // _signupBloc.add(KycCreateEvent());
//
//
//                                         if(idProof == "0" || idAddress == "0" || idSelfie == "0"){
//                                           _signupBloc.add(KycCreateEvent());
//                                         } else if (idProof == "3" || idProof == "0") {
//                                           Navigator.pushNamedAndRemoveUntil(
//                                               context, 'kycScreen', (route) => false);
//                                         } else if (idAddress == "3" || idAddress == "0") {
//                                           Navigator.pushNamedAndRemoveUntil(
//                                               context, 'addressProofScreen', (route) => false);
//                                         } else if (idSelfie == "3" || idSelfie == "0") {
//                                           Navigator.pushNamedAndRemoveUntil(
//                                               context, 'faceProofScreen', (route) => false);
//                                         }
//                                       },
//
//                                       // User.resendkyc
//                                       //     ? () {
//                                       //         _signupBloc
//                                       //             .add(SendkyclinkEvent());
//                                       //       }
//                                       //     : null,
//                                       style: ElevatedButton.styleFrom(
//                                           backgroundColor:
//                                               const Color(0xff10245C),
//                                           elevation: 0,
//                                           shadowColor: Colors.transparent,
//                                           minimumSize:
//                                               const Size.fromHeight(40),
//                                           disabledBackgroundColor:
//                                               const Color(0xffC4C4C4),
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(11))),
//                                       child: const Text(
//                                         'Continue',
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 15,
//                                             fontFamily: 'pop',
//                                             fontWeight: FontWeight.w500),
//                                       )),
//                                 ),
//                                 const SizedBox(
//                                   height: 30,
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//             )));
//   }
//
//   void iOS_Permission() async {
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//         alert: true, badge: true, sound: true);
//
//     debugPrint("123Settings registered: ${settings.authorizationStatus}");
//   }
//
//   void firebaseCloudMessaging_Listeners(BuildContext context) {
//     FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//         alert: true, badge: true, sound: true);
//
//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       if (message != null) {
//         debugPrint(' kyc terminated');
//         try {
//           if (message.notification != null) {
//             if (message.data['category'] == 'kyc_verified') {
//               Navigator.pushNamedAndRemoveUntil(
//                   context, 'setpin', (route) => false);
//             } else if (message.data['category'] == 'kyc_rejected') {
//               Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
//             }
//           }
//         } catch (e) {
//           debugPrint(e.toString());
//         }
//       }
//     });
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       debugPrint('A new onmessage event was published!');
//
//       debugPrint('message *** ${message.data}');
//
//       try {
//         if (message.notification != null) {
//           debugPrint(message.data['category']);
//
//           if (message.data['category'] == 'kyc_verified') {
//             Navigator.pushNamedAndRemoveUntil(
//                 context, 'setpin', (route) => false);
//           } else if (message.data['category'] == 'kyc_rejected') {
//             Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
//           }
//         }
//       } catch (e) {
//         debugPrint(e.toString());
//       }
//     });
//
//     FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       debugPrint('A new onMessageOpenedApp event was published!');
//
//       try {
//         if (message.notification != null) {
//           if (message.data['category'] == 'kyc_verified') {
//             Navigator.pushNamedAndRemoveUntil(
//                 context, 'setpin', (route) => false);
//           } else if (message.data['category'] == 'kyc_rejected') {
//             Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
//           }
//         }
//       } catch (e) {
//         debugPrint(e.toString());
//       }
//     });
//   }
// }
//
// Future myBackgroundMessageHandler(RemoteMessage message) async {
//   if (message.data != null) {
//     // Handle data message
//     debugPrint(
//         'dashboard screen on myBackgroundMessageHandler dashboed $message');
//     final dynamic data = message.data;
//   }
//
//   if (message.notification != null) {
//     // Handle notification message
//     debugPrint(
//         'dashboard screen on myBackgroundMessageHandler dashbord $message');
//     final dynamic notification = message.notification;
//   }
//
//   // Or do other work.
// }
