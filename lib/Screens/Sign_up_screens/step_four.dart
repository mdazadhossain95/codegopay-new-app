// import 'dart:ui' as ui;
// import 'dart:convert';
//
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:codegopay/Screens/Sign_up_screens/bloc/signup_bloc.dart';
// import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
// import 'package:codegopay/cutom_weidget/input_textform.dart';
// import 'package:codegopay/cutom_weidget/selectsourcefund.dart';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
//
// import '../../cutom_weidget/text_uploadimages.dart';
//
// class StepfourScreen extends StatefulWidget {
//   const StepfourScreen({super.key});
//
//   @override
//   State<StepfourScreen> createState() => _StepfourScreenState();
// }
//
// class _StepfourScreenState extends State<StepfourScreen> {
//   final _formkey = GlobalKey<FormState>();
//   final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
//   String signature = "Tap to add signature";
//   String signLabel = "Tap to add signature";
//   XFile? image;
//
//   bool? male = true;
//   bool? Shipping = true;
//   bool active = false;
//   final TextEditingController _image = TextEditingController(text: '');
//   final TextEditingController _signController = TextEditingController(text: '');
//   final picker = ImagePicker();
//
//   final TextEditingController _fund = TextEditingController();
//   final TextEditingController _ocupation = TextEditingController();
//
//   final SignupBloc _signupBloc = SignupBloc();
//
//   FocusNode myFocusNode = FocusNode();
//
//   FocusNode passwordFocusNode = FocusNode();
//
//   @override
//   void initState() {
//     _formkey.currentState?.validate();
//     super.initState();
//
//     _signupBloc.add(SourcefundEvent());
//
//     // Request gallery access permission when the widget initializes
//     _requestPermission();
//   }
//
//   Future<void> _requestPermission() async {
//     // Request gallery access permission
//     // final status = await Permission.photos.request();
//     final status = await Permission.photos.request();
//     if (status.isGranted) {
//       // Permission granted, you can proceed with image picking
//       print('Permission granted');
//     } else {
//       // Permission denied, handle accordingly (e.g., show a message to the user)
//       print('Permission denied');
//     }
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
//           resizeToAvoidBottomInset: true,
//           body: SafeArea(
//             bottom: false,
//             child: GestureDetector(
//               onTap: () {
//                 FocusScope.of(context).requestFocus(FocusNode());
//               },
//               child: BlocListener(
//                 bloc: _signupBloc,
//                 listener: (context, SignupState state) {
//                   if (state.statusModel?.status == 1) {
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, 'dashboard', (route) => false);
//                   } else if (state.statusModel?.status == 0) {
//                     AwesomeDialog(
//                       context: context,
//                       dialogType: DialogType.error,
//                       animType: AnimType.rightSlide,
//                       desc: state.statusModel?.message,
//                       btnCancelText: 'OK',
//                       buttonsTextStyle: const TextStyle(
//                           fontSize: 14,
//                           fontFamily: 'pop',
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white),
//                       btnCancelOnPress: () {},
//                     ).show();
//                   }
//                 },
//                 child: BlocBuilder(
//                   bloc: _signupBloc,
//                   builder: (context, SignupState state) {
//                     return Container(
//                       width: double.maxFinite,
//                       height: double.maxFinite,
//                       padding:
//                       const EdgeInsets.only(left: 25, right: 25, top: 40),
//                       child: ProgressHUD(
//                         inAsyncCall: state.isloading,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: Image.asset(
//                             "images/backarrow.png",
//                             color: const Color(0xff373737),
//                             height: 24,
//                             width: 24,
//                           ),
//                         ),
//                             const SizedBox(
//                               height: 15,
//                             ),
//                             const Text(
//                               "Source Of Wealth Declaration",
//                               style: TextStyle(
//                                   fontSize: 25,
//                                   fontFamily: 'pop',
//                                   fontWeight: FontWeight.w500,
//                                   color: Color(0xff2C2C2C)),
//                             ),
//                             const SizedBox(
//                               height: 22,
//                             ),
//                             Form(
//                                 key: _formkey,
//                                 child: Expanded(
//                                   child: ListView(
//                                     shrinkWrap: true,
//                                     children: [
//                                       InputTextCustom(
//                                           controller: _ocupation,
//                                           hint: '',
//                                           label: 'Your occupations ?',
//                                           isEmail: false,
//                                           isPassword: false,
//                                           onChanged: () {
//                                             if (_formkey.currentState!
//                                                 .validate()) {
//                                               setState(() {
//                                                 active = true;
//                                               });
//                                             }
//                                           }),
//                                       inputselectsource(
//                                         controller: _fund,
//                                         hint: ' ',
//                                         label: 'Source of funds',
//                                         ontap: () {
//                                           if (_formkey.currentState!
//                                               .validate()) {
//                                             setState(() {
//                                               active = true;
//                                             });
//                                           }
//                                         },
//                                         listitems:
//                                         state.sourceFund!.soruceFund!,
//                                         selectString: 'Source of funds',
//                                       ),
//                                       Inputuploadimage(
//                                         controller: _image,
//                                         hint: 'Upload image',
//                                         isEmail: false,
//                                         ispassword: false,
//                                         label: 'Proof of income',
//                                         ontap: () async {
//                                           image = await picker.pickImage(
//                                               source: ImageSource.gallery);
//                                           image != null
//                                               ? setState(() {
//                                             if (_formkey.currentState!
//                                                 .validate()) {
//                                               setState(() {
//                                                 active = true;
//                                               });
//                                             }
//                                             _image.text = image!.name;
//                                           })
//                                               : null;
//                                         },
//                                       ),
//                                       InkWell(
//                                         onTap: () async {
//                                           showDialog(
//                                             context: context,
//                                             builder: (BuildContext context) {
//                                               return AlertDialog(
//                                                 title: const Text(
//                                                   'Sign Here',
//                                                   textAlign: TextAlign.center,
//                                                 ),
//                                                 content: Column(
//                                                   mainAxisSize:
//                                                   MainAxisSize.min,
//                                                   children: [
//                                                     Container(
//                                                       height: 200,
//                                                       width: 300,
//                                                       decoration: BoxDecoration(
//                                                           border: Border.all(
//                                                               color:
//                                                               Colors.grey)),
//                                                       child: SfSignaturePad(
//                                                         key: signatureGlobalKey,
//                                                         backgroundColor:
//                                                         Colors.white,
//                                                         strokeColor:
//                                                         Colors.black,
//                                                         minimumStrokeWidth: 1.0,
//                                                         maximumStrokeWidth: 4.0,
//                                                       ),
//                                                     ),
//                                                     const SizedBox(height: 20),
//                                                     Row(
//                                                       mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceEvenly,
//                                                       children: [
//                                                         InkWell(
//                                                           onTap: () {
//                                                             signatureGlobalKey
//                                                                 .currentState!
//                                                                 .clear();
//                                                           },
//                                                           child: const Padding(
//                                                             padding:
//                                                             EdgeInsets.all(
//                                                                 10.0),
//                                                             child:
//                                                             Text('Reset'),
//                                                           ),
//                                                         ),
//                                                         ElevatedButton(
//                                                           onPressed: () async {
//                                                             print("click");
//                                                             final data =
//                                                             await signatureGlobalKey
//                                                                 .currentState!
//                                                                 .toImage(
//                                                                 pixelRatio:
//                                                                 3.0);
//                                                             final bytes = await data
//                                                                 .toByteData(
//                                                                 format: ui
//                                                                     .ImageByteFormat
//                                                                     .png);
//                                                             signature =
//                                                                 base64Encode(bytes!
//                                                                     .buffer
//                                                                     .asUint8List());
//
//                                                             // Print base64 image
//                                                             print(signature);
//
//                                                             Navigator.pop(
//                                                                 context);
//                                                           },
//                                                           child: const Padding(
//                                                             padding:
//                                                             EdgeInsets.all(
//                                                                 10.0),
//                                                             child: Text(
//                                                               'Submit',
//                                                               selectionColor:
//                                                               Colors.green,
//                                                             ),
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 ),
//                                               );
//                                             },
//                                           );
//
//                                           signature != null
//                                               ? setState(() {
//                                             if (_formkey.currentState!
//                                                 .validate()) {
//                                               setState(() {
//                                                 active = true;
//                                               });
//                                             }
//                                             signLabel =
//                                             "Thanks For adding your Signature";
//                                           })
//                                               : null;
//                                         },
//                                         child: Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             const Text(
//                                               "Tap to add Signature",
//                                               style: TextStyle(
//                                                 fontSize: 12,
//                                                 fontFamily: 'pop',
//                                                 color: Color(0xff10245C),
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height: 10,
//                                             ),
//                                             Container(
//                                               height: 200,
//                                               alignment: Alignment.center,
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                 BorderRadius.circular(10),
//                                                 color: Colors.white,
//                                               ),
//                                               child: Container(
//                                                   alignment: Alignment.center,
//                                                   decoration: BoxDecoration(
//                                                     borderRadius:
//                                                     BorderRadius.circular(
//                                                         10),
//                                                     color: Colors.grey
//                                                         .withOpacity(0.2),
//                                                   ),
//                                                   child: Text(signLabel)),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 20,
//                                       ),
//                                       Container(
//                                         margin: const EdgeInsets.symmetric(
//                                             horizontal: 0),
//                                         height: 60,
//                                         width: double.infinity,
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                             BorderRadius.circular(11)),
//                                         child: ElevatedButton(
//                                             onPressed: active
//                                                 ? () {
//                                               if (_formkey.currentState!
//                                                   .validate()) {
//                                                 debugPrint(image!.path
//                                                     .toString());
//                                                 _signupBloc.add(
//                                                     UpdatesourceEvent(
//                                                         occupation:
//                                                         _ocupation
//                                                             .text,
//                                                         photo:
//                                                         image!.path,
//                                                         source:
//                                                         _fund.text,
//                                                         signature:
//                                                         signature));
//                                               }
//                                             }
//                                                 : null,
//                                             style: ElevatedButton.styleFrom(
//                                                 backgroundColor:
//                                                 const Color(0xff10245C),
//                                                 elevation: 0,
//                                                 disabledBackgroundColor:
//                                                 const Color(0xffC4C4C4),
//                                                 shadowColor: Colors.transparent,
//                                                 minimumSize:
//                                                 const Size.fromHeight(40),
//                                                 shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                     BorderRadius.circular(
//                                                         11))),
//                                             child: const Text(
//                                               'Continue',
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 15,
//                                                   fontFamily: 'pop',
//                                                   fontWeight: FontWeight.w500),
//                                             )),
//                                       ),
//                                     ],
//                                   ),
//                                 )),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
// }