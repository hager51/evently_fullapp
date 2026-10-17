import 'package:flutter/material.dart';

class Toast {

 static void show({required String title,required BuildContext context,ToastType type = ToastType.success}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: type.color,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(16)),
        content: Text(title),
      ),
    );
  }
}


enum ToastType{
  error(color: Colors.red),
  success(color: Colors.green);
  final Color color ;

  const ToastType({required this.color});

}