
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      content: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                message,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}