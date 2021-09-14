import 'package:flutter/material.dart';
import 'package:flushbar/flushbar_helper.dart';

void showMessage(int tipo, titulo, msg, BuildContext ctx) {
  switch (tipo) {
    case 0:
      FlushbarHelper.createSuccess(
          title: titulo, message: msg, duration: Duration(seconds: 3))
        ..show(ctx);
      break;
    case 1:
      FlushbarHelper.createInformation(
          title: titulo, message: msg, duration: Duration(seconds: 3))
        ..show(ctx);
      break;
    case 2:
      FlushbarHelper.createError(
          title: titulo, message: msg, duration: Duration(seconds: 3))
        ..show(ctx);
      break;
    default:
  }
}
