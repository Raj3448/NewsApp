import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headline_hub/constant/app_theme.dart';
import 'package:headline_hub/pages/Auth/auth_otp_view.dart';
import 'package:headline_hub/pages/Auth/cubit/auth_cubit.dart';
import 'package:zapx/zapx.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _selectedCountryCode = '';
  final TextEditingController _phoneNumberController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  bool selected = false;

  final FocusNode _countryFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xfffaf9f6),
      appBar: AppBar(
        backgroundColor: AppTheme.secondaryColor,
        leading: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      body: GestureDetector(
        onTap: () {
          if (_phoneFocusNode.hasFocus) {
            _phoneFocusNode.unfocus();
          }
        },
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthGetSuccess) {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.bounceInOut;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return AuthOtpView(
                      mobileNumberDetails: (
                        _selectedCountryCode,
                        _phoneNumberController.text
                      ),
                      verificationCode: state.verificationCode,
                    );
                  },
                ),
              );
              context.read<AuthCubit>().setToAuthInitial();
            }
          },
          builder: (context, state) => SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: screenSize.height * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter your mobile number',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Text(
                          'We need to verify your number',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Mobile Number *',
                          style: AppTheme.copyWith(
                              color: AppTheme.primaryColor, fontSize: 14),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 80,
                              child: DropdownButton2(
                                  isExpanded: true,
                                  alignment: Alignment.center,
                                  buttonStyleData: ButtonStyleData(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 2,
                                          color: _countryFocusNode.hasFocus
                                              ? AppTheme.primaryColor
                                              : Colors.grey),
                                    ),
                                  ),
                                  underline: Text(
                                    _selectedCountryCode.isEmpty
                                        ? 'Code'
                                        : _selectedCountryCode,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 16),
                                  ).paddingOnly(left: 10),
                                  items: const [
                                    '+11',
                                    '+91',
                                    '+44',
                                    '+86',
                                    '+22',
                                    '+59',
                                    '+62'
                                  ].map<DropdownMenuItem<String>>((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                    );
                                  }).toList(),
                                  focusNode: _countryFocusNode,
                                  onChanged: (identifier) {
                                    setState(() {
                                      _selectedCountryCode = identifier!;
                                    });
                                  }),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: TextFormField(
                                  controller: _phoneNumberController,
                                  keyboardType: TextInputType.phone,
                                  focusNode: _phoneFocusNode,
                                  decoration: InputDecoration(
                                      hintText: 'Enter mobile no',
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: AppTheme.primaryColor,
                                              width: 2))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ).paddingAll(20),
                  ),
                  Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              _phoneNumberController.text.length == 10 &&
                                      _selectedCountryCode.isNotEmpty
                                  ? AppTheme.primaryColor
                                  : Colors.grey,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            fixedSize: MaterialStatePropertyAll(Size(
                                screenSize.width * 0.8,
                                screenSize.height * 0.06))),
                        onPressed: _phoneNumberController.text.length == 10 &&
                                _selectedCountryCode.isNotEmpty
                            ? () {
                                context.read<AuthCubit>().submitAndGetOTP(
                                    _phoneNumberController.text
                                        .trim()
                                        .toString(),
                                    _selectedCountryCode);
                              }
                            : null,
                        child: state is AuthLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppTheme.secondaryColor,
                                ),
                              )
                            : const Text(
                                'Get OTP',
                                style: TextStyle(
                                    fontFamily: 'MyUniqueFont',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selected = !selected;
                                });
                              },
                              child: Container(
                                height: selected ? 20 : 30,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1,
                                        color: selected
                                            ? Colors.blue
                                            : Colors.grey)),
                                child: Padding(
                                    padding: EdgeInsets.all(selected ? 2 : 7),
                                    child: selected
                                        ? const CircleAvatar(
                                            radius: 5,
                                            backgroundColor: Colors.blue,
                                          )
                                        : null),
                              ).paddingOnly(right: 10),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.85,
                              child: Text(
                                      "Allow our organization to send financial knowledge and critical alerts on your WhatsApp",
                                      style: AppTheme.copyWith(fontSize: 14))
                                  .paddingOnly(bottom: 10),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: screenSize.width * 0.3,
                            height: 4,
                            decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ).paddingOnly(bottom: 30)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
