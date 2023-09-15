import 'package:everbrain/utils/colors.dart' as colors;
import 'package:everbrain/utils/dimensions.dart' as dimens;
import 'package:flutter/material.dart';

successMessage(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: colors.AppColor.success,
    duration: Duration(seconds: dimens.Dimens.snackMessageDuration),
  ));
}

failMessage(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text(message),
    backgroundColor: colors.AppColor.fail,
    duration: const Duration(seconds: 2),
  ));
}
