import 'dart:async';

import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/features/membership_level/controller/membership_controller.dart';
import 'package:candela_maker/src/widgets/primary_button.dart';
import 'package:candela_maker/src/widgets/input_field_title.dart';
import 'package:candela_maker/src/widgets/text_input-field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../membership_level/membership_level.dart';
import '../vip_agreement/vip_agreement_send_request.dart';

class Register5 extends StatefulWidget {
  const Register5({super.key});

  @override
  State<Register5> createState() => _Register5State();
}



class _Register5State extends State<Register5> {
  final _formKey = GlobalKey<FormBuilderState>();
  Timer? _timer = Timer.periodic(const Duration(seconds: 5), (timer) {});
  final membershipController = Get.put(MembershipController());
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (membershipController.membershipLevel.value == 0) {
        Get.to(() => const MembershipLevel());
      }
   
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: kDefaultPadding,
            child: Column(
              children: [
                const SizedBox(height: 25),
                const Text(
                  "REGISTER",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(height: 21),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const InputTitle(title: "Full Legal Name"),
                      const SizedBox(height: 9),
                      const TextInputField(name: "legal full name"),
                      const SizedBox(height: 21),
                      const InputTitle(title: "Address"),
                      const SizedBox(height: 9),
                      const TextInputField(name: "address"),
                      const SizedBox(height: 21),
                      const InputTitle(title: "Email"),
                      const SizedBox(height: 9),
                      const TextInputField(name: "email"),
                      const SizedBox(height: 21),
                      const InputTitle(title: "User Name"),
                      const SizedBox(height: 9),
                      const TextInputField(name: "user name"),
                      const SizedBox(height: 21),
                      const InputTitle(title: "Password"),
                      const SizedBox(height: 9),
                      const TextInputField(name: "password"),
                      const SizedBox(height: 21),
                      const InputTitle(title: "Phone Number"),
                      const SizedBox(height: 9),
                      FormBuilderPhoneField(
                        style: const TextStyle(
                            color: kTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        cursorColor: Colors.white,
                        name: 'phone',
                        backgroundColor: Colors.white,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(top: 0.0, left: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 21),
                      const InputTitle(title: "Membership Level"),
                      const SizedBox(height: 9),
                      FormBuilderDropdown(
                        name: "membershipLevel",
                        items: const [],
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(top: 0.0, left: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 21),
                      FormBuilderImagePicker(
                        previewHeight: 29,
                        placeholderImage:
                            const AssetImage("assets/images/upload_photo.png"),
                        name: "Image",
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 0.0, left: 10.0),
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 21),
                      FormBuilderRadioGroup(
                        name: "language",
                        initialValue: "English",
                        wrapAlignment: WrapAlignment.spaceAround,
                        activeColor: const Color(0xFFE6A220),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 0.0, left: 10.0),
                        ),
                        options: const [
                          FormBuilderChipOption(
                            value: "English",
                            child: Text(
                              "English",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          FormBuilderChipOption(
                            value: "Spanish",
                            child: Text(
                              "Spanish",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      PrimaryButton(
                        btnName: "Register",
                        press: () {
                          Get.to(() => const VIPAgreementSendRequest());
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
