import 'package:flutter/material.dart';

/// Barry
/// @date 7/11/23
/// describe:
mixin ColorBuilder {
  Color? innerColor;
}
mixin BorderColorBuilder {
  Color? borderColor;
}

mixin TextColorBuilder {
  Color? innerTextColor;
}

extension TextColorBuilderExt<T extends TextColorBuilder> on T {
  T textColor(Color? color) => this..innerTextColor = color;

  T get textTransparent => this..innerTextColor = Colors.transparent;

  T get textBlack => this..innerTextColor = Colors.black;

  T get textBlack87 => this..innerTextColor = Colors.black87;

  T get textBlack54 => this..innerTextColor = Colors.black54;

  T get textBlack45 => this..innerTextColor = Colors.black45;

  T get textBlack38 => this..innerTextColor = Colors.black38;

  T get textBlack26 => this..innerTextColor = Colors.black26;

  T get textBlack12 => this..innerTextColor = Colors.black12;

  T get textWhite => this..innerTextColor = Colors.white;

  T get textWhite70 => this..innerTextColor = Colors.white70;

  T get textWhite60 => this..innerTextColor = Colors.white60;

  T get textWhite54 => this..innerTextColor = Colors.white54;

  T get textWhite38 => this..innerTextColor = Colors.white38;

  T get textWhite30 => this..innerTextColor = Colors.white30;

  T get textWhite12 => this..innerTextColor = Colors.white12;

  T get textRed => this..innerTextColor = Colors.red;

  T get textRedAccent => this..innerTextColor = Colors.redAccent;

  T get textGreen => this..innerTextColor = Colors.green;

  T get textGreenAccent => this..innerTextColor = Colors.greenAccent;

  T get textLightGreen => this..innerTextColor = Colors.lightGreen;

  T get textLime => this..innerTextColor = Colors.lime;

  T get textBlue => this..innerTextColor = Colors.blue;

  T get textBlueAccent => this..innerTextColor = Colors.blueAccent;

  T get textLightBlue => this..innerTextColor = Colors.lightBlue;

  T get textBlueGrey => this..innerTextColor = Colors.blueGrey;

  T get textIndigoAccent => this..innerTextColor = Colors.indigoAccent;

  T get textYellow => this..innerTextColor = Colors.yellow;

  T get textYellowAccent => this..innerTextColor = Colors.yellowAccent;

  T get textAmber => this..innerTextColor = Colors.amber;

  T get textAmberAccent => this..innerTextColor = Colors.amberAccent;

  T get textPurple => this..innerTextColor = Colors.purple;

  T get textPurpleAccent => this..innerTextColor = Colors.purpleAccent;

  T get textOrange => this..innerTextColor = Colors.orange;

  T get textOrangeAccent => this..innerTextColor = Colors.orangeAccent;

  T get textBrown => this..innerTextColor = Colors.brown;

  T get textPink => this..innerTextColor = Colors.pink;

  T get textGrey => this..innerTextColor = Colors.grey;

  T get textCyan => this..innerTextColor = Colors.cyan;

  T get textDeepOrange => this..innerTextColor = Colors.deepOrange;

  T get textTeal => this..innerTextColor = Colors.teal;

  T get textTealAccent => this..innerTextColor = Colors.tealAccent;

  T get textDeepPurple => this..innerTextColor = Colors.deepPurple;

  T get textIndigo => this..innerTextColor = Colors.indigo;
}

extension ColorBuilderExt<T extends ColorBuilder> on T {
  T color(Color? color) => this..innerColor = color;

  T get transparent => this..innerColor = Colors.transparent;

  T get black => this..innerColor = Colors.black;

  T get black87 => this..innerColor = Colors.black87;

  T get black54 => this..innerColor = Colors.black54;

  T get black45 => this..innerColor = Colors.black45;

  T get black38 => this..innerColor = Colors.black38;

  T get black26 => this..innerColor = Colors.black26;

  T get black12 => this..innerColor = Colors.black12;

  T get white => this..innerColor = Colors.white;

  T get white70 => this..innerColor = Colors.white70;

  T get white60 => this..innerColor = Colors.white60;

  T get white54 => this..innerColor = Colors.white54;

  T get white38 => this..innerColor = Colors.white38;

  T get white30 => this..innerColor = Colors.white30;

  T get white12 => this..innerColor = Colors.white12;

  T get red => this..innerColor = Colors.red;

  T get redAccent => this..innerColor = Colors.redAccent;

  T get green => this..innerColor = Colors.green;

  T get greenAccent => this..innerColor = Colors.greenAccent;

