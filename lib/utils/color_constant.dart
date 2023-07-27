import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color gray700 = fromHex('#595959');

  static Color black9000a = fromHex('#0a000000');
  static Color whiteA700 = fromHex('#ffffff');
  static Color gray400 = fromHex('#c4c4c4');

  static Color black9005e = fromHex('#5e000000');

  static Color gray901 = fromHex('#1c1f30');

  static Color gray90087 = fromHex('#871f2121');

  static Color gray900 = fromHex('#1f2121');

  static Color lightBlueA200 = fromHex('#40bfff');

  static Color gray50 = fromHex('#fafafa');

  static Color black90087 = fromHex('#87000000');

  static Color black900 = fromHex('#000000');

  static Color bluegray400 = fromHex('#888888');
  static Color bluegray901 = fromHex('#31343b');
  static Color black90063 = fromHex('#63000000');

  static Color lightgrey = fromHex('#DADADA');
  static Color lightgreytext = fromHex('#8391A1');
  static Color buttonblue = fromHex('#1460EB');
  static Color cyan601 = fromHex('#19acb6');
  static const Color honeyDew = Color(0xffF8FFFA);
  static const Color malachiteGreenLight = Color(0xff72FD9E);
  static const Color malachiteGreen = Color(0xff5ADD83);
  static const Color coolGrey = Color(0xff8795AB);
  static const Color charlestonGreen = Color(0xff222831);
  static const Color chineseBlack = Color(0xff111418);

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
