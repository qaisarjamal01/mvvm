import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{

  static toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.black,
      fontSize: 20,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static void flushBarErrorMessage(String message, BuildContext context){
    showFlushbar(context: context, flushbar: Flushbar(
      forwardAnimationCurve: Curves.bounceInOut,
      margin: EdgeInsets.symmetric(horizontal: 35,vertical: 10),
      padding: EdgeInsets.all(20),
      message: message,
      backgroundColor: Colors.red,
      //title: 'OOPs',
      messageColor: Colors.white,
      duration: Duration(seconds: 3),
      borderRadius: BorderRadius.circular(30),
      flushbarPosition: FlushbarPosition.TOP,
      reverseAnimationCurve: Curves.decelerate,

      //positionOffset is used when how down or up showing this flushBar
      positionOffset: 5,
      icon: Icon(Icons.error,size: 30,color: Colors.white,),
    )..show(context));
  }

  static snackBar(String message,BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),

          //margin is fixed in SnackBar by default it gives an error while using margin but when we set
          //behaviour from fixed to floating margin works
          behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        backgroundColor: Colors.green,
          content: Text(message))
    );
  }

  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode next){
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static double averageRating(List<int> rating){
    var avgRating = 0;
    for(int i = 0; i < rating.length; i++){
      avgRating = avgRating + rating[i];
    }
    return double.parse((avgRating/rating.length).toStringAsFixed(1));
  }
}