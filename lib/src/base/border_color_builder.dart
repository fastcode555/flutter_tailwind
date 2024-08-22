import 'package:flutter/material.dart';

/// @date 7/11/23
/// describe:
mixin BorderColorBuilder {
  Color? borderColor;
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
