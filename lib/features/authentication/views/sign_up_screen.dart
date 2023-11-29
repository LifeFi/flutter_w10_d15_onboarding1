import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_w10_d15_onboarding1/constants/gaps.dart';
import 'package:flutter_w10_d15_onboarding1/constants/sizes.dart';
import 'package:flutter_w10_d15_onboarding1/features/authentication/views/agree_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _birthdayController = TextEditingController();

  bool isAgree = false;
  bool isEmail = true;
  bool isShowDatePicker = false;
  DateTime initialDate = DateTime.now();

  Map<String, String> formData = {};

  @override
  void initState() {
    super.initState();
    _setTextFieldDate(initialDate);
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  _showDatePicker() {
    setState(() {
      isShowDatePicker = !isShowDatePicker;
    });
  }

  _onSubmitTap() async {
    if (!isAgree) {
      isAgree = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AgreeScreen(),
            ),
          ) ??
          false;
      setState(() {});
    } else {
      if (_formKey.currentState != null) {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("$formData $isAgree"),
              );
            },
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  top: 15,
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      fontSize: Sizes.size20, fontWeight: FontWeight.w500),
                )),
          ),
          leadingWidth: 100,
          title: FaIcon(
            FontAwesomeIcons.twitter,
            size: Sizes.size36,
            color: Theme.of(context).primaryColor,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size20,
            ),
            child: Form(
              key: _formKey,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v32,
                  const Text(
                    "Create your account",
                    style: TextStyle(
                      fontSize: Sizes.size28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Gaps.v32,
                  TextFormField(
                    style: TextStyle(
                      fontSize: Sizes.size18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                      labelText: "Name",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      suffix: formData["name"] != null &&
                              formData["name"]!.isNotEmpty
                          ? const FaIcon(
                              FontAwesomeIcons.solidCircleCheck,
                              color: Colors.green,
                              size: Sizes.size32,
                            )
                          : null,
                    ),
                    cursorColor: Theme.of(context).primaryColor,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Please write your name";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['name'] = newValue;
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        formData['name'] = value;
                      });
                    },
                  ),
                  Gaps.v10,
                  TextFormField(
                    style: TextStyle(
                      fontSize: Sizes.size18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                    decoration: InputDecoration(
                      hintText: "Phone number or email address",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                      labelText: isEmail ? "Email" : "Phone",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      suffix: formData["email"] != null &&
                              formData["email"]!.isNotEmpty
                          ? const FaIcon(
                              FontAwesomeIcons.solidCircleCheck,
                              color: Colors.green,
                              size: Sizes.size32,
                            )
                          : null,
                    ),
                    cursorColor: Theme.of(context).primaryColor,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Please write your Phone number or email address";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['email'] = newValue;
                      }
                    },
                    onChanged: (value) {
                      setState(
                        () {
                          formData['email'] = value;
                        },
                      );
                    },
                  ),
                  Gaps.v10,
                  TextFormField(
                    // enabled: false,
                    readOnly: true,
                    controller: _birthdayController,
                    style: TextStyle(
                      fontSize: Sizes.size18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                    decoration: InputDecoration(
                      hintText: "Date of birth",
                      hintStyle: const TextStyle(
                        fontSize: Sizes.size18,
                      ),
                      labelText: "Date of birth",
                      labelStyle: const TextStyle(
                        fontSize: Sizes.size18,
                        fontWeight: FontWeight.normal,
                      ),
                      helperText:
                          "This will not be shown publicly. Confirm your own age, even if this account is for a business, a pet, or something else.",
                      helperStyle: const TextStyle(fontSize: Sizes.size16),
                      helperMaxLines: 5,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    cursorColor: Theme.of(context).primaryColor,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Please write Birthday";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['birthday'] = newValue;
                      }
                    },
                    onChanged: (value) {
                      setState(
                        () {
                          formData['birthday'] = value;
                        },
                      );
                    },
                    onTap: _showDatePicker,
                  ),
                  Stack(
                    children: [
                      Positioned(
                          // bottom: 100,
                          // width: MediaQuery.of(context).size.width,
                          child: Container(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                          bottom: 30,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: _formKey.currentState != null &&
                                      _formKey.currentState!.validate()
                                  ? _onSubmitTap
                                  : null,
                              child: isAgree
                                  ? Container(
                                      height: Sizes.size64,
                                      // width: Sizes.size96,
                                      alignment: const Alignment(0, 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: const Text(
                                        "Sign up",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Sizes.size24,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )
                                  : Align(
                                      heightFactor: 1,
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        height: Sizes.size52,
                                        width: Sizes.size96,
                                        alignment: const Alignment(0, 0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(26),
                                          color:
                                              _formKey.currentState != null &&
                                                      _formKey.currentState!
                                                          .validate()
                                                  ? Colors.black
                                                  : Colors.grey,
                                        ),
                                        child: const Text(
                                          "Next",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: Sizes.size20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                            ),
                            if (isShowDatePicker)
                              SizedBox(
                                height: 200,
                                child: CupertinoDatePicker(
                                  maximumDate: initialDate,
                                  initialDateTime: initialDate,
                                  mode: CupertinoDatePickerMode.date,
                                  onDateTimeChanged: _setTextFieldDate,
                                ),
                              )
                          ],
                        ),
                      ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        /* bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.only(bottom: 40, left: 20, right: 20, top: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: _formKey.currentState != null &&
                        _formKey.currentState!.validate()
                    ? _onSubmitTap
                    : null,
                child: isAgree
                    ? Container(
                        height: Sizes.size64,
                        // width: Sizes.size96,
                        alignment: const Alignment(0, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size24,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    : Align(
                        heightFactor: 1,
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: Sizes.size52,
                          width: Sizes.size96,
                          alignment: const Alignment(0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            color: _formKey.currentState != null &&
                                    _formKey.currentState!.validate()
                                ? Colors.black
                                : Colors.grey,
                          ),
                          child: const Text(
                            "Next",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  maximumDate: initialDate,
                  initialDateTime: initialDate,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: _setTextFieldDate,
                ),
              ),
            ],
          ),
        ), */
      ),
    );
  }
}
