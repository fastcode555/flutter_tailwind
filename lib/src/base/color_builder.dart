import 'package:flutter/material.dart';

/// @date 7/11/23
/// describe:
mixin ColorBuilder {
  Color? _color;

  Color? get color => _color;

  set color(Color? color) {
    _color = color;
  }
}

extension ColorBuilderExt<T extends ColorBuilder> on T {
  T color(Color? color) => this.._color = color;

  T get transparent => this.._color = Colors.transparent;

  T get black => this.._color = Colors.black;

  T get black87 => this.._color = Colors.black87;

  T get black54 => this.._color = Colors.black54;

  T get black45 => this.._color = Colors.black45;

  T get black38 => this.._color = Colors.black38;

  T get black26 => this.._color = Colors.black26;

  T get black12 => this.._color = Colors.black12;

  T get white => this.._color = Colors.white;

  T get white70 => this.._color = Colors.white70;

  T get white60 => this.._color = Colors.white60;

  T get white54 => this.._color = Colors.white54;

  T get white38 => this.._color = Colors.white38;

  T get white30 => this.._color = Colors.white30;

  T get white12 => this.._color = Colors.white12;

  T get red => this.._color = Colors.red;

  T get redAccent => this.._color = Colors.redAccent;

  T get green => this.._color = Colors.green;

  T get greenAccent => this.._color = Colors.greenAccent;

  T get lightGreen => this.._color = Colors.lightGreen;

  T get lime => this.._color = Colors.lime;

  T get blue => this.._color = Colors.blue;

  T get blueAccent => this.._color = Colors.blueAccent;

  T get lightBlue => this.._color = Colors.lightBlue;

  T get blueGrey => this.._color = Colors.blueGrey;

  T get indigoAccent => this.._color = Colors.indigoAccent;

  T get yellow => this.._color = Colors.yellow;

  T get yellowAccent => this.._color = Colors.yellowAccent;

  T get amber => this.._color = Colors.amber;

  T get amberAccent => this.._color = Colors.amberAccent;

  T get purple => this.._color = Colors.purple;

  T get purpleAccent => this.._color = Colors.purpleAccent;

  T get orange => this.._color = Colors.orange;

  T get orangeAccent => this.._color = Colors.orangeAccent;

  T get brown => this.._color = Colors.brown;

  T get pink => this.._color = Colors.pink;

  T get grey => this.._color = Colors.grey;

  T get cyan => this.._color = Colors.cyan;

  T get deepOrange => this.._color = Colors.deepOrange;

  T get teal => this.._color = Colors.teal;

  T get tealAccent => this.._color = Colors.tealAccent;

  T get deepPurple => this.._color = Colors.deepPurple;

  T get indigo => this.._color = Colors.indigo;
}
