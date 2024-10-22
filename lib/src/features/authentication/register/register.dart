import 'dart:io';
import 'package:candela_maker/src/common_widgets/account_check.dart';
import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/widgets/primary_button.dart';
import 'package:candela_maker/src/widgets/input_field_title.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:candela_maker/src/widgets/text_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
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
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? imageUrl;
  late File file;
  bool isLoading = false;
  List<String> membershipOptions = [
    'Level 0',
    'Level 1',
    'Level 2',
    'Level 3',
    'Level 4'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgColor,
        appBar: AppBar(
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
          centerTitle: true,
          foregroundColor: kTextColor,
          title: const Text(
            "REGISTER",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: kPrimaryColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: kDefaultPadding,
            child: Column(
              children: [
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const InputTitle(title: "Full Legal Name"),
                      const SizedBox(height: 9),
                      TextInputField(
                        name: "fullname",
                        keyboard: TextInputType.name,
                        validator: FormBuilderValidators.required(
                            errorText: "Full name can not be empty"),
                      ),
                      const SizedBox(height: 21),
                      const InputTitle(title: "Address"),
                      const SizedBox(height: 9),
                      TextInputField(
                          name: "address",
                          keyboard: TextInputType.streetAddress,
                          validator: FormBuilderValidators.required(
                              errorText: "Address can not be empty")),
                      const SizedBox(height: 21),
                      const InputTitle(title: "Email"),
                      const SizedBox(height: 9),
                      TextInputField(
                          name: "email",
                          keyboard: TextInputType.emailAddress,
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
                        keyboard: TextInputType.text,
                        validator: FormBuilderValidators.required(
                            errorText: "username can not be empty"),
                      ),
                      const SizedBox(height: 21),
                      const InputTitle(title: "Password"),
                      const SizedBox(height: 9),
                      TextInputField(
                        name: "password",
                        keyboard: TextInputType.visiblePassword,
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
                        validator: FormBuilderValidators.required(
                            errorText: "Phone number can not be empty"),
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
                      Row(
                        children: [
                          const InputTitle(title: "Membership Level"),
                          const SizedBox(width: 9),
                          InkWell(
                            onTap: () {
                              Get.to(() => const MembershipLevel());
                            },
                            child: const Icon(
                              Icons.info_outlined,
                              color: kTextColor,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 9),
                      FormBuilderDropdown(
                        name: "membershiplevel",
                        initialValue: membershipOptions[0],
                        validator: FormBuilderValidators.required(
                            errorText: "Membership level can not be empty"),
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
                      // const InputTitle(title: "Bank Name"),
                      // const SizedBox(height: 9),
                      // TextInputField(
                      //     name: "bankname",
                      //     validator: FormBuilderValidators.required(
                      //         errorText: "Bank name can not be empty"),
                      //     keyboard: TextInputType.text),
                      // const SizedBox(height: 21),
                      // const InputTitle(title: "Bank Routing Number"),
                      // const SizedBox(height: 9),
                      // TextInputField(
                      //     name: "bankroutingnumber",
                      //     validator: FormBuilderValidators.required(
                      //         errorText:
                      //             "Bank routing number can not be empty"),
                      //     keyboard: TextInputType.number),
                      // const SizedBox(height: 21),
                      // const InputTitle(title: "Bank Account Number"),
                      // const SizedBox(height: 9),
                      // TextInputField(
                      //     name: "bankaccountnumber",
                      //     validator: FormBuilderValidators.required(
                      //         errorText:
                      //             "Bank account number can not be empty"),
                      //     keyboard: TextInputType.number),
                      // const SizedBox(height: 21),
                      const InputTitle(title: "Set Price per Song"),
                      const SizedBox(height: 9),
                      TextInputField(
                          name: "songprice",
                          validator: FormBuilderValidators.required(
                              errorText: "Song price can not be empty"),
                          keyboard: TextInputType.number),
                      const SizedBox(height: 21),
                      // Row(
                      //   children: [
                      //     Image.asset(
                      //       "assets/images/upload_photo.png",
                      //       height: 50,
                      //       width: 50,
                      //     ),
                      //     const SizedBox(width: 10),
                      //     InkWell(
                      //       onTap: () async {
                      //         final picker = ImagePicker();
                      //         XFile? image = await picker.pickImage(
                      //             source: ImageSource.camera);
                      //         file = File(image!.path);
                      //       },
                      //       child: const Text(
                      //         "Upload Photo",
                      //         style: TextStyle(
                      //             color: kTextColor,
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w500),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      // const SizedBox(height: 21),
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
                      const SizedBox(height: 20),
                      isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: kPrimaryColor,
                            ))
                          : PrimaryButton(
                              btnName: "Register",
                              press: () async {
                                if (_formKey.currentState!.saveAndValidate()) {
                                  createAccount();
                                }
                              },
                            ),
                      const SizedBox(height: 10),
                      const AccountCheck(login: false),
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

  uploadImage(userId) async {
    final firebaseStorage = FirebaseStorage.instance;

    var snapshot = await firebaseStorage
        .ref()
        .child('image/$userId')
        .putFile(file)
        .whenComplete(() => print('Image Uploaded'));

    String downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      imageUrl = downloadUrl;
    });
  }

  void createAccount() async {
    setState(() {
      isLoading = true;
    });

    final FirebaseAuth auth = FirebaseAuth.instance;
    final email = _formKey.currentState!.fields['email']!.value.toString();
    final password =
        _formKey.currentState!.fields['password']!.value.toString();
    await AuthService().register(email, password).then((uid) async {
      if (uid != null) {
        User? user = auth.currentUser;
        // uploadImage(user!.uid);
        final usermodel = UserModel(
          id: user!.uid,
          email: user.email,
          fullName: _formKey.currentState!.fields['fullname']!.value.toString(),
          address: _formKey.currentState!.fields['address']!.value.toString(),
          userName: _formKey.currentState!.fields['username']!.value.toString(),
          phoneNumber:
              _formKey.currentState!.fields['phonenumber']!.value.toString(),
          membershipLevel: _formKey
              .currentState!.fields['membershiplevel']!.value
              .toString(),
          // bankName: _formKey.currentState!.fields['bankname']!.value.toString(),
          // bankRoutingNumber: _formKey
          //     .currentState!.fields['bankroutingnumber']!.value
          //     .toString(),
          // bankAccNumber: _formKey
          //     .currentState!.fields['bankaccountnumber']!.value
          //     .toString(),
          // photoUrl: imageUrl ?? '',
          language: _formKey.currentState!.fields['language']!.value.toString(),
          songPrice:
              _formKey.currentState!.fields['songprice']!.value.toString(),
        );
        await FireStoreService().createUser(usermodel, user);

        Fluttertoast.showToast(msg: "Account was created successfully!");
        Get.off(() => const SignInScreen());
      } else {
        Fluttertoast.showToast(msg: "Account creation failed!");
      }
    });
    
    setState(() {
      isLoading = false;
    });
  }
}