  T get lightGreen => this..innerColor = Colors.lightGreen;

  T get lime => this..innerColor = Colors.lime;

  T get blue => this..innerColor = Colors.blue;

  T get blueAccent => this..innerColor = Colors.blueAccent;

  T get lightBlue => this..innerColor = Colors.lightBlue;

  T get blueGrey => this..innerColor = Colors.blueGrey;

  T get indigoAccent => this..innerColor = Colors.indigoAccent;

  T get yellow => this..innerColor = Colors.yellow;

  T get yellowAccent => this..innerColor = Colors.yellowAccent;

  T get amber => this..innerColor = Colors.amber;

  T get amberAccent => this..innerColor = Colors.amberAccent;

  T get purple => this..innerColor = Colors.purple;

  T get purpleAccent => this..innerColor = Colors.purpleAccent;

  T get orange => this..innerColor = Colors.orange;

  T get orangeAccent => this..innerColor = Colors.orangeAccent;

  T get brown => this..innerColor = Colors.brown;

  T get pink => this..innerColor = Colors.pink;

  T get grey => this..innerColor = Colors.grey;

  T get cyan => this..innerColor = Colors.cyan;

  T get deepOrange => this..innerColor = Colors.deepOrange;

  T get teal => this..innerColor = Colors.teal;

  T get tealAccent => this..innerColor = Colors.tealAccent;

  T get deepPurple => this..innerColor = Colors.deepPurple;

  T get indigo => this..innerColor = Colors.indigo;
}

extension BorderColorBuilderExt<T extends BorderColorBuilder> on T {
  T border(Color? borderColor) => this..borderColor = borderColor ?? this.borderColor;

  T get borderTransparent => this..borderColor = Colors.transparent;

  T get borderBlack => this..borderColor = Colors.black;

  T get borderBlack87 => this..borderColor = Colors.black87;

  T get borderBlack54 => this..borderColor = Colors.black54;

  T get borderBlack45 => this..borderColor = Colors.black45;

  T get borderBlack38 => this..borderColor = Colors.black38;

  T get borderBlack26 => this..borderColor = Colors.black26;

  T get borderBlack12 => this..borderColor = Colors.black12;

  T get borderWhite => this..borderColor = Colors.white;

  T get borderWhite70 => this..borderColor = Colors.white70;

  T get borderWhite60 => this..borderColor = Colors.white60;

  T get borderWhite54 => this..borderColor = Colors.white54;

  T get borderWhite38 => this..borderColor = Colors.white38;

  T get borderWhite30 => this..borderColor = Colors.white30;

  T get borderWhite12 => this..borderColor = Colors.white12;

  T get borderRed => this..borderColor = Colors.red;

  T get borderRedAccent => this..borderColor = Colors.redAccent;

  T get borderGreen => this..borderColor = Colors.green;

  T get borderGreenAccent => this..borderColor = Colors.greenAccent;

  T get borderLightGreen => this..borderColor = Colors.lightGreen;

  T get borderLime => this..borderColor = Colors.lime;

  T get borderBlue => this..borderColor = Colors.blue;

  T get borderBlueAccent => this..borderColor = Colors.blueAccent;

  T get borderLightBlue => this..borderColor = Colors.lightBlue;

  T get borderBlueGrey => this..borderColor = Colors.blueGrey;

  T get borderIndigoAccent => this..borderColor = Colors.indigoAccent;

  T get borderYellow => this..borderColor = Colors.yellow;

  T get borderYellowAccent => this..borderColor = Colors.yellowAccent;

  T get borderAmber => this..borderColor = Colors.amber;

  T get borderAmberAccent => this..borderColor = Colors.amberAccent;

  T get borderPurple => this..borderColor = Colors.purple;

  T get borderPurpleAccent => this..borderColor = Colors.purpleAccent;

  T get borderOrange => this..borderColor = Colors.orange;

  T get borderOrangeAccent => this..borderColor = Colors.orangeAccent;

  T get borderBrown => this..borderColor = Colors.brown;

  T get borderPink => this..borderColor = Colors.pink;

  T get borderGrey => this..borderColor = Colors.grey;

  T get borderCyan => this..borderColor = Colors.cyan;

  T get borderDeepOrange => this..borderColor = Colors.deepOrange;

  T get borderTeal => this..borderColor = Colors.teal;

  T get borderTealAccent => this..borderColor = Colors.tealAccent;

  T get borderDeepPurple => this..borderColor = Colors.deepPurple;

  T get borderIndigo => this..borderColor = Colors.indigo;
}
