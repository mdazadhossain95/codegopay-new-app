import 'dart:async';

import 'package:codegopay/Screens/Dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:codegopay/constant_string/User.dart';
import 'package:codegopay/cutom_weidget/cutom_progress_bar.dart';
import 'package:codegopay/utils/input_fields/custom_color.dart';
import 'package:codegopay/utils/user_data_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../utils/custom_date_picker.dart';
import '../../widgets/buttons/default_back_button_widget.dart';
import '../../widgets/toast/toast_util.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _formkey = GlobalKey<FormState>();

  DateTime? _fromDate;
  DateTime? _toDate;
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    DateTime initialDate = DateTime.now();
    if (isFromDate && _fromDate != null) {
      initialDate = _fromDate!;
    } else if (!isFromDate && _toDate != null) {
      initialDate = _toDate!;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = picked;
          _fromDateController.text = _dateFormat.format(picked);
        } else {
          _toDate = picked;
          _toDateController.text = _dateFormat.format(picked);
        }
      });
    }
  }

  void _export() {
    if (_fromDate != null && _toDate != null) {
      final String fromDate = _dateFormat.format(_fromDate!);
      final String toDate = _dateFormat.format(_toDate!);
      // Add your export logic here
      print('Exporting data from $fromDate to $toDate');
    } else {
      // Handle empty fields
      print('Please select both dates.');
    }
  }

  void _onDateSelected(DateTime date) {
    // Add your logic when a date is selected, if needed
    print('Selected date: $date');
  }

  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  String trx_uniquid = '';

  final DashboardBloc _dashboardBloc = DashboardBloc();

  @override
  void initState() {
    super.initState();
    User.Screen = 'Transaction Screen';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      body: BlocListener(
          bloc: _dashboardBloc,
          listener: (context, DashboardState state) async {
            if (state.statusModel?.status == 0) {
              CustomToast.showError(
                  context, "Sorry!", state.statusModel!.message!);
            }

            if (state.statusModel?.status == 1) {
              CustomToast.showSuccess(
                  context, "Thank You!", state.statusModel!.message!);
              Navigator.pop(context);
            }
          },
          child: BlocBuilder(
              bloc: _dashboardBloc,
              builder: (context, DashboardState state) {
                return SafeArea(
                  child: ProgressHUD(
                    inAsyncCall: state.isloading,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appBarSection(context, state),
                        Container(
                          height: 150,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: CustomDatePicker(
                                        controller: _fromDateController,
                                        label: 'From',
                                        hint: 'YYYY-MM-DD',
                                        onDateSelected: (date) {
                                          setState(() {
                                            _fromDate = date;
                                            _fromDateController.text =
                                                _dateFormat.format(date);
                                          });
                                          _onDateSelected(date);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CustomDatePicker(
                                        controller: _toDateController,
                                        label: 'To',
                                        hint: 'YYYY-MM-DD',
                                        onDateSelected: (date) {
                                          setState(() {
                                            _toDate = date;
                                            _toDateController.text =
                                                _dateFormat.format(date);
                                          });
                                          _onDateSelected(date);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 48,
                                        margin: const EdgeInsets.only(top: 20),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (_formkey.currentState!
                                                .validate()) {
                                              if (_fromDate != null &&
                                                  _toDate != null) {
                                                final String fromDate =
                                                    _dateFormat
                                                        .format(_fromDate!);
                                                final String toDate =
                                                    _dateFormat
                                                        .format(_toDate!);

                                                UserDataManager()
                                                    .setFromDateSave(fromDate);
                                                UserDataManager()
                                                    .setToDateSave(toDate);

                                                _dashboardBloc.add(
                                                    DownloadTransactionStatementEvent());

                                                // Add your search logic here
                                                print(
                                                    'Searching from $fromDate to $toDate');
                                              } else {
                                                // Handle empty fields
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Please select both dates.'),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor:
                                                CustomColor.primaryColor,
                                            backgroundColor:
                                                CustomColor.primaryColor,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(48),
                                            ),
                                          ),
                                          child: Text(
                                            'Send Statement To Email',
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: CustomColor.whiteColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
      // bottomNavigationBar: CustomBottomBar(index: 0),
    );
  }

  appBarSection(BuildContext context, state) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultBackButtonWidget(
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Text(
            'Export PDF',
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
    );
  }
}
