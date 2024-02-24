// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/features/vip_report/widgets/vip_payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateAndTimeRangePickerForm extends StatefulWidget {
  final Future<void> Function() fetchDataCallback;
  const DateAndTimeRangePickerForm({
    super.key,
    required this.fetchDataCallback,
  });

  @override
  _DateAndTimeRangePickerFormState createState() =>
      _DateAndTimeRangePickerFormState();
}

class _DateAndTimeRangePickerFormState
    extends State<DateAndTimeRangePickerForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final vipPaymentController = Get.put(VipReportController());
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // Override the text theme for your form
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white, // Change text color to white
              displayColor: Colors.white, // Change display text color to white
            ),
        // Use this to change input decoration label style specifically
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle:
              TextStyle(color: Colors.white), // Change label color to white
        ),
      ),
      child: FormBuilder(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              FormBuilderDateTimePicker(
                name: 'date_start',
                initialEntryMode: DatePickerEntryMode.calendar,
                format: DateFormat('yyyy-MM-dd HH:mm'),
                decoration: const InputDecoration(
                  labelText: 'Start Date and Time',
                ),
              ),
              FormBuilderDateTimePicker(
                name: 'date_end',
                initialEntryMode: DatePickerEntryMode.calendar,
                format: DateFormat('yyyy-MM-dd HH:mm'),
                decoration: const InputDecoration(
                  labelText: 'End Date and Time',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      kPrimaryColor, // Make sure kPrimaryColor is defined somewhere
                  textStyle: const TextStyle(
                      color: Colors
                          .white), // This may not be necessary if your button text is already styled
                ),
                child: const Text(
                  'Generate',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    // Extracting the form values
                    var formValue = _formKey.currentState!.value;
                    DateTime startDate = formValue['date_start'];
                    DateTime endDate = formValue['date_end'];

                    // Using the VipReportController to set the start and end dates
                    vipPaymentController.setStartDate(startDate);
                    vipPaymentController.setEndDate(endDate);

                    // Optionally, navigate to another page or show a confirmation message
                    // Get.snackbar('Success', 'Date range updated successfully!',
                    //     snackPosition: SnackPosition.BOTTOM);
                    vipPaymentController.isCustomSearch.value = true;
                    widget.fetchDataCallback();
                    print(_formKey.currentState!.value);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
