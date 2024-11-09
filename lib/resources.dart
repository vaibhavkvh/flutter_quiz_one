import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_one/hexa_color.dart';

Color mYellowGreenColor = '#004ff9'.toColor();
Color mDarkGreenColor = '#000000'.toColor();

extension ColorExtesion on String {
  toColor() {
    return HexColor(this);
  }

  toLabel() {
    return Text(
      this,
    );
  }

  toOutlineButton(Function() param) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.all(8),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(12),
          side: const BorderSide(
            color: Colors.white,
          ),
        ),
        child: Text(
          this,
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        onPressed: param,
      ),
    );
  }

  toWhiteLabel() {
    return Text(
      this,
      style: TextStyle(
        color: Colors.white,
        fontSize: 22,
      ),
    );
  }
}
