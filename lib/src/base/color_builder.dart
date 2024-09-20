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

  /// set the textColor[Colors.transparent]
  T get textTransparent => this..textColor(Colors.transparent);

  /// set the textColor[Colors.black]
  T get textBlack => this..textColor(Colors.black);

  /// set the textColor[Colors.black87]
  T get textBlack87 => this..textColor(Colors.black87);

  /// set the textColor[Colors.black54]
  T get textBlack54 => this..textColor(Colors.black54);

  /// set the textColor[Colors.black45]
  T get textBlack45 => this..textColor(Colors.black45);

  /// set the textColor[Colors.black38]
  T get textBlack38 => this..textColor(Colors.black38);

  /// set the textColor[Colors.black26]
  T get textBlack26 => this..textColor(Colors.black26);

  /// set the textColor[Colors.black12]
  T get textBlack12 => this..textColor(Colors.black12);

  /// set the textColor[Colors.white]
  T get textWhite => this..textColor(Colors.white);

  /// set the textColor[Colors.white70]
  T get textWhite70 => this..textColor(Colors.white70);

  /// set the textColor[Colors.white60]
  T get textWhite60 => this..textColor(Colors.white60);

  /// set the textColor[Colors.white54]
  T get textWhite54 => this..textColor(Colors.white54);

  /// set the textColor[Colors.white38]
  T get textWhite38 => this..textColor(Colors.white38);

  /// set the textColor[Colors.white30]
  T get textWhite30 => this..textColor(Colors.white30);

  /// set the textColor[Colors.white12]
  T get textWhite12 => this..textColor(Colors.white12);

  /// set the textColor[Colors.red]
  T get textRed => this..textColor(Colors.red);

  /// set the textColor[Colors.redAccent]
  T get textRedAccent => this..textColor(Colors.redAccent);

  /// set the textColor[Colors.green]
  T get textGreen => this..textColor(Colors.green);

  /// set the textColor[Colors.greenAccent]
  T get textGreenAccent => this..textColor(Colors.greenAccent);

  /// set the textColor[Colors.lightGreen]
  T get textLightGreen => this..textColor(Colors.lightGreen);

  /// set the textColor[Colors.lime]
  T get textLime => this..textColor(Colors.lime);

  /// set the textColor[Colors.blue]
  T get textBlue => this..textColor(Colors.blue);

  /// set the textColor[Colors.blueAccent]
  T get textBlueAccent => this..textColor(Colors.blueAccent);

  /// set the textColor[Colors.lightBlue]
  T get textLightBlue => this..textColor(Colors.lightBlue);

  /// set the textColor[Colors.blueGrey]
  T get textBlueGrey => this..textColor(Colors.blueGrey);

  /// set the textColor[Colors.indigoAccent]
  T get textIndigoAccent => this..textColor(Colors.indigoAccent);

  /// set the textColor[Colors.yellow]
  T get textYellow => this..textColor(Colors.yellow);

  /// set the textColor[Colors.yellowAccent]
  T get textYellowAccent => this..textColor(Colors.yellowAccent);

  /// set the textColor[Colors.amber]
  T get textAmber => this..textColor(Colors.amber);

  /// set the textColor[Colors.amberAccent]
  T get textAmberAccent => this..textColor(Colors.amberAccent);

  /// set the textColor[Colors.purple]
  T get textPurple => this..textColor(Colors.purple);

  /// set the textColor[Colors.purpleAccent]
  T get textPurpleAccent => this..textColor(Colors.purpleAccent);

  /// set the textColor[Colors.orange]
  T get textOrange => this..textColor(Colors.orange);

  /// set the textColor[Colors.orangeAccent]
  T get textOrangeAccent => this..textColor(Colors.orangeAccent);

  /// set the textColor[Colors.brown]
  T get textBrown => this..textColor(Colors.brown);

  /// set the textColor[Colors.pink]
  T get textPink => this..textColor(Colors.pink);

  /// set the textColor[Colors.grey]
  T get textGrey => this..textColor(Colors.grey);

  /// set the textColor[Colors.cyan]
  T get textCyan => this..textColor(Colors.cyan);

  /// set the textColor[Colors.deepOrange]
  T get textDeepOrange => this..textColor(Colors.deepOrange);

  /// set the textColor[Colors.teal]
  T get textTeal => this..textColor(Colors.teal);

  /// set the textColor[Colors.tealAccent]
  T get textTealAccent => this..textColor(Colors.tealAccent);

  /// set the textColor[Colors.deepPurple]
  T get textDeepPurple => this..textColor(Colors.deepPurple);

  /// set the textColor[Colors.indigo]
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

  ///flutter system color [Colors.transparent]
  T get transparent => this..color(Colors.transparent);

  ///flutter system color [Colors.black]
  T get black => this..color(Colors.black);

  ///flutter system color [Colors.black87]
  T get black87 => this..color(Colors.black87);

  ///flutter system color [Colors.black54]
  T get black54 => this..color(Colors.black54);

  ///flutter system color [Colors.black45]
  T get black45 => this..color(Colors.black45);

  ///flutter system color [Colors.black38]
  T get black38 => this..color(Colors.black38);

  ///flutter system color [Colors.black26]
  T get black26 => this..color(Colors.black26);

  ///flutter system color [Colors.black12]
  T get black12 => this..color(Colors.black12);

  ///flutter system color [Colors.white]
  T get white => this..color(Colors.white);

  ///flutter system color [Colors.white70]
  T get white70 => this..color(Colors.white70);

  ///flutter system color [Colors.white60]
  T get white60 => this..color(Colors.white60);

  ///flutter system color [Colors.white54]
  T get white54 => this..color(Colors.white54);

  ///flutter system color [Colors.white38]
  T get white38 => this..color(Colors.white38);

  ///flutter system color [Colors.white30]
  T get white30 => this..color(Colors.white30);

  ///flutter system color [Colors.white12]
  T get white12 => this..color(Colors.white12);

  ///flutter system color [Colors.red]
  T get red => this..color(Colors.red);

  ///flutter system color [Colors.redAccent]
  T get redAccent => this..color(Colors.redAccent);

  ///flutter system color [Colors.green]
  T get green => this..color(Colors.green);

  ///flutter system color [Colors.greenAccent]
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.green.png)
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.greenAccent.png)
  ///
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.teal.png)
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.tealAccent.png)
  ///
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.lightGreen.png)
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.lightGreenAccent.png)
  ///
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.lime.png)
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.limeAccent.png)
  T get greenAccent => this..color(Colors.greenAccent);

  ///flutter system color [Colors.lightGreen]
  T get lightGreen => this..color(Colors.lightGreen);

  ///flutter system color [Colors.lime]
  T get lime => this..color(Colors.lime);

  ///flutter system color [Colors.blue]
  T get blue => this..color(Colors.blue);

  ///flutter system color [Colors.blueAccent]
  T get blueAccent => this..color(Colors.blueAccent);

  ///flutter system color [Colors.lightBlue]
  T get lightBlue => this..color(Colors.lightBlue);

  ///flutter system color [Colors.blueGrey]
  T get blueGrey => this..color(Colors.blueGrey);

  ///flutter system color [Colors.indigoAccent]
  T get indigoAccent => this..color(Colors.indigoAccent);

  ///flutter system color [Colors.yellow]
  T get yellow => this..color(Colors.yellow);

  ///flutter system color [Colors.yellowAccent]
  T get yellowAccent => this..color(Colors.yellowAccent);

  ///flutter system color [Colors.amber]
  T get amber => this..color(Colors.amber);

  ///flutter system color [Colors.amberAccent]
  T get amberAccent => this..color(Colors.amberAccent);

  ///flutter system color [Colors.purple]
  T get purple => this..color(Colors.purple);

  ///flutter system color [Colors.purpleAccent]
  T get purpleAccent => this..color(Colors.purpleAccent);

  ///flutter system color [Colors.orange]
  T get orange => this..color(Colors.orange);

  ///flutter system color [Colors.orangeAccent]
  T get orangeAccent => this..color(Colors.orangeAccent);

  ///flutter system color [Colors.brown]
  T get brown => this..color(Colors.brown);

  ///flutter system color [Colors.pink]
  T get pink => this..color(Colors.pink);

  ///flutter system color [Colors.grey]
  T get grey => this..color(Colors.grey);

  ///flutter system color [Colors.cyan]
  T get cyan => this..color(Colors.cyan);

  ///flutter system color [Colors.deepOrange]
  T get deepOrange => this..color(Colors.deepOrange);

  ///flutter system color [Colors.teal]
  T get teal => this..color(Colors.teal);

  ///flutter system color [Colors.tealAccent]
  T get tealAccent => this..color(Colors.tealAccent);

  ///flutter system color [Colors.deepPurple]
  T get deepPurple => this..color(Colors.deepPurple);

  ///flutter system color [Colors.indigo]
  T get indigo => this..color(Colors.indigo);
}

