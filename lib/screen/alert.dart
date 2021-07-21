

import 'package:flutter/material.dart';

showDownloding(BuildContext context) {
  return showDialog(
    context: context, 
    builder: (context)=>
    AlertDialog(
      title: Text("loding ..."),
      content: Container(
        height: 50,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ),
    );
}
