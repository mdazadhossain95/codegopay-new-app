// import 'package:codegopay/Models/base_model.dart';
// import 'package:codegopay/Screens/Sign_up_screens/bloc/signup_bloc.dart';
// import 'package:codegopay/constant_string/User.dart';
// import 'package:codegopay/cutom_weidget/input_textform.dart';
// import 'package:codegopay/cutom_weidget/inputtext_select.dart';
// import 'package:codegopay/cutom_weidget/phone_input.dart';
// import 'package:codegopay/cutom_weidget/select_funds.dart';
// import 'package:codegopay/cutom_weidget/tax_input.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class SteptwoScreen extends StatefulWidget {
//   const SteptwoScreen({super.key});
//
//   @override
//   State<SteptwoScreen> createState() => _SteptwoScreenState();
// }
//
// class _SteptwoScreenState extends State<SteptwoScreen> {
//   final _formkey = GlobalKey<FormState>();
//
//   bool? male = true;
//   bool? Shipping = true;
//   bool active = false;
//
//   final TextEditingController _country = TextEditingController();
//   final TextEditingController _fund = TextEditingController();
//   final TextEditingController _email = TextEditingController();
//
//   final TextEditingController _phone = TextEditingController();
//   final TextEditingController _taxes = TextEditingController();
//   final TextEditingController _taxcountry = TextEditingController();
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
//     _signupBloc.add(incomesourceEvent());
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
//               child: BlocBuilder(
//                 bloc: _signupBloc,
//                 builder: (context, SignupState state) {
//                   return Container(
//                     width: double.maxFinite,
//                     height: double.maxFinite,
//                     padding:
//                         const EdgeInsets.only(left: 25, right: 25, top: 40),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: Container(
//                             width: 24,
//                             height: 24,
//                             alignment: Alignment.center,
//                             child: Image.asset(
//                               'images/backarrow.png',
//                               width: 24,
//                               height: 24,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         const Text(
//                           "Let's setup your bank account - Step 2",
//                           style: TextStyle(
//                               fontSize: 25,
//                               fontFamily: 'pop',
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xff2C2C2C)),
//                         ),
//                         const SizedBox(
//                           height: 22,
//                         ),
//                         Form(
//                             key: _formkey,
//                             child: Expanded(
//                               child: ListView(
//                                 shrinkWrap: true,
//                                 children: [
//                                   inputselect(
//                                     controller: _country,
//                                     hint: ' ',
//                                     label: 'Country',
//                                     nationality: true,
//                                     listitems: BaseModel.availableCountriesList,
//                                     selectString: 'Select Country',
//                                   ),
//                                   CustomPhoneInputFieldWidget(
//                                       controller: _phone,
//                                       hint: ' ',
//                                       label: 'Phone number',
//                                       onChange: (value) {
//                                         if (_formkey.currentState!.validate()) {
//                                           setState(() {
//                                             active = true;
//                                           });
//                                         }
//                                       }),
//                                   inputselectFunds(
//                                     controller: _fund,
//                                     hint: ' ',
//                                     label: 'Source of funds',
//                                     listItems: state.incomeModel!.incomeSource!,
//                                     selectString: 'Source of funds',
//                                   ),
//                                   InputTextCustom(
//                                       controller: _taxes,
//                                       hint: ' ',
//                                       label: 'Tax number',
//                                       isEmail: false,
//                                       isPassword: false,
//                                       onChanged: () {
//                                         if (_formkey.currentState!.validate()) {
//                                           setState(() {
//                                             active = true;
//                                           });
//                                         }
//                                       }),
//                                   Taxinput(
//                                     controller: _taxcountry,
//                                     hint: ' ',
//                                     label: 'Tax Country',
//                                     nationality: true,
//                                     listitems: BaseModel.availableCountriesList,
//                                     selectString: 'Select Country',
//                                   ),
//                                   InputTextCustom(
//                                       controller: _email,
//                                       hint: 'Why you opening this account ?',
//                                       label: 'purpose of account',
//                                       isEmail: false,
//                                       isPassword: false,
//                                       onChanged: () {
//                                         if (_formkey.currentState!.validate()) {
//                                           setState(() {
//                                             active = true;
//                                           });
//                                         }
//                                       }),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       const Expanded(
//                                           child: Text(
//                                         'Shipping address same as residential address?',
//                                         style: TextStyle(
//                                             color: Color(0xffC4C4C4),
//                                             fontSize: 12,
//                                             fontFamily: 'pop',
//                                             fontWeight: FontWeight.w500),
//                                       )),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       Expanded(
//                                           child: Container(
//                                         height: 48,
//                                         padding: const EdgeInsets.all(5),
//                                         decoration: BoxDecoration(
//                                             color: const Color(0xffE4E3E3),
//                                             borderRadius:
//                                                 BorderRadius.circular(11)),
//                                         child: Row(
//                                           children: [
//                                             Expanded(
//                                                 child: InkWell(
//                                               onTap: () {
//                                                 setState(() {
//                                                   Shipping == true
//                                                       ? Shipping = false
//                                                       : Shipping = true;
//                                                 });
//                                               },
//                                               child: Container(
//                                                 padding:
//                                                     const EdgeInsets.all(10),
//                                                 decoration: BoxDecoration(
//                                                     color: Shipping == true
//                                                         ? const Color(
//                                                             0xff10245C)
//                                                         : Colors.transparent,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             11)),
//                                                 child: const Text(
//                                                   'Yes',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontFamily: 'pop',
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.w500),
//                                                 ),
//                                               ),
//                                             )),
//                                             Expanded(
//                                                 child: InkWell(
//                                               onTap: () {
//                                                 setState(() {
//                                                   Shipping == true
//                                                       ? Shipping = false
//                                                       : Shipping = true;
//                                                 });
//                                               },
//                                               child: Container(
//                                                 padding:
//                                                     const EdgeInsets.all(10),
//                                                 decoration: BoxDecoration(
//                                                     color: Shipping == true
//                                                         ? Colors.transparent
//                                                         : const Color(
//                                                             0xff10245C),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             11)),
//                                                 child: const Text(
//                                                   'No',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontFamily: 'pop',
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.w500),
//                                                 ),
//                                               ),
//                                             )),
//                                           ],
//                                         ),
//                                       ))
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     height: 15,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       const Expanded(
//                                           child: Text(
//                                         'Gender',
//                                         style: TextStyle(
//                                             color: Color(0xffC4C4C4),
//                                             fontSize: 12,
//                                             fontFamily: 'pop',
//                                             fontWeight: FontWeight.w500),
//                                       )),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       Expanded(
//                                           child: Container(
//                                         height: 48,
//                                         padding: const EdgeInsets.all(5),
//                                         decoration: BoxDecoration(
//                                             color: const Color(0xffE4E3E3),
//                                             borderRadius:
//                                                 BorderRadius.circular(11)),
//                                         child: Row(
//                                           children: [
//                                             Expanded(
//                                                 child: InkWell(
//                                               onTap: () {
//                                                 setState(() {
//                                                   male == true
//                                                       ? male = false
//                                                       : male = true;
//                                                 });
//                                               },
//                                               child: Container(
//                                                 padding:
//                                                     const EdgeInsets.all(10),
//                                                 decoration: BoxDecoration(
//                                                     color: male == true
//                                                         ? const Color(
//                                                             0xff10245C)
//                                                         : Colors.transparent,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             11)),
//                                                 child: const Text(
//                                                   'Male',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontFamily: 'pop',
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.w500),
//                                                 ),
//                                               ),
//                                             )),
//                                             Expanded(
//                                                 child: InkWell(
//                                               onTap: () {
//                                                 setState(() {
//                                                   male == true
//                                                       ? male = false
//                                                       : male = true;
//                                                 });
//                                               },
//                                               child: Container(
//                                                 padding:
//                                                     const EdgeInsets.all(10),
//                                                 decoration: BoxDecoration(
//                                                     color: male == true
//                                                         ? Colors.transparent
//                                                         : const Color(
//                                                             0xff10245C),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             11)),
//                                                 child: const Text(
//                                                   'Female',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontFamily: 'pop',
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.w500),
//                                                 ),
//                                               ),
//                                             )),
//                                           ],
//                                         ),
//                                       ))
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   Container(
//                                     margin: const EdgeInsets.symmetric(
//                                         horizontal: 0),
//                                     height: 60,
//                                     width: double.infinity,
//                                     decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(11)),
//                                     child: ElevatedButton(
//                                         onPressed: active
//                                             ? () {
//                                                 if (_formkey.currentState!
//                                                     .validate()) {
//                                                   User.Phonenumber =
//                                                       _phone.text;
//                                                   User.icomesource = _fund.text;
//                                                   User.purpose = _email.text;
//
//                                                   User.Gender = male == true
//                                                       ? 'Male'
//                                                       : 'Female';
//
//                                                   User.sameshipping =
//                                                       Shipping == true
//                                                           ? '1'
//                                                           : '0';
//
//                                                   User.taxincome = _taxes.text;
//
//                                                   if (Shipping == false) {
//                                                     Navigator.pushNamed(context,
//                                                         'Shippingaddress');
//                                                   } else {
//                                                     Navigator.pushNamed(
//                                                         context, 'Step3');
//                                                   }
//                                                 }
//                                               }
//                                             : null,
//                                         style: ElevatedButton.styleFrom(
//                                             backgroundColor:
//                                                 const Color(0xff10245C),
//                                             elevation: 0,
//                                             disabledBackgroundColor:
//                                                 const Color(0xffC4C4C4),
//                                             shadowColor: Colors.transparent,
//                                             minimumSize:
//                                                 const Size.fromHeight(40),
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(11))),
//                                         child: const Text(
//                                           'Continue',
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 15,
//                                               fontFamily: 'pop',
//                                               fontWeight: FontWeight.w500),
//                                         )),
//                                   ),
//                                 ],
//                               ),
//                             )),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ));
//   }
// }
