import 'package:flutter/material.dart';

/// @date 7/11/23
/// describe:
mixin ColorBuilder {
  Color? color;
}

extension ColorBuilderExt<T extends ColorBuilder> on T {
  T color(Color? color) => this..color = color;

  T get transparent => this..color = Colors.transparent;

  T get black => this..color = Colors.black;

  T get black87 => this..color = Colors.black87;

  T get black54 => this..color = Colors.black54;

  T get black45 => this..color = Colors.black45;

  T get black38 => this..color = Colors.black38;

  T get black26 => this..color = Colors.black26;

  T get black12 => this..color = Colors.black12;

  T get white => this..color = Colors.white;

  T get white70 => this..color = Colors.white70;

  T get white60 => this..color = Colors.white60;

  T get white54 => this..color = Colors.white54;

  T get white38 => this..color = Colors.white38;

  T get white30 => this..color = Colors.white30;

  T get white12 => this..color = Colors.white12;

  T get red => this..color = Colors.red;

  T get redAccent => this..color = Colors.redAccent;

  T get green => this..color = Colors.green;

  T get greenAccent => this..color = Colors.greenAccent;

  T get lightGreen => this..color = Colors.lightGreen;

  T get lime => this..color = Colors.lime;

  T get blue => this..color = Colors.blue;

  T get blueAccent => this..color = Colors.blueAccent;

  T get lightBlue => this..color = Colors.lightBlue;

  T get blueGrey => this..color = Colors.blueGrey;

  T get indigoAccent => this..color = Colors.indigoAccent;

  T get yellow => this..color = Colors.yellow;

  T get yellowAccent => this..color = Colors.yellowAccent;

  T get amber => this..color = Colors.amber;

  T get amberAccent => this..color = Colors.amberAccent;

  T get purple => this..color = Colors.purple;

  T get purpleAccent => this..color = Colors.purpleAccent;

  T get orange => this..color = Colors.orange;

  T get orangeAccent => this..color = Colors.orangeAccent;

  T get brown => this..color = Colors.brown;

  T get pink => this..color = Colors.pink;

  T get grey => this..color = Colors.grey;

  T get cyan => this..color = Colors.cyan;

  T get deepOrange => this..color = Colors.deepOrange;

  T get teal => this..color = Colors.teal;

  T get tealAccent => this..color = Colors.tealAccent;

  T get deepPurple => this..color = Colors.deepPurple;

  T get indigo => this..color = Colors.indigo;
}
