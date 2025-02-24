import 'package:flutter/material.dart';
import 'package:prod/utils/colors.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  bool isLoading;
  double height;
  double width;
  String buttonText;
  Future<void> Function()? onClickFunction;
  double enteredFontSize;
  Color buttonColor;
  Color textColor;
  CustomButton({
    super.key,
    this.isLoading = false,
    required this.height,
    required this.width,
    required this.buttonText,
    required this.onClickFunction,
    this.enteredFontSize = 16,
    this.buttonColor = kMainColor,
    this.textColor = kWhiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClickFunction,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(27),
        ),
        child: Center(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: kWhiteColor,
                  ),
                )
              : Center(
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      color: textColor,
                      fontSize: enteredFontSize,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}