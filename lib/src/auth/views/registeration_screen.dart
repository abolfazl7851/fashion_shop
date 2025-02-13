import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/common/widgets/back_button.dart';
import 'package:fashion/common/widgets/custom_button.dart';
import 'package:fashion/common/widgets/email_textfield.dart';
import 'package:fashion/common/widgets/password_field.dart';
import 'package:fashion/src/auth/controller/auth_notifier.dart';
import 'package:fashion/src/auth/models/registration_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RegisterationScreen extends StatefulWidget {
  const RegisterationScreen({super.key});

  @override
  State<RegisterationScreen> createState() => _RegisterationScreen();
}

class _RegisterationScreen extends State<RegisterationScreen> {
  late final TextEditingController _usernameController =
      TextEditingController();
  late final TextEditingController _EmailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final FocusNode _passwordNode = FocusNode();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordNode.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const AppBackButton(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 160.h,
          ),
          Text(
            "Fashion",
            style: appStyle(24, Kolors.kPrimary, FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Hi. Welcome. Create Your Account.",
            style: appStyle(13, Kolors.kGray, FontWeight.normal),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 25.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                EmailTextField(
                  radius: 10,
                  hintText: 'Username',
                  controller: _usernameController,
                  prefixIcon: const Icon(
                    CupertinoIcons.profile_circled,
                    size: 20,
                    color: Kolors.kGray,
                  ),
                  keyboardType: TextInputType.text,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordNode);
                  },
                ),
                SizedBox(
                  height: 25.h,
                ),
                EmailTextField(
                  radius: 10,
                  focusNode: _passwordNode,
                  hintText: 'Email',
                  controller: _EmailController,
                  prefixIcon: const Icon(
                    CupertinoIcons.mail,
                    size: 20,
                    color: Kolors.kGray,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordNode);
                  },
                ),
                SizedBox(
                  height: 25.h,
                ),
                PasswordField(
                  controller: _passwordController,
                  focusNode: _passwordNode,
                  radius: 10,
                ),
                SizedBox(
                  height: 25.h,
                ),
                context.watch<AuthNotifier>().isRLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Kolors.kPrimary,
                          valueColor: AlwaysStoppedAnimation(Kolors.kWhite),
                        ),
                      )
                    : CustomButton(
                        radius: 10,
                        text: "S  I  G  n  U  P".toUpperCase(),
                        btnColor: Kolors.kPrimaryLight,
                        btnWidth: ScreenUtil().screenWidth,
                        btnHieght: 45,
                        onTap: () {
                          RegistrationModel model = RegistrationModel(
                              password: _passwordController.text,
                              username: _usernameController.text,
                              email: _EmailController.text);

                          String data = registrationModelToJson(model);


                          context
                              .read<AuthNotifier>()
                              .registrationFunc(data, context);
                        },
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
