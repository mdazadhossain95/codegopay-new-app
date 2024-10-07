import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:codegopay/Screens/transfer_screen/transfer_confirmation_screen.dart';
import 'package:codegopay/constant_string/User.dart';
import 'package:codegopay/utils/input_fields/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:flutter_face_api/face_api.dart' as Regula;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:codegopay/Screens/transfer_screen/bloc/transfer_bloc.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:codegopay/utils/validator.dart';
import 'package:flutter_face_api/flutter_face_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'package:dropdown_textfield/dropdown_textfield.dart';

import '../../utils/custom_style.dart';
import '../../widgets/buttons/default_back_button_widget.dart';
import '../../widgets/buttons/primary_button_widget.dart';
import '../../widgets/input_fields/amount_input_field_widget.dart';
import '../../widgets/input_fields/defult_input_field_with_title_widget.dart';
import '../../widgets/main/transaction_user_data_widget.dart';
import '../../widgets/toast/toast_util.dart';

class SendMoneyScreen extends StatefulWidget {
  String? image, name, account, id;

  SendMoneyScreen({Key? key, this.account, this.id, this.image, this.name});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TransferBloc _transferBloc = TransferBloc();
  bool instant = false;
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _sePaSelectorController = TextEditingController();
  final TextEditingController _refrence = TextEditingController(text: '');

  SingleValueDropDownController _iban = new SingleValueDropDownController();
  final _formkey = GlobalKey<FormState>();

  bool bordershoww = false;
  String? ibanid;

  MatchFacesImage? image1;
  MatchFacesImage? image2;

  var faceSdk = FaceSDK.instance;

  var status = "nil";
  var similarityStatus = "nil";
  var livenessStatus = "nil";

  var uiImage1 = Image.asset('images/portrait.png'); // Placeholder image
  var uiImage2 = Image.asset('images/portrait.png');

  String _similarity = "nil";

  // ignore: unused_field
  final String _liveness = "nil";

  Uint8List? bytes;

  getimage() async {
    bytes = (await NetworkAssetBundle(Uri.parse(User.profileimage!))
            .load(User.profileimage!))
        .buffer
        .asUint8List();
  }

  setImage(Uint8List bytes, ImageType type, int number) {
    similarityStatus = "nil";
    var mfImage = MatchFacesImage(bytes, type);
    if (number == 1) {
      image1 = mfImage;
      uiImage1 = Image.memory(bytes);
      livenessStatus = "nil";
    }
    if (number == 2) {
      image2 = mfImage;
      uiImage2 = Image.memory(bytes);
    }
  }

