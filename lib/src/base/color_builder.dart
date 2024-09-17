import 'package:flutter/material.dart';

/// Barry
/// @date 7/11/23
/// describe:
mixin ColorBuilder {
  Color? innerColor;
  List<Color>? innerColors;
}
mixin BorderColorBuilder {
  Color? borderColor;
}

mixin TextColorBuilder {
  Color? innerTextColor;
}

extension TextColorBuilderExt<T extends TextColorBuilder> on T {
  T textColor(Color? color) => this..innerTextColor = color;

  T get textTransparent => this..textColor(Colors.transparent);

  T get textBlack => this..textColor(Colors.black);

  T get textBlack87 => this..textColor(Colors.black87);

  T get textBlack54 => this..textColor(Colors.black54);

  T get textBlack45 => this..textColor(Colors.black45);

  T get textBlack38 => this..textColor(Colors.black38);

  T get textBlack26 => this..textColor(Colors.black26);

  T get textBlack12 => this..textColor(Colors.black12);

  T get textWhite => this..textColor(Colors.white);

  T get textWhite70 => this..textColor(Colors.white70);

  T get textWhite60 => this..textColor(Colors.white60);

  T get textWhite54 => this..textColor(Colors.white54);

  T get textWhite38 => this..textColor(Colors.white38);

  T get textWhite30 => this..textColor(Colors.white30);

  T get textWhite12 => this..textColor(Colors.white12);

  T get textRed => this..textColor(Colors.red);

  T get textRedAccent => this..textColor(Colors.redAccent);

  T get textGreen => this..textColor(Colors.green);

  T get textGreenAccent => this..textColor(Colors.greenAccent);

  T get textLightGreen => this..textColor(Colors.lightGreen);

  T get textLime => this..textColor(Colors.lime);

  T get textBlue => this..textColor(Colors.blue);

  T get textBlueAccent => this..textColor(Colors.blueAccent);

  T get textLightBlue => this..textColor(Colors.lightBlue);

  T get textBlueGrey => this..textColor(Colors.blueGrey);

  T get textIndigoAccent => this..textColor(Colors.indigoAccent);

  T get textYellow => this..textColor(Colors.yellow);

  T get textYellowAccent => this..textColor(Colors.yellowAccent);

  T get textAmber => this..textColor(Colors.amber);

  T get textAmberAccent => this..textColor(Colors.amberAccent);

  T get textPurple => this..textColor(Colors.purple);

  T get textPurpleAccent => this..textColor(Colors.purpleAccent);

  T get textOrange => this..textColor(Colors.orange);

  T get textOrangeAccent => this..textColor(Colors.orangeAccent);

  T get textBrown => this..textColor(Colors.brown);

  T get textPink => this..textColor(Colors.pink);

  T get textGrey => this..textColor(Colors.grey);

  T get textCyan => this..textColor(Colors.cyan);

  T get textDeepOrange => this..textColor(Colors.deepOrange);

  T get textTeal => this..textColor(Colors.teal);

  T get textTealAccent => this..textColor(Colors.tealAccent);

  T get textDeepPurple => this..textColor(Colors.deepPurple);

  T get textIndigo => this..textColor(Colors.indigo);
}

extension ColorBuilderExt<T extends ColorBuilder> on T {
  T color(Color? color) {
    //only use two time, will create a list to collect the color
    if (this.innerColor != null) {
      innerColors ??= [];
      innerColors?.add(this.innerColor!);
    }
    if (color != null) {
      innerColors?.add(color);
    }
    return this..innerColor = color;
  }

  T get transparent => this..color(Colors.transparent);

  T get black => this..color(Colors.black);

  T get black87 => this..color(Colors.black87);

  T get black54 => this..color(Colors.black54);

  T get black45 => this..color(Colors.black45);

  T get black38 => this..color(Colors.black38);

  T get black26 => this..color(Colors.black26);

  T get black12 => this..color(Colors.black12);

  T get white => this..color(Colors.white);

  T get white70 => this..color(Colors.white70);

  T get white60 => this..color(Colors.white60);

  T get white54 => this..color(Colors.white54);

  T get white38 => this..color(Colors.white38);

  T get white30 => this..color(Colors.white30);

  T get white12 => this..color(Colors.white12);

