// import 'package:codegopay/Screens/Sign_up_screens/bloc/signup_bloc.dart';
// import 'package:codegopay/constant_string/User.dart';
// import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../utils/user_data_manager.dart';
//
// class KycRejectScreen extends StatefulWidget {
//   const KycRejectScreen({super.key});
//
//   @override
//   State<KycRejectScreen> createState() => _KycRejectScreenState();
// }
//
// class _KycRejectScreenState extends State<KycRejectScreen> {
//   bool completed = false;
//
//   final SignupBloc _signupBloc = SignupBloc();
//
//   @override
//   void initState() {
//     super.initState();
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
//         child: BlocListener(
//             bloc: _signupBloc,
//             listener: (context, SignupState state) async {
//               if (state.statusModel?.status == 1) {
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, '/', (route) => false);
//               }
//
//               String idProof;
//               String idAddress;
//               String idSelfie;
//               idProof = await UserDataManager().getIdProofStatus();
//               idAddress = await UserDataManager().getIdAddressProofStatus();
//               idSelfie = await UserDataManager().getIdSelfieProofStatus();
//
//               if (idProof == "3" || idProof == "0") {
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, 'kycScreen', (route) => false);
//               } else if (idAddress == "3" || idAddress == "0") {
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, 'addressProofScreen', (route) => false);
//               } else if (idSelfie == "3" || idSelfie == "0") {
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, 'faceProofScreen', (route) => false);
//               }
//
//               // if (state.kycStatusModel!.isIdproof == 3) {
//               //   Navigator.pushNamedAndRemoveUntil(
//               //       context, 'kycScreen', (route) => false);
//               // } else if (state.kycStatusModel!.isAddressproof == 3) {
//               //   Navigator.pushNamedAndRemoveUntil(
//               //       context, 'addressProofScreen', (route) => false);
//               // } else if (state.kycStatusModel!.isSelfie == 3) {
//               //   Navigator.pushNamedAndRemoveUntil(
//               //       context, 'faceProofScreen', (route) => false);
//               // } else {
//               //   // Navigator.pushNamedAndRemoveUntil(
//               //   //     context, '/', (route) => false);
//               // }
//             },
//             child: BlocBuilder(
//                 bloc: _signupBloc,
//                 builder: (context, SignupState state) {
//                   return Scaffold(
//                     resizeToAvoidBottomInset: false,
//                     body: ProgressHUD(
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
//                                               'images/sad-emoji.png')),
//                                       const SizedBox(
//                                         height: 22,
//                                       ),
//                                       Container(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           User.kycmessage,
//                                           textAlign: TextAlign.center,
//                                           style: const TextStyle(
//                                               color: Color(0xff2C2C2C),
//                                               fontFamily: 'pop',
//                                               fontSize: 25,
//                                               fontWeight: FontWeight.w500),
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 22,
//                                       ),
//                                       ListView.builder(
//                                         shrinkWrap: true,
//                                         padding: const EdgeInsets.all(0),
//                                         itemCount: User.rejectedaddress.length,
//                                         itemBuilder:
//                                             (BuildContext context, int index) {
//                                           return Text(
//                                             "- ${User.rejectedaddress[index]}",
//                                             style: const TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 14,
//                                                 fontFamily: 'pop',
//                                                 fontWeight: FontWeight.w600),
//                                           );
//                                         },
//                                       ),
//                                       ListView.builder(
//                                         shrinkWrap: true,
//                                         padding: const EdgeInsets.all(0),
//                                         itemCount: User.rejectedproffid.length,
//                                         itemBuilder:
//                                             (BuildContext context, int index) {
//                                           return Text(
//                                             "- ${User.rejectedproffid[index]}",
//                                             style: const TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 14,
//                                                 fontFamily: 'pop',
//                                                 fontWeight: FontWeight.w600),
//                                           );
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Container(
//                                   height: 60,
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(11)),
//                                   child: ElevatedButton(
//                                       onPressed: () {
//                                         _signupBloc.add(KycStatusCheckEvent());
//                                         // Navigator.pushNamedAndRemoveUntil(
//                                         //     context,
//                                         //     'kycScreen',
//                                         //     (route) => false);
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                           backgroundColor:
//                                               const Color(0xff10245C),
//                                           elevation: 0,
//                                           shadowColor: Colors.transparent,
//                                           minimumSize:
//                                               const Size.fromHeight(40),
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
//                     ),
//                   );
//                 })));
//   }
// }
