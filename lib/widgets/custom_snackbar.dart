import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar({
    required String title,
    required String message,
    Color backgroundColor = Colors.black87,
    Duration duration = const Duration(seconds: 3),
  }) : super(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 4),
              Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          duration: duration,
        );
}
