import 'dart:async';

import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/features/membership_level/controller/membership_controller.dart';
import 'package:candela_maker/src/widgets/primary_button.dart';
import 'package:candela_maker/src/widgets/input_field_title.dart';
import 'package:candela_maker/src/widgets/text_input-field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/route_manager.dart';

import '../../membership_level/membership_level.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../sign_in/sign_in_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormBuilderState>();
  Timer? _timer = Timer.periodic(const Duration(seconds: 5), (timer) {});
  bool isLoading = false;
  List<String> membershipOptions = ['Level 1', 'Level 2', 'Level 3', 'Level 4'];

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
                      TextInputField(
                        name: "fullname",
                        validator: FormBuilderValidators.required(
                            errorText: "Full name can not be empty"),
                      ),
                      const SizedBox(height: 21),
                      const InputTitle(title: "Address"),
                      const SizedBox(height: 9),
                      const TextInputField(name: "address"),
                      const SizedBox(height: 21),
                      const InputTitle(title: "Email"),
                      const SizedBox(height: 9),
                      TextInputField(
                          name: "email",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: "email can not be empty"),
                            FormBuilderValidators.email(
                                errorText: "Please enter valid email")
                          ])),
                      const SizedBox(height: 21),
                      const InputTitle(title: "User Name"),
                      const SizedBox(height: 9),
                      TextInputField(
                        name: "username",
                        validator: FormBuilderValidators.required(
                            errorText: "username can not be empty"),
                      ),
                      const SizedBox(height: 21),
                      const InputTitle(title: "Password"),
                      const SizedBox(height: 9),
                      TextInputField(
                        name: "password",
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: "Password can not be empty"),
                          FormBuilderValidators.minLength(6,
                              errorText: "Password at least 6 characters long"),
                        ]),
                      ),
                      const SizedBox(height: 21),
                      const InputTitle(title: "Phone Number"),
                      const SizedBox(height: 9),
                      FormBuilderPhoneField(
                        style: const TextStyle(
                            color: kTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        cursorColor: Colors.white,
                        name: 'phonenumber',
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
                        name: "membershiplevel",
                        initialValue: membershipOptions[0],
                        dropdownColor: kBlackColor,
                        items: membershipOptions
                            .map((level) => DropdownMenuItem(
                                  alignment: AlignmentDirectional.centerStart,
                                  value: level,
                                  child: Text(
                                    level,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ))
                            .toList(),
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
                      const InputTitle(title: "Bank Name"),
                      const SizedBox(height: 9),
                      const TextInputField(name: "bankname"),
                      const SizedBox(height: 21),
                      const InputTitle(title: "Bank Routing Number"),
                      const SizedBox(height: 9),
                      const TextInputField(name: "bankroutingnumber"),
                      const SizedBox(height: 21),
                      const InputTitle(title: "Bank Account Number"),
                      const SizedBox(height: 9),
                      const TextInputField(name: "bankaccountnumber"),
                      const SizedBox(height: 21),
                      const SizedBox(height: 21),
                      FormBuilderImagePicker(
                        previewHeight: 29,
                        placeholderImage:
                            const AssetImage("assets/images/upload_photo.png"),
                        name: "image",
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
                      isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: kPrimaryColor,
                            ))
                          : PrimaryButton(
                              btnName: "Register",
                              press: () async {
                                if (_formKey.currentState!.saveAndValidate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  createAccount();
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
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

  void createAccount() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final email = _formKey.currentState!.fields['email']!.value.toString();
    final password =
        _formKey.currentState!.fields['password']!.value.toString();
    await AuthService().register(email, password).then((uid) async {
      User? user = auth.currentUser;
      final usermodel = UserModel(
        id: user!.uid,
        email: user.email,
        fullName: _formKey.currentState!.fields['fullname']!.value.toString(),
        address: _formKey.currentState!.fields['address']!.value.toString(),
        userName: _formKey.currentState!.fields['username']!.value.toString(),
        phoneNumber:
            _formKey.currentState!.fields['phonenumber']!.value.toString(),
        membershipLevel:
            _formKey.currentState!.fields['membershiplevel']!.value.toString(),
        bankName: _formKey.currentState!.fields['bankname']!.value.toString(),
        bankRoutingNumber: _formKey
            .currentState!.fields['bankroutingnumber']!.value
            .toString(),
        bankAccNumber: _formKey.currentState!.fields['bankaccountnumber']!.value
            .toString(),
        photoUrl: "",
        language: _formKey.currentState!.fields['language']!.value.toString(),
      );

      await FireStoreService().createUser(usermodel, user);
      Fluttertoast.showToast(msg: "Account was created successfully!");
    });

    Get.off(() => const SignInScreen());
  }
}
