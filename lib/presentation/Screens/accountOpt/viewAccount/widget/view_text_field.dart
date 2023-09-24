
import 'package:everbrain/utils/colors.dart' as colors;
import 'package:flutter/material.dart';

viewTextField(var field){
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: colors.AppColor.lightGrey,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(
        width: 2,
        color: colors.AppColor.accentColor,
      ),
    ),
    child: field,
  );
}