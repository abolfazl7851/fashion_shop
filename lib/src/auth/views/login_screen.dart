import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/common/widgets/back_button.dart';
import 'package:fashion/common/widgets/custom_button.dart';
import 'package:fashion/common/widgets/email_textfield.dart';
import 'package:fashion/common/widgets/password_field.dart';
import 'package:fashion/src/auth/controller/auth_notifier.dart';
import 'package:fashion/src/auth/models/login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _usernameController =
      TextEditingController();
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
        leading: AppBackButton(
          onTap: () {
            context.go('/home');
          },
        ),
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
            "Hi. Welcome Back. You've been missed!",
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
                  focusNode: _passwordNode,
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
                PasswordField(
                  controller: _passwordController,
                  focusNode: _passwordNode,
                  radius: 10,
                ),
                SizedBox(
                  height: 25.h,
                ),
                context.watch<AuthNotifier>().isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Kolors.kPrimary,
                          valueColor: AlwaysStoppedAnimation(Kolors.kWhite),
                        ),
                      )
                    : CustomButton(
                        radius: 10,
                        text: "L  O  G  I  N".toUpperCase(),
                        btnColor: Kolors.kPrimaryLight,
                        btnWidth: ScreenUtil().screenWidth,
                        btnHieght: 45,
                        onTap: () {
                          LoginModel model = LoginModel(
                              password: _passwordController.text,
                              username: _usernameController.text);

                          String data = loginModelToJson(model);
                          

                          context.read<AuthNotifier>().loginFunc(data, context);
                        },
                      )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 130.h,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 110.0),
            child: GestureDetector(
              onTap: () {
                context.push('/register');
              },
              child: Text(
                'Do not have an account? Register now one.',
                style: appStyle(12, Colors.blue, FontWeight.normal),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