extension BorderColorBuilderExt<T extends BorderColorBuilder> on T {
  T border(Color? borderColor) => this..borderColor = borderColor;

  ///set the border color [Colors.transparent]
  T get borderTransparent => this..border(Colors.transparent);

  ///set the border color [Colors.black]
  T get borderBlack => this..border(Colors.black);

  ///set the border color [Colors.black87]
  T get borderBlack87 => this..border(Colors.black87);

  ///set the border color [Colors.black54]
  T get borderBlack54 => this..border(Colors.black54);

  ///set the border color [Colors.black45]
  T get borderBlack45 => this..border(Colors.black45);

  ///set the border color [Colors.black38]
  T get borderBlack38 => this..border(Colors.black38);

  ///set the border color [Colors.black26]
  T get borderBlack26 => this..border(Colors.black26);

  ///set the border color [Colors.black12]
  T get borderBlack12 => this..border(Colors.black12);

  ///set the border color [Colors.white]
  T get borderWhite => this..border(Colors.white);

  ///set the border color [Colors.white70]
  T get borderWhite70 => this..border(Colors.white70);

  ///set the border color [Colors.white60]
  T get borderWhite60 => this..border(Colors.white60);

  ///set the border color [Colors.white54]
  T get borderWhite54 => this..border(Colors.white54);

