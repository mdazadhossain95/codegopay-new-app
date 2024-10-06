// import 'dart:io';
//
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:codegopay/Screens/Sign_up_screens/bloc/signup_bloc.dart';
// import 'package:codegopay/constant_string/User.dart';
// import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
// import 'package:codegopay/cutom_weidget/input_textform.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class StepthreeScreen extends StatefulWidget {
//   const StepthreeScreen({super.key});
//
//   @override
//   State<StepthreeScreen> createState() => _StepthreeScreenState();
// }
//
// class _StepthreeScreenState extends State<StepthreeScreen> {
//   final _formkey = GlobalKey<FormState>();
//
//   bool? male = true;
//   bool? Shipping = true;
//
//   final TextEditingController _email = TextEditingController();
//   final TextEditingController _password = TextEditingController();
//   final TextEditingController _repassword = TextEditingController();
//
//   bool? show = false;
//
//   FocusNode myFocusNode = FocusNode();
//
//   FocusNode passwordFocusNode = FocusNode();
//
//   final SignupBloc _signupBloc = SignupBloc();
//
//   @override
//   void initState() {
//     _formkey.currentState?.validate();
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
//         child: Scaffold(
//           resizeToAvoidBottomInset: true,
//           body: BlocListener(
//               bloc: _signupBloc,
//               listener: (context, SignupState state) {
//                 if (state.statusModel?.status == 1) {
//                   Navigator.pushNamed(context, 'verifyotp');
//                 } else if (state.statusModel?.status == 0) {
//                   AwesomeDialog(
//                     context: context,
//                     dialogType: DialogType.error,
//                     animType: AnimType.rightSlide,
//                     desc: state.statusModel?.message,
//                     btnCancelText: 'OK',
//                     buttonsTextStyle: const TextStyle(
//                         fontSize: 14,
//                         fontFamily: 'pop',
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white),
//                     btnCancelOnPress: () {},
//                   ).show();
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
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: Container(
//                                     width: 24,
//                                     height: 24,
//                                     alignment: Alignment.center,
//                                     child: Image.asset(
//                                       'images/backarrow.png',
//                                       width: 24,
//                                       height: 24,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 const Text(
//                                   "Let's setup your bank account - Step 3",
//                                   style: TextStyle(
//                                       fontSize: 25,
//                                       fontFamily: 'pop',
//                                       fontWeight: FontWeight.w500,
//                                       color: Color(0xff2C2C2C)),
//                                 ),
//                                 const SizedBox(
//                                   height: 22,
//                                 ),
//                                 Form(
//                                     key: _formkey,
//                                     child: Expanded(
//                                       child: ListView(
//                                         shrinkWrap: true,
//                                         children: [
//                                           InputTextCustom(
//                                               controller: _email,
//                                               hint: 'example@example.com',
//                                               label: 'email account',
//                                               isEmail: true,
//                                               isPassword: false,
//                                               onChanged: () {}),
//                                           InputTextCustom(
//                                             controller: _password,
//                                             hint: '',
//                                             label: 'password',
//                                             isEmail: false,
//                                             isPassword: true,
//                                             isHide: !show!,
//                                             onChanged: () {},
//                                           ),
//                                           InputTextCustom(
//                                             controller: _repassword,
//                                             hint: '',
//                                             label: 'confirm password',
//                                             isEmail: false,
//                                             isPassword: true,
//                                             // pas: _password.text,
//                                             isConfirmPassword: true,
//                                             isHide: true,
//                                             onChanged: () {},
//                                           ),
//                                           Container(
//                                             alignment: Alignment.center,
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               children: [
//                                                 Checkbox(
//                                                     value: show,
//                                                     onChanged: (v) {
//                                                       setState(() {
//                                                         show = v;
//                                                       });
//                                                     }),
//                                                 const Text(
//                                                   'Show password',
//                                                   style: TextStyle(
//                                                       fontFamily: 'pop',
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.w500),
//                                                 )
//                                               ],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     )),
//                                 const SizedBox(
//                                   height: 30,
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   })),
//           bottomNavigationBar: Container(
//             height: 60,
//             margin: EdgeInsets.symmetric(horizontal: 25),
//             width: double.infinity,
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(11)),
//             child: ElevatedButton(
//                 onPressed: () {
//                   if (_formkey.currentState!.validate()) {
//                     User.email = _email.text;
//                     User.password = _password.text;
//
//                     User.deviceType = Platform.isAndroid ? 'android' : 'ios';
//
//                     _signupBloc.add(sendemailotpEvent(email: _email.text));
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xff10245C),
//                     elevation: 0,
//                     disabledBackgroundColor: Color(0xffC4C4C4),
//                     shadowColor: Colors.transparent,
//                     minimumSize: const Size.fromHeight(40),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(11))),
//                 child: const Text(
//                   'Continue',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 15,
//                       fontFamily: 'pop',
//                       fontWeight: FontWeight.w500),
//                 )),
//           ),
//         ));
//   }
// }
