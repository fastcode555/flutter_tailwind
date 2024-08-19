import 'package:flutter/material.dart';

import '../box_decoration_ext.dart';

/// @date 7/11/23
/// describe:

extension BoxBorderColorBuilder<T extends BoxDecorationBuilder> on T {
  T borderColor(Color color) => this..border(color);

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
