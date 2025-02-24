import 'package:flutter/material.dart';
import 'package:prod/utils/colors.dart';
import 'package:prod/utils/constants.dart';
import 'package:prod/view_models/login/login_view_model.dart';
import 'package:prod/views/home/home_screen.dart';
import 'package:prod/views/widgets/custom_textformfield.dart';
import 'package:prod/views/widgets/exit_dialog_box.dart';
import 'package:prod/views/widgets/custom_button.dart';
import 'package:prod/views/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  // TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final loginProvider = Provider.of<LoginViewModel>(context, listen: false);

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }

        showExitDialog(context);
      },
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: kBackgroundColor,
          // appBar: AuthAppBar(),
          body: SingleChildScrollView(
            child: SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Spacer(),
                  Container(
                    width: .9 * screenWidth,
                    //   height: .6 * screenHeight,
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(height: .01 * screenHeight),
                        kHeight10,
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Container(
                            child: Form(
                              key: loginProvider.formKey1,
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      TextFormFieldHeader(
                                          headingText: "User Name"),
                                    ],
                                  ),
                                  kHeight5,
                                  CustomTextFormField(
                                    hintText: "Enter your user name",
                                    controller: loginProvider.emailController,
                                    //  height: 42,
                                    width: .8 * screenWidth,
                                    isObscure: false,
                                    validatorFunction: (value) {
                                      return null;
                                    },
                                  ),
                                  kHeight5,
                                  const Row(
                                    children: [
                                      TextFormFieldHeader(
                                          headingText: "Password"),
                                    ],
                                  ),
                                  kHeight5,
                                  CustomTextFormField(
                                    hintText: "Enter your password",
                                    controller:
                                        loginProvider.passwordController,
                                    //  height: 42,
                                    width: .8 * screenWidth,
                                    isObscure: true,
                                    validatorFunction: (value) {
                                      return null;
                                    },
                                  ),
                                  kHeight5,
                                  kHeight5,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomButton(
                                          height: 60,
                                          width: .4 * screenWidth,
                                          buttonText: loginProvider.isLoading
                                              ? "Loading..."
                                              : "Sign In",
                                          onClickFunction: loginProvider
                                                  .isLoading
                                              ? null
                                              : () async {
                                                  if (loginProvider
                                                      .emailController
                                                      .text
                                                      .isEmpty) {
                                                    showSnackBar(context,
                                                        "username cannot be empty");
                                                  } else if (loginProvider
                                                      .passwordController
                                                      .text
                                                      .isEmpty) {
                                                    showSnackBar(context,
                                                        "password cannot be empty");
                                                  } else {
                                                    final response =
                                                        await loginProvider
                                                            .login();

                                                    if (response.success) {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomeScreen(
                                                                  userDetails:
                                                                      response
                                                                          .data),
                                                        ),
                                                      );
                                                    } else {
                                                      showSnackBar(
                                                          context,
                                                          response.error ??
                                                              'Login failed');
                                                    }
                                                  }
                                                }),
                                    ],
                                  ),
                                  kHeight5,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  kHeight120,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFormFieldHeader extends StatelessWidget {
  final String headingText;
  const TextFormFieldHeader({super.key, required this.headingText});

  @override
  Widget build(BuildContext context) {
    return Text(
      //  "Email Address"
      headingText,
      style: const TextStyle(
        fontSize: 16,
        color: ktextFormFieldHeadingColor,
      ),
    );
  }
}