  T get red => this..color(Colors.red);

  T get redAccent => this..color(Colors.redAccent);

  T get green => this..color(Colors.green);

  T get greenAccent => this..color(Colors.greenAccent);

  T get lightGreen => this..color(Colors.lightGreen);

  T get lime => this..color(Colors.lime);

  T get blue => this..color(Colors.blue);

  T get blueAccent => this..color(Colors.blueAccent);

  T get lightBlue => this..color(Colors.lightBlue);

  T get blueGrey => this..color(Colors.blueGrey);

  T get indigoAccent => this..color(Colors.indigoAccent);

  T get yellow => this..color(Colors.yellow);

  T get yellowAccent => this..color(Colors.yellowAccent);

  T get amber => this..color(Colors.amber);

  T get amberAccent => this..color(Colors.amberAccent);

  T get purple => this..color(Colors.purple);

  T get purpleAccent => this..color(Colors.purpleAccent);

  T get orange => this..color(Colors.orange);

  T get orangeAccent => this..color(Colors.orangeAccent);

  T get brown => this..color(Colors.brown);

  T get pink => this..color(Colors.pink);

  T get grey => this..color(Colors.grey);

  T get cyan => this..color(Colors.cyan);

  T get deepOrange => this..color(Colors.deepOrange);

  T get teal => this..color(Colors.teal);

  T get tealAccent => this..color(Colors.tealAccent);

  T get deepPurple => this..color(Colors.deepPurple);

  T get indigo => this..color(Colors.indigo);
}

extension BorderColorBuilderExt<T extends BorderColorBuilder> on T {
  T border(Color? borderColor) => this..borderColor = borderColor;

  T get borderTransparent => this..border(Colors.transparent);

  T get borderBlack => this..border(Colors.black);

  T get borderBlack87 => this..border(Colors.black87);

  T get borderBlack54 => this..border(Colors.black54);

  T get borderBlack45 => this..border(Colors.black45);

  T get borderBlack38 => this..border(Colors.black38);

  T get borderBlack26 => this..border(Colors.black26);

  T get borderBlack12 => this..border(Colors.black12);

  T get borderWhite => this..border(Colors.white);

  T get borderWhite70 => this..border(Colors.white70);

  T get borderWhite60 => this..border(Colors.white60);

  T get borderWhite54 => this..border(Colors.white54);

  T get borderWhite38 => this..border(Colors.white38);

  T get borderWhite30 => this..border(Colors.white30);

  T get borderWhite12 => this..border(Colors.white12);

  T get borderRed => this..border(Colors.red);

  T get borderRedAccent => this..border(Colors.redAccent);

  T get borderGreen => this..border(Colors.green);

  T get borderGreenAccent => this..border(Colors.greenAccent);

  T get borderLightGreen => this..border(Colors.lightGreen);

  T get borderLime => this..border(Colors.lime);

  T get borderBlue => this..border(Colors.blue);

  T get borderBlueAccent => this..border(Colors.blueAccent);

  T get borderLightBlue => this..border(Colors.lightBlue);

  T get borderBlueGrey => this..border(Colors.blueGrey);

  T get borderIndigoAccent => this..border(Colors.indigoAccent);

  T get borderYellow => this..border(Colors.yellow);

  T get borderYellowAccent => this..border(Colors.yellowAccent);

  T get borderAmber => this..border(Colors.amber);

  T get borderAmberAccent => this..border(Colors.amberAccent);

  T get borderPurple => this..border(Colors.purple);

  T get borderPurpleAccent => this..border(Colors.purpleAccent);

  T get borderOrange => this..border(Colors.orange);

  T get borderOrangeAccent => this..border(Colors.orangeAccent);

  T get borderBrown => this..border(Colors.brown);

  T get borderPink => this..border(Colors.pink);

  T get borderGrey => this..border(Colors.grey);

  T get borderCyan => this..border(Colors.cyan);

  T get borderDeepOrange => this..border(Colors.deepOrange);

  T get borderTeal => this..border(Colors.teal);

  T get borderTealAccent => this..border(Colors.tealAccent);

  T get borderDeepPurple => this..border(Colors.deepPurple);

  T get borderIndigo => this..border(Colors.indigo);
}