  @override
  void initState() {
    super.initState();
    _transferBloc.add(SepatypesEvent());

    User.Screen = 'send money';
    _transferBloc.add(getibanlistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _transferBloc,
      listener: (context, TransferState state) {
        if (state.sendmoneyModel?.status == 0) {

          CustomToast.showError(
              context, "Sorry!", state.sendmoneyModel!.message!);
        } else if (state.sendmoneyModel?.status == 1) {
          Navigator.push(
              context,
              PageTransition(
                child: TransferConfirmationScreen(
                  amount: state.sendmoneyModel!.amount!,
                  bic: state.sendmoneyModel!.bic!,
                  commision: state.sendmoneyModel!.commission!,
                  date: state.sendmoneyModel!.date!,
                  iban: state.sendmoneyModel!.iban!,
                  name: state.sendmoneyModel!.name!,
                  refesnce: state.sendmoneyModel!.referncepayment!,
                  type: state.sendmoneyModel!.paymentoption!,
                  id: state.sendmoneyModel!.uniqueid!,
                  image: widget.image!,
                ),
                type: PageTransitionType.bottomToTop,
                alignment: Alignment.center,
                duration: const Duration(milliseconds: 300),
                reverseDuration: const Duration(milliseconds: 200),
              ));
        }

      },
      child: BlocBuilder(
        bloc: _transferBloc,
        builder: (context, TransferState state) {
          return ProgressHUD(
            inAsyncCall: state.isloading,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: CustomColor.whiteColor,
              body: SafeArea(
                  bottom: false,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 30, top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    DefaultBackButtonWidget(onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          'beneficiaryListScreen',
                                          (route) => false);
                                    }),
                                    Text(
                                      '',
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
                              ),
                              TransactionUserDataWidget(
                                name: widget.name!,
                                iban: widget.account!,
                                image: widget.image!,
                              ),
                              Form(
                                key: _formkey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AmountInputField(
                                      controller: _amount,
                                      label: "Transfer Amount",
                                      // Custom label
                                      currencySymbol: '€',
                                      autofocus: true,
                                      minAmount: 0,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    DefaultInputFieldWithTitleWidget(
                                      controller: _refrence,
                                      title: 'Reference',
                                      hint: 'Reference',
                                      isEmail: false,
                                      keyboardType: TextInputType.name,
                                      isPassword: false,
                                    ),
                                    state.ibanlistModel!.ibaninfo!.isNotEmpty
                                        ? DropDownTextField(
                                            controller: _iban,
                                            clearOption: false,
                                            validator: (value) {
                                              return Validator.validateValues(
                                                value: value,
                                              );
                                            },
                                            readOnly: true,
                                            dropDownIconProperty: IconProperty(
                                                icon: Icons.keyboard_arrow_down,
                                                color: CustomColor.black),
                                            textFieldDecoration:
                                                InputDecoration(
                                              filled: true,
                                              fillColor: bordershoww
                                                  ? CustomColor.whiteColor
                                                  : CustomColor
                                                      .primaryInputHintColor,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              hintText: 'Select Iban',
                                              hintStyle: CustomStyle
                                                  .loginInputTextHintStyle,
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: bordershoww
                                                        ? CustomColor
                                                            .primaryColor
                                                        : CustomColor
                                                            .primaryInputHintBorderColor,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          11)),
                                              errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color:
                                                        CustomColor.errorColor,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          11)),
                                              errorMaxLines: 2,
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: CustomColor
                                                            .errorColor,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              11)),
                                              errorStyle: const TextStyle(
                                                color: CustomColor.errorColor,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: CustomColor
                                                        .primaryInputHintBorderColor,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          11)),
                                              border: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: CustomColor
                                                        .primaryInputHintBorderColor,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          11)),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: CustomColor
                                                            .primaryInputHintBorderColor,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              11)),
                                              enabled: true,
                                            ),
                                            textStyle: GoogleFonts.inter(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: CustomColor.black),
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            dropDownItemCount: state
                                                .ibanlistModel!
                                                .ibaninfo!
                                                .length,
                                            dropDownList: [
                                              for (int i = 0;
                                                  i <
                                                      state.ibanlistModel!
                                                          .ibaninfo!.length;
                                                  i++)
                                                DropDownValueModel(
                                                    name: state.ibanlistModel!
                                                        .ibaninfo![i].label!,
                                                    value: state.ibanlistModel!
                                                        .ibaninfo![i].ibanId!),
                                            ],
                                            onChanged: (val) {
                                              print(val.value);

                                              ibanid = val.value.toString();

                                              setState(() {
                                                val == null
                                                    ? bordershoww = false
                                                    : bordershoww = true;
                                              });
                                            },
                                          )
                                        : Container()
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 41,
                                child: Row(
                                  children: [
                                    // state.sepatypesmodel!.types!.instant == ''
                                    //     ? Container()
                                    //     : Expanded(
                                    //         child: InkWell(
                                    //           onTap: () {
                                    //             setState(() {
                                    //               instant = true;
                                    //             });
                                    //           },
                                    //           child: Container(
                                    //             height: 41,
                                    //             alignment: Alignment.center,
                                    //             decoration: BoxDecoration(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(11),
                                    //               color: instant
                                    //                   ? const Color(0xff10245C)
                                    //                   : const Color(0xffE4E3E3),
                                    //             ),
                                    //             child: Text(
                                    //               state.sepatypesmodel!.types!
                                    //                   .instant!,
                                    //               style: const TextStyle(
                                    //                   color: Colors.white,
                                    //                   fontSize: 12,
                                    //                   fontFamily: 'pop',
                                    //                   fontWeight:
                                    //                       FontWeight.w500),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ),
                                    // state.sepatypesmodel!.types!.sepa == ''
                                    //     ? Container()
                                    //     : Expanded(
                                    //         child: InkWell(
                                    //           onTap: () {
                                    //             setState(() {
                                    //               instant = false;
                                    //             });
                                    //           },
                                    //           child: Container(
                                    //             height: 41,
                                    //             alignment: Alignment.center,
                                    //             decoration: BoxDecoration(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(11),
                                    //               color: instant
                                    //                   ? const Color(0xffE4E3E3)
                                    //                   : const Color(0xff10245C),
                                    //             ),
                                    //             child: Text(
                                    //               state.sepatypesmodel!.types!
                                    //                   .sepa!,
                                    //               style: const TextStyle(
                                    //                   color: Colors.white,
                                    //                   fontSize: 12,
                                    //                   fontFamily: 'pop',
                                    //                   fontWeight:
                                    //                       FontWeight.w500),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       )

                                    state.sepatypesmodel!.types!.instant == ''
                                        ? Container()
                                        : SelectableButton(
                                            title: state.sepatypesmodel!.types!
                                                .instant!,
                                            isSelected: instant,
                                            onTap: () {
                                              setState(() {
                                                instant = true;
                                              });
                                            },
                                          ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    state.sepatypesmodel!.types!.sepa == ''
                                        ? Container()
                                        : SelectableButton(
                                            title: state
                                                .sepatypesmodel!.types!.sepa!,
                                            isSelected: !instant,
                                            onTap: () {
                                              setState(() {
                                                instant = false;
                                              });
                                            },
                                          ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                        PrimaryButtonWidget(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              _transferBloc.add(SendmoneyEvent(
                                  amount: _amount.text,
                                  paymentoption:
                                      instant ? 'sepa instant' : 'sepa normal',
                                  refrence: _refrence.text,
                                  uniquid: widget.id,
                                  iban: ibanid));
                            }
                          },
                          buttonText: 'Next',
                        ),
                      ],
                    ),
                  )),
              // bottomNavigationBar: CustomBottomBar(index: 0),
            ),
          );
        },
      ),
    );
  }
}

class SelectableButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          // height: 41,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSelected
                ? CustomColor.primaryColor
                : CustomColor.transactionFromContainerColor,
            border: Border.all(
              color: isSelected
                  ? Color(0xff007AFF)
                  : CustomColor.transactionFromContainerColor,
              // Change border color based on selection
              width: 2, // Adjust the border width if needed
            ),
          ),
          child: Text(
            title,
            style: GoogleFonts.inter(
              color: isSelected
                  ? CustomColor.whiteColor
                  : CustomColor.inputFieldTitleTextColor,
              // Change text color based on selection
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