  ///set the border color [Colors.white38]
  T get borderWhite38 => this..border(Colors.white38);

  ///set the border color [Colors.white30]
  T get borderWhite30 => this..border(Colors.white30);

  ///set the border color [Colors.white12]
  T get borderWhite12 => this..border(Colors.white12);

  ///set the border color [Colors.red]
  T get borderRed => this..border(Colors.red);

  ///set the border color [Colors.redAccent]
  T get borderRedAccent => this..border(Colors.redAccent);

  ///set the border color [Colors.green]
  T get borderGreen => this..border(Colors.green);

  ///set the border color [Colors.greenAccent]
  T get borderGreenAccent => this..border(Colors.greenAccent);

  ///set the border color [Colors.lightGreen]
  T get borderLightGreen => this..border(Colors.lightGreen);

  ///set the border color [Colors.lime]
  T get borderLime => this..border(Colors.lime);

  ///set the border color [Colors.blue]
  T get borderBlue => this..border(Colors.blue);

  ///set the border color [Colors.blueAccent]
  T get borderBlueAccent => this..border(Colors.blueAccent);

  ///set the border color [Colors.lightBlue]
  T get borderLightBlue => this..border(Colors.lightBlue);

  ///set the border color [Colors.blueGrey]
  T get borderBlueGrey => this..border(Colors.blueGrey);

  ///set the border color [Colors.indigoAccent]
  T get borderIndigoAccent => this..border(Colors.indigoAccent);

  ///set the border color [Colors.yellow]
  T get borderYellow => this..border(Colors.yellow);

  ///set the border color [Colors.yellowAccent]
  T get borderYellowAccent => this..border(Colors.yellowAccent);

  ///set the border color [Colors.amber]
  T get borderAmber => this..border(Colors.amber);

  ///set the border color [Colors.amberAccent]
  T get borderAmberAccent => this..border(Colors.amberAccent);

  ///set the border color [Colors.purple]
  T get borderPurple => this..border(Colors.purple);

  ///set the border color [Colors.purpleAccent]
  T get borderPurpleAccent => this..border(Colors.purpleAccent);

  ///set the border color [Colors.orange]
  T get borderOrange => this..border(Colors.orange);

  ///set the border color [Colors.orangeAccent]
  T get borderOrangeAccent => this..border(Colors.orangeAccent);

  ///set the border color [Colors.brown]
  T get borderBrown => this..border(Colors.brown);

  ///set the border color [Colors.pink]
  T get borderPink => this..border(Colors.pink);

  ///set the border color [Colors.grey]
  T get borderGrey => this..border(Colors.grey);

  ///set the border color [Colors.cyan]
  T get borderCyan => this..border(Colors.cyan);

  ///set the border color [Colors.deepOrange]
  T get borderDeepOrange => this..border(Colors.deepOrange);

  ///set the border color [Colors.teal]
  T get borderTeal => this..border(Colors.teal);

  ///set the border color [Colors.tealAccent]
  T get borderTealAccent => this..border(Colors.tealAccent);

  ///set the border color [Colors.deepPurple]
  T get borderDeepPurple => this..border(Colors.deepPurple);

  ///set the border color [Colors.indigo]
  T get borderIndigo => this..border(Colors.indigo);
}
