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

  ///set the textColor [Colors.transparent]
  T get textTransparent => this..textColor(Colors.transparent);

  ///set the textColor [Colors.black]
  T get textBlack => this..textColor(Colors.black);

  ///set the textColor [Colors.black87]
  T get textBlack87 => this..textColor(Colors.black87);

  ///set the textColor [Colors.black54]
  T get textBlack54 => this..textColor(Colors.black54);

  ///set the textColor [Colors.black45]
  T get textBlack45 => this..textColor(Colors.black45);

  ///set the textColor [Colors.black38]
  T get textBlack38 => this..textColor(Colors.black38);

  ///set the textColor [Colors.black26]
  T get textBlack26 => this..textColor(Colors.black26);

  ///set the textColor [Colors.black12]
  T get textBlack12 => this..textColor(Colors.black12);

  ///set the textColor [Colors.white]
  T get textWhite => this..textColor(Colors.white);

  ///set the textColor [Colors.white70]
  T get textWhite70 => this..textColor(Colors.white70);

  ///set the textColor [Colors.white60]
  T get textWhite60 => this..textColor(Colors.white60);

  ///set the textColor [Colors.white54]
  T get textWhite54 => this..textColor(Colors.white54);

  ///set the textColor [Colors.white38]
  T get textWhite38 => this..textColor(Colors.white38);

  ///set the textColor [Colors.white30]
  T get textWhite30 => this..textColor(Colors.white30);

  ///set the textColor [Colors.white12]
  T get textWhite12 => this..textColor(Colors.white12);

  ///set the textColor [Colors.red]
  T get textRed => this..textColor(Colors.red);

  ///set the textColor [Colors.red[50]]
  T get textRed50 => this..textColor(Colors.red[50]);

  ///set the textColor [Colors.red[100]]
  T get textRed100 => this..textColor(Colors.red[100]);

  ///set the textColor [Colors.red[200]]
  T get textRed200 => this..textColor(Colors.red[200]);

  ///set the textColor [Colors.red[300]]
  T get textRed300 => this..textColor(Colors.red[300]);

  ///set the textColor [Colors.red[400]]
  T get textRed400 => this..textColor(Colors.red[400]);

  ///set the textColor [Colors.red[500]]
  T get textRed500 => this..textColor(Colors.red[500]);

  ///set the textColor [Colors.red[600]]
  T get textRed600 => this..textColor(Colors.red[600]);

  ///set the textColor [Colors.red[700]]
  T get textRed700 => this..textColor(Colors.red[700]);

  ///set the textColor [Colors.red[800]]
  T get textRed800 => this..textColor(Colors.red[800]);

  ///set the textColor [Colors.red[900]]
  T get textRed900 => this..textColor(Colors.red[900]);

  ///set the textColor [Colors.redAccent]
  T get textRedAccent => this..textColor(Colors.redAccent);

  ///set the textColor [Colors.redAccent[100]]
  T get textRedAccent100 => this..textColor(Colors.redAccent[100]);

  ///set the textColor [Colors.redAccent[200]]
  T get textRedAccent200 => this..textColor(Colors.redAccent[200]);

  ///set the textColor [Colors.redAccent[400]]
  T get textRedAccent400 => this..textColor(Colors.redAccent[400]);

  ///set the textColor [Colors.redAccent[700]]
  T get textRedAccent700 => this..textColor(Colors.redAccent[700]);

  ///set the textColor [Colors.green]
  T get textGreen => this..textColor(Colors.green);

  ///set the textColor [Colors.green[50]]
  T get textGreen50 => this..textColor(Colors.green[50]);

  ///set the textColor [Colors.green[100]]
  T get textGreen100 => this..textColor(Colors.green[100]);

  ///set the textColor [Colors.green[200]]
  T get textGreen200 => this..textColor(Colors.green[200]);

  ///set the textColor [Colors.green[300]]
  T get textGreen300 => this..textColor(Colors.green[300]);

  ///set the textColor [Colors.green[400]]
  T get textGreen400 => this..textColor(Colors.green[400]);

  ///set the textColor [Colors.green[500]]
  T get textGreen500 => this..textColor(Colors.green[500]);

  ///set the textColor [Colors.green[600]]
  T get textGreen600 => this..textColor(Colors.green[600]);

  ///set the textColor [Colors.green[700]]
  T get textGreen700 => this..textColor(Colors.green[700]);

  ///set the textColor [Colors.green[800]]
  T get textGreen800 => this..textColor(Colors.green[800]);

  ///set the textColor [Colors.green[900]]
  T get textGreen900 => this..textColor(Colors.green[900]);

  ///set the textColor [Colors.greenAccent]
  T get textGreenAccent => this..textColor(Colors.greenAccent);

  ///set the textColor [Colors.greenAccent[100]]
  T get textGreenAccent100 => this..textColor(Colors.greenAccent[100]);

  ///set the textColor [Colors.greenAccent[200]]
  T get textGreenAccent200 => this..textColor(Colors.greenAccent[200]);

  ///set the textColor [Colors.greenAccent[400]]
  T get textGreenAccent400 => this..textColor(Colors.greenAccent[400]);

  ///set the textColor [Colors.greenAccent[700]]
  T get textGreenAccent700 => this..textColor(Colors.greenAccent[700]);

  ///set the textColor [Colors.lightGreen]
  T get textLightGreen => this..textColor(Colors.lightGreen);

  ///set the textColor [Colors.lightGreen[50]]
  T get textLightGreen50 => this..textColor(Colors.lightGreen[50]);

  ///set the textColor [Colors.lightGreen[100]]
  T get textLightGreen100 => this..textColor(Colors.lightGreen[100]);

  ///set the textColor [Colors.lightGreen[200]]
  T get textLightGreen200 => this..textColor(Colors.lightGreen[200]);

  ///set the textColor [Colors.lightGreen[300]]
  T get textLightGreen300 => this..textColor(Colors.lightGreen[300]);

  ///set the textColor [Colors.lightGreen[400]]
  T get textLightGreen400 => this..textColor(Colors.lightGreen[400]);

  ///set the textColor [Colors.lightGreen[500]]
  T get textLightGreen500 => this..textColor(Colors.lightGreen[500]);

  ///set the textColor [Colors.lightGreen[600]]
  T get textLightGreen600 => this..textColor(Colors.lightGreen[600]);

  ///set the textColor [Colors.lightGreen[700]]
  T get textLightGreen700 => this..textColor(Colors.lightGreen[700]);

  ///set the textColor [Colors.lightGreen[800]]
  T get textLightGreen800 => this..textColor(Colors.lightGreen[800]);

  ///set the textColor [Colors.lightGreen[900]]
  T get textLightGreen900 => this..textColor(Colors.lightGreen[900]);

  ///set the textColor [Colors.lime]
  T get textLime => this..textColor(Colors.lime);

  ///set the textColor [Colors.lime[50]]
  T get textLime50 => this..textColor(Colors.lime[50]);

  ///set the textColor [Colors.lime[100]]
  T get textLime100 => this..textColor(Colors.lime[100]);

  ///set the textColor [Colors.lime[200]]
  T get textLime200 => this..textColor(Colors.lime[200]);

  ///set the textColor [Colors.lime[300]]
  T get textLime300 => this..textColor(Colors.lime[300]);

  ///set the textColor [Colors.lime[400]]
  T get textLime400 => this..textColor(Colors.lime[400]);

  ///set the textColor [Colors.lime[500]]
  T get textLime500 => this..textColor(Colors.lime[500]);

  ///set the textColor [Colors.lime[600]]
  T get textLime600 => this..textColor(Colors.lime[600]);

  ///set the textColor [Colors.lime[700]]
  T get textLime700 => this..textColor(Colors.lime[700]);

  ///set the textColor [Colors.lime[800]]
  T get textLime800 => this..textColor(Colors.lime[800]);

  ///set the textColor [Colors.lime[900]]
  T get textLime900 => this..textColor(Colors.lime[900]);

  ///set the textColor [Colors.blue]
  T get textBlue => this..textColor(Colors.blue);

  ///set the textColor [Colors.blue[50]]
  T get textBlue50 => this..textColor(Colors.blue[50]);

  ///set the textColor [Colors.blue[100]]
  T get textBlue100 => this..textColor(Colors.blue[100]);

  ///set the textColor [Colors.blue[200]]
  T get textBlue200 => this..textColor(Colors.blue[200]);

  ///set the textColor [Colors.blue[300]]
  T get textBlue300 => this..textColor(Colors.blue[300]);

  ///set the textColor [Colors.blue[400]]
  T get textBlue400 => this..textColor(Colors.blue[400]);

  ///set the textColor [Colors.blue[500]]
  T get textBlue500 => this..textColor(Colors.blue[500]);

  ///set the textColor [Colors.blue[600]]
  T get textBlue600 => this..textColor(Colors.blue[600]);

  ///set the textColor [Colors.blue[700]]
  T get textBlue700 => this..textColor(Colors.blue[700]);

  ///set the textColor [Colors.blue[800]]
  T get textBlue800 => this..textColor(Colors.blue[800]);

  ///set the textColor [Colors.blue[900]]
  T get textBlue900 => this..textColor(Colors.blue[900]);

  ///set the textColor [Colors.blueAccent]
  T get textBlueAccent => this..textColor(Colors.blueAccent);

  ///set the textColor [Colors.blueAccent[100]]
  T get textBlueAccent100 => this..textColor(Colors.blueAccent[100]);

  ///set the textColor [Colors.blueAccent[200]]
  T get textBlueAccent200 => this..textColor(Colors.blueAccent[200]);

  ///set the textColor [Colors.blueAccent[400]]
  T get textBlueAccent400 => this..textColor(Colors.blueAccent[400]);

  ///set the textColor [Colors.blueAccent[700]]
  T get textBlueAccent700 => this..textColor(Colors.blueAccent[700]);

  ///set the textColor [Colors.lightBlue]
  T get textLightBlue => this..textColor(Colors.lightBlue);

  ///set the textColor [Colors.lightBlue[50]]
  T get textLightBlue50 => this..textColor(Colors.lightBlue[50]);

  ///set the textColor [Colors.lightBlue[100]]
  T get textLightBlue100 => this..textColor(Colors.lightBlue[100]);

  ///set the textColor [Colors.lightBlue[200]]
  T get textLightBlue200 => this..textColor(Colors.lightBlue[200]);

  ///set the textColor [Colors.lightBlue[300]]
  T get textLightBlue300 => this..textColor(Colors.lightBlue[300]);

  ///set the textColor [Colors.lightBlue[400]]
  T get textLightBlue400 => this..textColor(Colors.lightBlue[400]);

  ///set the textColor [Colors.lightBlue[500]]
  T get textLightBlue500 => this..textColor(Colors.lightBlue[500]);

  ///set the textColor [Colors.lightBlue[600]]
  T get textLightBlue600 => this..textColor(Colors.lightBlue[600]);

  ///set the textColor [Colors.lightBlue[700]]
  T get textLightBlue700 => this..textColor(Colors.lightBlue[700]);

  ///set the textColor [Colors.lightBlue[800]]
  T get textLightBlue800 => this..textColor(Colors.lightBlue[800]);

  ///set the textColor [Colors.lightBlue[900]]
  T get textLightBlue900 => this..textColor(Colors.lightBlue[900]);

  ///set the textColor [Colors.blueGrey]
  T get textBlueGrey => this..textColor(Colors.blueGrey);

  ///set the textColor [Colors.blueGrey[50]]
  T get textBlueGrey50 => this..textColor(Colors.blueGrey[50]);

  ///set the textColor [Colors.blueGrey[100]]
  T get textBlueGrey100 => this..textColor(Colors.blueGrey[100]);

  ///set the textColor [Colors.blueGrey[200]]
  T get textBlueGrey200 => this..textColor(Colors.blueGrey[200]);

  ///set the textColor [Colors.blueGrey[300]]
  T get textBlueGrey300 => this..textColor(Colors.blueGrey[300]);

  ///set the textColor [Colors.blueGrey[400]]
  T get textBlueGrey400 => this..textColor(Colors.blueGrey[400]);

  ///set the textColor [Colors.blueGrey[500]]
  T get textBlueGrey500 => this..textColor(Colors.blueGrey[500]);

  ///set the textColor [Colors.blueGrey[600]]
  T get textBlueGrey600 => this..textColor(Colors.blueGrey[600]);

  ///set the textColor [Colors.blueGrey[700]]
  T get textBlueGrey700 => this..textColor(Colors.blueGrey[700]);

  ///set the textColor [Colors.blueGrey[800]]
  T get textBlueGrey800 => this..textColor(Colors.blueGrey[800]);

  ///set the textColor [Colors.blueGrey[900]]
  T get textBlueGrey900 => this..textColor(Colors.blueGrey[900]);

  ///set the textColor [Colors.indigoAccent]
  T get textIndigoAccent => this..textColor(Colors.indigoAccent);

  ///set the textColor [Colors.indigoAccent[100]]
  T get textIndigoAccent100 => this..textColor(Colors.indigoAccent[100]);

  ///set the textColor [Colors.indigoAccent[200]]
  T get textIndigoAccent200 => this..textColor(Colors.indigoAccent[200]);

  ///set the textColor [Colors.indigoAccent[400]]
  T get textIndigoAccent400 => this..textColor(Colors.indigoAccent[400]);

  ///set the textColor [Colors.indigoAccent[700]]
  T get textIndigoAccent700 => this..textColor(Colors.indigoAccent[700]);

  ///set the textColor [Colors.yellow]
  T get textYellow => this..textColor(Colors.yellow);

  ///set the textColor [Colors.yellow[50]]
  T get textYellow50 => this..textColor(Colors.yellow[50]);

  ///set the textColor [Colors.yellow[100]]
  T get textYellow100 => this..textColor(Colors.yellow[100]);

  ///set the textColor [Colors.yellow[200]]
  T get textYellow200 => this..textColor(Colors.yellow[200]);

  ///set the textColor [Colors.yellow[300]]
  T get textYellow300 => this..textColor(Colors.yellow[300]);

  ///set the textColor [Colors.yellow[400]]
  T get textYellow400 => this..textColor(Colors.yellow[400]);

  ///set the textColor [Colors.yellow[500]]
  T get textYellow500 => this..textColor(Colors.yellow[500]);

  ///set the textColor [Colors.yellow[600]]
  T get textYellow600 => this..textColor(Colors.yellow[600]);

  ///set the textColor [Colors.yellow[700]]
  T get textYellow700 => this..textColor(Colors.yellow[700]);

  ///set the textColor [Colors.yellow[800]]
  T get textYellow800 => this..textColor(Colors.yellow[800]);

  ///set the textColor [Colors.yellow[900]]
  T get textYellow900 => this..textColor(Colors.yellow[900]);

  ///set the textColor [Colors.yellowAccent]
  T get textYellowAccent => this..textColor(Colors.yellowAccent);

  ///set the textColor [Colors.yellowAccent[100]]
  T get textYellowAccent100 => this..textColor(Colors.yellowAccent[100]);

  ///set the textColor [Colors.yellowAccent[200]]
  T get textYellowAccent200 => this..textColor(Colors.yellowAccent[200]);

  ///set the textColor [Colors.yellowAccent[400]]
  T get textYellowAccent400 => this..textColor(Colors.yellowAccent[400]);

  ///set the textColor [Colors.yellowAccent[700]]
  T get textYellowAccent700 => this..textColor(Colors.yellowAccent[700]);

  ///set the textColor [Colors.amber]
  T get textAmber => this..textColor(Colors.amber);

  ///set the textColor [Colors.amber[50]]
  T get textAmber50 => this..textColor(Colors.amber[50]);

  ///set the textColor [Colors.amber[100]]
  T get textAmber100 => this..textColor(Colors.amber[100]);

  ///set the textColor [Colors.amber[200]]
  T get textAmber200 => this..textColor(Colors.amber[200]);

  ///set the textColor [Colors.amber[300]]
  T get textAmber300 => this..textColor(Colors.amber[300]);

  ///set the textColor [Colors.amber[400]]
  T get textAmber400 => this..textColor(Colors.amber[400]);

  ///set the textColor [Colors.amber[500]]
  T get textAmber500 => this..textColor(Colors.amber[500]);

  ///set the textColor [Colors.amber[600]]
  T get textAmber600 => this..textColor(Colors.amber[600]);

  ///set the textColor [Colors.amber[700]]
  T get textAmber700 => this..textColor(Colors.amber[700]);

  ///set the textColor [Colors.amber[800]]
  T get textAmber800 => this..textColor(Colors.amber[800]);

  ///set the textColor [Colors.amber[900]]
  T get textAmber900 => this..textColor(Colors.amber[900]);

  ///set the textColor [Colors.amberAccent]
  T get textAmberAccent => this..textColor(Colors.amberAccent);

  ///set the textColor [Colors.amberAccent[100]]
  T get textAmberAccent100 => this..textColor(Colors.amberAccent[100]);

  ///set the textColor [Colors.amberAccent[200]]
  T get textAmberAccent200 => this..textColor(Colors.amberAccent[200]);

  ///set the textColor [Colors.amberAccent[400]]
  T get textAmberAccent400 => this..textColor(Colors.amberAccent[400]);

  ///set the textColor [Colors.amberAccent[700]]
  T get textAmberAccent700 => this..textColor(Colors.amberAccent[700]);

  ///set the textColor [Colors.purple]
  T get textPurple => this..textColor(Colors.purple);

  ///set the textColor [Colors.purple[50]]
  T get textPurple50 => this..textColor(Colors.purple[50]);

  ///set the textColor [Colors.purple[100]]
  T get textPurple100 => this..textColor(Colors.purple[100]);

  ///set the textColor [Colors.purple[200]]
  T get textPurple200 => this..textColor(Colors.purple[200]);

  ///set the textColor [Colors.purple[300]]
  T get textPurple300 => this..textColor(Colors.purple[300]);

  ///set the textColor [Colors.purple[400]]
  T get textPurple400 => this..textColor(Colors.purple[400]);

  ///set the textColor [Colors.purple[500]]
  T get textPurple500 => this..textColor(Colors.purple[500]);

  ///set the textColor [Colors.purple[600]]
  T get textPurple600 => this..textColor(Colors.purple[600]);

  ///set the textColor [Colors.purple[700]]
  T get textPurple700 => this..textColor(Colors.purple[700]);

  ///set the textColor [Colors.purple[800]]
  T get textPurple800 => this..textColor(Colors.purple[800]);

  ///set the textColor [Colors.purple[900]]
  T get textPurple900 => this..textColor(Colors.purple[900]);

  ///set the textColor [Colors.purpleAccent]
  T get textPurpleAccent => this..textColor(Colors.purpleAccent);

  ///set the textColor [Colors.purpleAccent[100]]
  T get textPurpleAccent100 => this..textColor(Colors.purpleAccent[100]);

  ///set the textColor [Colors.purpleAccent[200]]
  T get textPurpleAccent200 => this..textColor(Colors.purpleAccent[200]);

  ///set the textColor [Colors.purpleAccent[400]]
  T get textPurpleAccent400 => this..textColor(Colors.purpleAccent[400]);

  ///set the textColor [Colors.purpleAccent[700]]
  T get textPurpleAccent700 => this..textColor(Colors.purpleAccent[700]);

  ///set the textColor [Colors.orange]
  T get textOrange => this..textColor(Colors.orange);

  ///set the textColor [Colors.orange[50]]
  T get textOrange50 => this..textColor(Colors.orange[50]);

  ///set the textColor [Colors.orange[100]]
  T get textOrange100 => this..textColor(Colors.orange[100]);

  ///set the textColor [Colors.orange[200]]
  T get textOrange200 => this..textColor(Colors.orange[200]);

  ///set the textColor [Colors.orange[300]]
  T get textOrange300 => this..textColor(Colors.orange[300]);

  ///set the textColor [Colors.orange[400]]
  T get textOrange400 => this..textColor(Colors.orange[400]);

  ///set the textColor [Colors.orange[500]]
  T get textOrange500 => this..textColor(Colors.orange[500]);

  ///set the textColor [Colors.orange[600]]
  T get textOrange600 => this..textColor(Colors.orange[600]);

  ///set the textColor [Colors.orange[700]]
  T get textOrange700 => this..textColor(Colors.orange[700]);

  ///set the textColor [Colors.orange[800]]
  T get textOrange800 => this..textColor(Colors.orange[800]);

  ///set the textColor [Colors.orange[900]]
  T get textOrange900 => this..textColor(Colors.orange[900]);

  ///set the textColor [Colors.orangeAccent]
  T get textOrangeAccent => this..textColor(Colors.orangeAccent);

  ///set the textColor [Colors.orangeAccent[100]]
  T get textOrangeAccent100 => this..textColor(Colors.orangeAccent[100]);

  ///set the textColor [Colors.orangeAccent[200]]
  T get textOrangeAccent200 => this..textColor(Colors.orangeAccent[200]);

  ///set the textColor [Colors.orangeAccent[400]]
  T get textOrangeAccent400 => this..textColor(Colors.orangeAccent[400]);

  ///set the textColor [Colors.orangeAccent[700]]
  T get textOrangeAccent700 => this..textColor(Colors.orangeAccent[700]);

  ///set the textColor [Colors.brown]
  T get textBrown => this..textColor(Colors.brown);

  ///set the textColor [Colors.brown[50]]
  T get textBrown50 => this..textColor(Colors.brown[50]);

  ///set the textColor [Colors.brown[100]]
  T get textBrown100 => this..textColor(Colors.brown[100]);

  ///set the textColor [Colors.brown[200]]
  T get textBrown200 => this..textColor(Colors.brown[200]);

  ///set the textColor [Colors.brown[300]]
  T get textBrown300 => this..textColor(Colors.brown[300]);

  ///set the textColor [Colors.brown[400]]
  T get textBrown400 => this..textColor(Colors.brown[400]);

  ///set the textColor [Colors.brown[500]]
  T get textBrown500 => this..textColor(Colors.brown[500]);

  ///set the textColor [Colors.brown[600]]
  T get textBrown600 => this..textColor(Colors.brown[600]);

  ///set the textColor [Colors.brown[700]]
  T get textBrown700 => this..textColor(Colors.brown[700]);

  ///set the textColor [Colors.brown[800]]
  T get textBrown800 => this..textColor(Colors.brown[800]);

  ///set the textColor [Colors.brown[900]]
  T get textBrown900 => this..textColor(Colors.brown[900]);

  ///set the textColor [Colors.pink]
  T get textPink => this..textColor(Colors.pink);

  ///set the textColor [Colors.pink[50]]
  T get textPink50 => this..textColor(Colors.pink[50]);

  ///set the textColor [Colors.pink[100]]
  T get textPink100 => this..textColor(Colors.pink[100]);

  ///set the textColor [Colors.pink[200]]
  T get textPink200 => this..textColor(Colors.pink[200]);

  ///set the textColor [Colors.pink[300]]
  T get textPink300 => this..textColor(Colors.pink[300]);

  ///set the textColor [Colors.pink[400]]
  T get textPink400 => this..textColor(Colors.pink[400]);

  ///set the textColor [Colors.pink[500]]
  T get textPink500 => this..textColor(Colors.pink[500]);

  ///set the textColor [Colors.pink[600]]
  T get textPink600 => this..textColor(Colors.pink[600]);

  ///set the textColor [Colors.pink[700]]
  T get textPink700 => this..textColor(Colors.pink[700]);

  ///set the textColor [Colors.pink[800]]
  T get textPink800 => this..textColor(Colors.pink[800]);

  ///set the textColor [Colors.pink[900]]
  T get textPink900 => this..textColor(Colors.pink[900]);

  ///set the textColor [Colors.grey]
  T get textGrey => this..textColor(Colors.grey);

  ///set the textColor [Colors.grey[50]]
  T get textGrey50 => this..textColor(Colors.grey[50]);

  ///set the textColor [Colors.grey[100]]
  T get textGrey100 => this..textColor(Colors.grey[100]);

  ///set the textColor [Colors.grey[200]]
  T get textGrey200 => this..textColor(Colors.grey[200]);

  ///set the textColor [Colors.grey[300]]
  T get textGrey300 => this..textColor(Colors.grey[300]);

  ///set the textColor [Colors.grey[400]]
  T get textGrey400 => this..textColor(Colors.grey[400]);

  ///set the textColor [Colors.grey[500]]
  T get textGrey500 => this..textColor(Colors.grey[500]);

  ///set the textColor [Colors.grey[600]]
  T get textGrey600 => this..textColor(Colors.grey[600]);

  ///set the textColor [Colors.grey[700]]
  T get textGrey700 => this..textColor(Colors.grey[700]);

  ///set the textColor [Colors.grey[800]]
  T get textGrey800 => this..textColor(Colors.grey[800]);

  ///set the textColor [Colors.grey[900]]
  T get textGrey900 => this..textColor(Colors.grey[900]);

  ///set the textColor [Colors.cyan]
  T get textCyan => this..textColor(Colors.cyan);

  ///set the textColor [Colors.cyan[50]]
  T get textCyan50 => this..textColor(Colors.cyan[50]);

  ///set the textColor [Colors.cyan[100]]
  T get textCyan100 => this..textColor(Colors.cyan[100]);

  ///set the textColor [Colors.cyan[200]]
  T get textCyan200 => this..textColor(Colors.cyan[200]);

  ///set the textColor [Colors.cyan[300]]
  T get textCyan300 => this..textColor(Colors.cyan[300]);

  ///set the textColor [Colors.cyan[400]]
  T get textCyan400 => this..textColor(Colors.cyan[400]);

  ///set the textColor [Colors.cyan[500]]
  T get textCyan500 => this..textColor(Colors.cyan[500]);

  ///set the textColor [Colors.cyan[600]]
  T get textCyan600 => this..textColor(Colors.cyan[600]);

  ///set the textColor [Colors.cyan[700]]
  T get textCyan700 => this..textColor(Colors.cyan[700]);

  ///set the textColor [Colors.cyan[800]]
  T get textCyan800 => this..textColor(Colors.cyan[800]);

  ///set the textColor [Colors.cyan[900]]
  T get textCyan900 => this..textColor(Colors.cyan[900]);

  ///set the textColor [Colors.deepOrange]
  T get textDeepOrange => this..textColor(Colors.deepOrange);

  ///set the textColor [Colors.deepOrange[50]]
  T get textDeepOrange50 => this..textColor(Colors.deepOrange[50]);

  ///set the textColor [Colors.deepOrange[100]]
  T get textDeepOrange100 => this..textColor(Colors.deepOrange[100]);

  ///set the textColor [Colors.deepOrange[200]]
  T get textDeepOrange200 => this..textColor(Colors.deepOrange[200]);

  ///set the textColor [Colors.deepOrange[300]]
  T get textDeepOrange300 => this..textColor(Colors.deepOrange[300]);

  ///set the textColor [Colors.deepOrange[400]]
  T get textDeepOrange400 => this..textColor(Colors.deepOrange[400]);

  ///set the textColor [Colors.deepOrange[500]]
  T get textDeepOrange500 => this..textColor(Colors.deepOrange[500]);

  ///set the textColor [Colors.deepOrange[600]]
  T get textDeepOrange600 => this..textColor(Colors.deepOrange[600]);

  ///set the textColor [Colors.deepOrange[700]]
  T get textDeepOrange700 => this..textColor(Colors.deepOrange[700]);

  ///set the textColor [Colors.deepOrange[800]]
  T get textDeepOrange800 => this..textColor(Colors.deepOrange[800]);

  ///set the textColor [Colors.deepOrange[900]]
  T get textDeepOrange900 => this..textColor(Colors.deepOrange[900]);

  ///set the textColor [Colors.teal]
  T get textTeal => this..textColor(Colors.teal);

  ///set the textColor [Colors.teal[50]]
  T get textTeal50 => this..textColor(Colors.teal[50]);

  ///set the textColor [Colors.teal[100]]
  T get textTeal100 => this..textColor(Colors.teal[100]);

  ///set the textColor [Colors.teal[200]]
  T get textTeal200 => this..textColor(Colors.teal[200]);

  ///set the textColor [Colors.teal[300]]
  T get textTeal300 => this..textColor(Colors.teal[300]);

  ///set the textColor [Colors.teal[400]]
  T get textTeal400 => this..textColor(Colors.teal[400]);

  ///set the textColor [Colors.teal[500]]
  T get textTeal500 => this..textColor(Colors.teal[500]);

  ///set the textColor [Colors.teal[600]]
  T get textTeal600 => this..textColor(Colors.teal[600]);

  ///set the textColor [Colors.teal[700]]
  T get textTeal700 => this..textColor(Colors.teal[700]);

  ///set the textColor [Colors.teal[800]]
  T get textTeal800 => this..textColor(Colors.teal[800]);

  ///set the textColor [Colors.teal[900]]
  T get textTeal900 => this..textColor(Colors.teal[900]);

  ///set the textColor [Colors.tealAccent]
  T get textTealAccent => this..textColor(Colors.tealAccent);

  ///set the textColor [Colors.tealAccent[100]]
  T get textTealAccent100 => this..textColor(Colors.tealAccent[100]);

  ///set the textColor [Colors.tealAccent[200]]
  T get textTealAccent200 => this..textColor(Colors.tealAccent[200]);

  ///set the textColor [Colors.tealAccent[400]]
  T get textTealAccent400 => this..textColor(Colors.tealAccent[400]);

  ///set the textColor [Colors.tealAccent[700]]
  T get textTealAccent700 => this..textColor(Colors.tealAccent[700]);

  ///set the textColor [Colors.deepPurple]
  T get textDeepPurple => this..textColor(Colors.deepPurple);

  ///set the textColor [Colors.deepPurple[50]]
  T get textDeepPurple50 => this..textColor(Colors.deepPurple[50]);

  ///set the textColor [Colors.deepPurple[100]]
  T get textDeepPurple100 => this..textColor(Colors.deepPurple[100]);

  ///set the textColor [Colors.deepPurple[200]]
  T get textDeepPurple200 => this..textColor(Colors.deepPurple[200]);

  ///set the textColor [Colors.deepPurple[300]]
  T get textDeepPurple300 => this..textColor(Colors.deepPurple[300]);

  ///set the textColor [Colors.deepPurple[400]]
  T get textDeepPurple400 => this..textColor(Colors.deepPurple[400]);

  ///set the textColor [Colors.deepPurple[500]]
  T get textDeepPurple500 => this..textColor(Colors.deepPurple[500]);

  ///set the textColor [Colors.deepPurple[600]]
  T get textDeepPurple600 => this..textColor(Colors.deepPurple[600]);

  ///set the textColor [Colors.deepPurple[700]]
  T get textDeepPurple700 => this..textColor(Colors.deepPurple[700]);

  ///set the textColor [Colors.deepPurple[800]]
  T get textDeepPurple800 => this..textColor(Colors.deepPurple[800]);

  ///set the textColor [Colors.deepPurple[900]]
  T get textDeepPurple900 => this..textColor(Colors.deepPurple[900]);

  ///set the textColor [Colors.indigo]
  T get textIndigo => this..textColor(Colors.indigo);

  ///set the textColor [Colors.indigo[50]]
  T get textIndigo50 => this..textColor(Colors.indigo[50]);

  ///set the textColor [Colors.indigo[100]]
  T get textIndigo100 => this..textColor(Colors.indigo[100]);

  ///set the textColor [Colors.indigo[200]]
  T get textIndigo200 => this..textColor(Colors.indigo[200]);

  ///set the textColor [Colors.indigo[300]]
  T get textIndigo300 => this..textColor(Colors.indigo[300]);

  ///set the textColor [Colors.indigo[400]]
  T get textIndigo400 => this..textColor(Colors.indigo[400]);

  ///set the textColor [Colors.indigo[500]]
  T get textIndigo500 => this..textColor(Colors.indigo[500]);

  ///set the textColor [Colors.indigo[600]]
  T get textIndigo600 => this..textColor(Colors.indigo[600]);

  ///set the textColor [Colors.indigo[700]]
  T get textIndigo700 => this..textColor(Colors.indigo[700]);

  ///set the textColor [Colors.indigo[800]]
  T get textIndigo800 => this..textColor(Colors.indigo[800]);

  ///set the textColor [Colors.indigo[900]]
  T get textIndigo900 => this..textColor(Colors.indigo[900]);
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

  ///flutter system color [Colors.red[50]]
  T get red50 => this..color(Colors.red[50]);

  ///flutter system color [Colors.red[100]]
  T get red100 => this..color(Colors.red[100]);

  ///flutter system color [Colors.red[200]]
  T get red200 => this..color(Colors.red[200]);

  ///flutter system color [Colors.red[300]]
  T get red300 => this..color(Colors.red[300]);

  ///flutter system color [Colors.red[400]]
  T get red400 => this..color(Colors.red[400]);

  ///flutter system color [Colors.red[500]]
  T get red500 => this..color(Colors.red[500]);

  ///flutter system color [Colors.red[600]]
  T get red600 => this..color(Colors.red[600]);

  ///flutter system color [Colors.red[700]]
  T get red700 => this..color(Colors.red[700]);

  ///flutter system color [Colors.red[800]]
  T get red800 => this..color(Colors.red[800]);

  ///flutter system color [Colors.red[900]]
  T get red900 => this..color(Colors.red[900]);

  ///flutter system color [Colors.redAccent]
  T get redAccent => this..color(Colors.redAccent);

  ///flutter system color [Colors.redAccent[100]]
  T get redAccent100 => this..color(Colors.redAccent[100]);

  ///flutter system color [Colors.redAccent[200]]
  T get redAccent200 => this..color(Colors.redAccent[200]);

  ///flutter system color [Colors.redAccent[400]]
  T get redAccent400 => this..color(Colors.redAccent[400]);

  ///flutter system color [Colors.redAccent[700]]
  T get redAccent700 => this..color(Colors.redAccent[700]);

  ///flutter system color [Colors.green]
  T get green => this..color(Colors.green);

  ///flutter system color [Colors.green[50]]
  T get green50 => this..color(Colors.green[50]);

  ///flutter system color [Colors.green[100]]
  T get green100 => this..color(Colors.green[100]);

  ///flutter system color [Colors.green[200]]
  T get green200 => this..color(Colors.green[200]);

  ///flutter system color [Colors.green[300]]
  T get green300 => this..color(Colors.green[300]);

  ///flutter system color [Colors.green[400]]
  T get green400 => this..color(Colors.green[400]);

  ///flutter system color [Colors.green[500]]
  T get green500 => this..color(Colors.green[500]);

  ///flutter system color [Colors.green[600]]
  T get green600 => this..color(Colors.green[600]);

  ///flutter system color [Colors.green[700]]
  T get green700 => this..color(Colors.green[700]);

  ///flutter system color [Colors.green[800]]
  T get green800 => this..color(Colors.green[800]);

  ///flutter system color [Colors.green[900]]
  T get green900 => this..color(Colors.green[900]);

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
  /// ![](https://flutter.github.io/assets-for-api-docs
  ///flutter system color [Colors.greenAccent]/assets/material/Colors.limeAccent.png)
  T get greenAccent => this..color(Colors.greenAccent);

  ///flutter system color [Colors.greenAccent[100]]
  T get greenAccent100 => this..color(Colors.greenAccent[100]);

  ///flutter system color [Colors.greenAccent[200]]
  T get greenAccent200 => this..color(Colors.greenAccent[200]);

  ///flutter system color [Colors.greenAccent[400]]
  T get greenAccent400 => this..color(Colors.greenAccent[400]);

  ///flutter system color [Colors.greenAccent[700]]
  T get greenAccent700 => this..color(Colors.greenAccent[700]);

  ///flutter system color [Colors.lightGreen]
  T get lightGreen => this..color(Colors.lightGreen);

  ///flutter system color [Colors.lightGreen[50]]
  T get lightGreen50 => this..color(Colors.lightGreen[50]);

  ///flutter system color [Colors.lightGreen[100]]
  T get lightGreen100 => this..color(Colors.lightGreen[100]);

  ///flutter system color [Colors.lightGreen[200]]
  T get lightGreen200 => this..color(Colors.lightGreen[200]);

  ///flutter system color [Colors.lightGreen[300]]
  T get lightGreen300 => this..color(Colors.lightGreen[300]);

  ///flutter system color [Colors.lightGreen[400]]
  T get lightGreen400 => this..color(Colors.lightGreen[400]);

  ///flutter system color [Colors.lightGreen[500]]
  T get lightGreen500 => this..color(Colors.lightGreen[500]);

  ///flutter system color [Colors.lightGreen[600]]
  T get lightGreen600 => this..color(Colors.lightGreen[600]);

  ///flutter system color [Colors.lightGreen[700]]
  T get lightGreen700 => this..color(Colors.lightGreen[700]);

  ///flutter system color [Colors.lightGreen[800]]
  T get lightGreen800 => this..color(Colors.lightGreen[800]);

  ///flutter system color [Colors.lightGreen[900]]
  T get lightGreen900 => this..color(Colors.lightGreen[900]);

  ///flutter system color [Colors.lime]
  T get lime => this..color(Colors.lime);

  ///flutter system color [Colors.lime[50]]
  T get lime50 => this..color(Colors.lime[50]);

  ///flutter system color [Colors.lime[100]]
  T get lime100 => this..color(Colors.lime[100]);

  ///flutter system color [Colors.lime[200]]
  T get lime200 => this..color(Colors.lime[200]);

  ///flutter system color [Colors.lime[300]]
  T get lime300 => this..color(Colors.lime[300]);

  ///flutter system color [Colors.lime[400]]
  T get lime400 => this..color(Colors.lime[400]);

  ///flutter system color [Colors.lime[500]]
  T get lime500 => this..color(Colors.lime[500]);

  ///flutter system color [Colors.lime[600]]
  T get lime600 => this..color(Colors.lime[600]);

  ///flutter system color [Colors.lime[700]]
  T get lime700 => this..color(Colors.lime[700]);

  ///flutter system color [Colors.lime[800]]
  T get lime800 => this..color(Colors.lime[800]);

  ///flutter system color [Colors.lime[900]]
  T get lime900 => this..color(Colors.lime[900]);

  ///flutter system color [Colors.blue]
  T get blue => this..color(Colors.blue);

  ///flutter system color [Colors.blue[50]]
  T get blue50 => this..color(Colors.blue[50]);

  ///flutter system color [Colors.blue[100]]
  T get blue100 => this..color(Colors.blue[100]);

  ///flutter system color [Colors.blue[200]]
  T get blue200 => this..color(Colors.blue[200]);

  ///flutter system color [Colors.blue[300]]
  T get blue300 => this..color(Colors.blue[300]);

  ///flutter system color [Colors.blue[400]]
  T get blue400 => this..color(Colors.blue[400]);

  ///flutter system color [Colors.blue[500]]
  T get blue500 => this..color(Colors.blue[500]);

  ///flutter system color [Colors.blue[600]]
  T get blue600 => this..color(Colors.blue[600]);

  ///flutter system color [Colors.blue[700]]
  T get blue700 => this..color(Colors.blue[700]);

  ///flutter system color [Colors.blue[800]]
  T get blue800 => this..color(Colors.blue[800]);

  ///flutter system color [Colors.blue[900]]
  T get blue900 => this..color(Colors.blue[900]);

  ///flutter system color [Colors.blueAccent]
  T get blueAccent => this..color(Colors.blueAccent);

  ///flutter system color [Colors.blueAccent[100]]
  T get blueAccent100 => this..color(Colors.blueAccent[100]);

  ///flutter system color [Colors.blueAccent[200]]
  T get blueAccent200 => this..color(Colors.blueAccent[200]);

  ///flutter system color [Colors.blueAccent[400]]
  T get blueAccent400 => this..color(Colors.blueAccent[400]);

  ///flutter system color [Colors.blueAccent[700]]
  T get blueAccent700 => this..color(Colors.blueAccent[700]);

  ///flutter system color [Colors.lightBlue]
  T get lightBlue => this..color(Colors.lightBlue);

  ///flutter system color [Colors.lightBlue[50]]
  T get lightBlue50 => this..color(Colors.lightBlue[50]);

  ///flutter system color [Colors.lightBlue[100]]
  T get lightBlue100 => this..color(Colors.lightBlue[100]);

  ///flutter system color [Colors.lightBlue[200]]
  T get lightBlue200 => this..color(Colors.lightBlue[200]);

  ///flutter system color [Colors.lightBlue[300]]
  T get lightBlue300 => this..color(Colors.lightBlue[300]);

  ///flutter system color [Colors.lightBlue[400]]
  T get lightBlue400 => this..color(Colors.lightBlue[400]);

  ///flutter system color [Colors.lightBlue[500]]
  T get lightBlue500 => this..color(Colors.lightBlue[500]);

  ///flutter system color [Colors.lightBlue[600]]
  T get lightBlue600 => this..color(Colors.lightBlue[600]);

  ///flutter system color [Colors.lightBlue[700]]
  T get lightBlue700 => this..color(Colors.lightBlue[700]);

  ///flutter system color [Colors.lightBlue[800]]
  T get lightBlue800 => this..color(Colors.lightBlue[800]);

  ///flutter system color [Colors.lightBlue[900]]
  T get lightBlue900 => this..color(Colors.lightBlue[900]);

  ///flutter system color [Colors.blueGrey]
  T get blueGrey => this..color(Colors.blueGrey);

  ///flutter system color [Colors.blueGrey[50]]
  T get blueGrey50 => this..color(Colors.blueGrey[50]);

  ///flutter system color [Colors.blueGrey[100]]
  T get blueGrey100 => this..color(Colors.blueGrey[100]);

  ///flutter system color [Colors.blueGrey[200]]
  T get blueGrey200 => this..color(Colors.blueGrey[200]);

  ///flutter system color [Colors.blueGrey[300]]
  T get blueGrey300 => this..color(Colors.blueGrey[300]);

  ///flutter system color [Colors.blueGrey[400]]
  T get blueGrey400 => this..color(Colors.blueGrey[400]);

  ///flutter system color [Colors.blueGrey[500]]
  T get blueGrey500 => this..color(Colors.blueGrey[500]);

  ///flutter system color [Colors.blueGrey[600]]
  T get blueGrey600 => this..color(Colors.blueGrey[600]);

  ///flutter system color [Colors.blueGrey[700]]
  T get blueGrey700 => this..color(Colors.blueGrey[700]);

  ///flutter system color [Colors.blueGrey[800]]
  T get blueGrey800 => this..color(Colors.blueGrey[800]);

  ///flutter system color [Colors.blueGrey[900]]
  T get blueGrey900 => this..color(Colors.blueGrey[900]);

  ///flutter system color [Colors.indigoAccent]
  T get indigoAccent => this..color(Colors.indigoAccent);

  ///flutter system color [Colors.indigoAccent[100]]
  T get indigoAccent100 => this..color(Colors.indigoAccent[100]);

  ///flutter system color [Colors.indigoAccent[200]]
  T get indigoAccent200 => this..color(Colors.indigoAccent[200]);

  ///flutter system color [Colors.indigoAccent[400]]
  T get indigoAccent400 => this..color(Colors.indigoAccent[400]);

  ///flutter system color [Colors.indigoAccent[700]]
  T get indigoAccent700 => this..color(Colors.indigoAccent[700]);

  ///flutter system color [Colors.yellow]
  T get yellow => this..color(Colors.yellow);

  ///flutter system color [Colors.yellow[50]]
  T get yellow50 => this..color(Colors.yellow[50]);

  ///flutter system color [Colors.yellow[100]]
  T get yellow100 => this..color(Colors.yellow[100]);

  ///flutter system color [Colors.yellow[200]]
  T get yellow200 => this..color(Colors.yellow[200]);

  ///flutter system color [Colors.yellow[300]]
  T get yellow300 => this..color(Colors.yellow[300]);

  ///flutter system color [Colors.yellow[400]]
  T get yellow400 => this..color(Colors.yellow[400]);

  ///flutter system color [Colors.yellow[500]]
  T get yellow500 => this..color(Colors.yellow[500]);

  ///flutter system color [Colors.yellow[600]]
  T get yellow600 => this..color(Colors.yellow[600]);

  ///flutter system color [Colors.yellow[700]]
  T get yellow700 => this..color(Colors.yellow[700]);

  ///flutter system color [Colors.yellow[800]]
  T get yellow800 => this..color(Colors.yellow[800]);

  ///flutter system color [Colors.yellow[900]]
  T get yellow900 => this..color(Colors.yellow[900]);

  ///flutter system color [Colors.yellowAccent]
  T get yellowAccent => this..color(Colors.yellowAccent);

  ///flutter system color [Colors.yellowAccent[100]]
  T get yellowAccent100 => this..color(Colors.yellowAccent[100]);

  ///flutter system color [Colors.yellowAccent[200]]
  T get yellowAccent200 => this..color(Colors.yellowAccent[200]);

  ///flutter system color [Colors.yellowAccent[400]]
  T get yellowAccent400 => this..color(Colors.yellowAccent[400]);

  ///flutter system color [Colors.yellowAccent[700]]
  T get yellowAccent700 => this..color(Colors.yellowAccent[700]);

  ///flutter system color [Colors.amber]
  T get amber => this..color(Colors.amber);

  ///flutter system color [Colors.amber[50]]
  T get amber50 => this..color(Colors.amber[50]);

  ///flutter system color [Colors.amber[100]]
  T get amber100 => this..color(Colors.amber[100]);

  ///flutter system color [Colors.amber[200]]
  T get amber200 => this..color(Colors.amber[200]);

  ///flutter system color [Colors.amber[300]]
  T get amber300 => this..color(Colors.amber[300]);

  ///flutter system color [Colors.amber[400]]
  T get amber400 => this..color(Colors.amber[400]);

  ///flutter system color [Colors.amber[500]]
  T get amber500 => this..color(Colors.amber[500]);

  ///flutter system color [Colors.amber[600]]
  T get amber600 => this..color(Colors.amber[600]);

  ///flutter system color [Colors.amber[700]]
  T get amber700 => this..color(Colors.amber[700]);

  ///flutter system color [Colors.amber[800]]
  T get amber800 => this..color(Colors.amber[800]);

  ///flutter system color [Colors.amber[900]]
  T get amber900 => this..color(Colors.amber[900]);

  ///flutter system color [Colors.amberAccent]
  T get amberAccent => this..color(Colors.amberAccent);

  ///flutter system color [Colors.amberAccent[100]]
  T get amberAccent100 => this..color(Colors.amberAccent[100]);

  ///flutter system color [Colors.amberAccent[200]]
  T get amberAccent200 => this..color(Colors.amberAccent[200]);

  ///flutter system color [Colors.amberAccent[400]]
  T get amberAccent400 => this..color(Colors.amberAccent[400]);

  ///flutter system color [Colors.amberAccent[700]]
  T get amberAccent700 => this..color(Colors.amberAccent[700]);

  ///flutter system color [Colors.purple]
  T get purple => this..color(Colors.purple);

  ///flutter system color [Colors.purple[50]]
  T get purple50 => this..color(Colors.purple[50]);

  ///flutter system color [Colors.purple[100]]
  T get purple100 => this..color(Colors.purple[100]);

  ///flutter system color [Colors.purple[200]]
  T get purple200 => this..color(Colors.purple[200]);

  ///flutter system color [Colors.purple[300]]
  T get purple300 => this..color(Colors.purple[300]);

  ///flutter system color [Colors.purple[400]]
  T get purple400 => this..color(Colors.purple[400]);

  ///flutter system color [Colors.purple[500]]
  T get purple500 => this..color(Colors.purple[500]);

  ///flutter system color [Colors.purple[600]]
  T get purple600 => this..color(Colors.purple[600]);

  ///flutter system color [Colors.purple[700]]
  T get purple700 => this..color(Colors.purple[700]);

  ///flutter system color [Colors.purple[800]]
  T get purple800 => this..color(Colors.purple[800]);

  ///flutter system color [Colors.purple[900]]
  T get purple900 => this..color(Colors.purple[900]);

  ///flutter system color [Colors.purpleAccent]
  T get purpleAccent => this..color(Colors.purpleAccent);

  ///flutter system color [Colors.purpleAccent[100]]
  T get purpleAccent100 => this..color(Colors.purpleAccent[100]);

  ///flutter system color [Colors.purpleAccent[200]]
  T get purpleAccent200 => this..color(Colors.purpleAccent[200]);

  ///flutter system color [Colors.purpleAccent[400]]
  T get purpleAccent400 => this..color(Colors.purpleAccent[400]);

  ///flutter system color [Colors.purpleAccent[700]]
  T get purpleAccent700 => this..color(Colors.purpleAccent[700]);

  ///flutter system color [Colors.orange]
  T get orange => this..color(Colors.orange);

  ///flutter system color [Colors.orange[50]]
  T get orange50 => this..color(Colors.orange[50]);

  ///flutter system color [Colors.orange[100]]
  T get orange100 => this..color(Colors.orange[100]);

  ///flutter system color [Colors.orange[200]]
  T get orange200 => this..color(Colors.orange[200]);

  ///flutter system color [Colors.orange[300]]
  T get orange300 => this..color(Colors.orange[300]);

  ///flutter system color [Colors.orange[400]]
  T get orange400 => this..color(Colors.orange[400]);

  ///flutter system color [Colors.orange[500]]
  T get orange500 => this..color(Colors.orange[500]);

  ///flutter system color [Colors.orange[600]]
  T get orange600 => this..color(Colors.orange[600]);

  ///flutter system color [Colors.orange[700]]
  T get orange700 => this..color(Colors.orange[700]);

  ///flutter system color [Colors.orange[800]]
  T get orange800 => this..color(Colors.orange[800]);

  ///flutter system color [Colors.orange[900]]
  T get orange900 => this..color(Colors.orange[900]);

  ///flutter system color [Colors.orangeAccent]
  T get orangeAccent => this..color(Colors.orangeAccent);

  ///flutter system color [Colors.orangeAccent[100]]
  T get orangeAccent100 => this..color(Colors.orangeAccent[100]);

  ///flutter system color [Colors.orangeAccent[200]]
  T get orangeAccent200 => this..color(Colors.orangeAccent[200]);

  ///flutter system color [Colors.orangeAccent[400]]
  T get orangeAccent400 => this..color(Colors.orangeAccent[400]);

  ///flutter system color [Colors.orangeAccent[700]]
  T get orangeAccent700 => this..color(Colors.orangeAccent[700]);

  ///flutter system color [Colors.brown]
  T get brown => this..color(Colors.brown);

  ///flutter system color [Colors.brown[50]]
  T get brown50 => this..color(Colors.brown[50]);

  ///flutter system color [Colors.brown[100]]
  T get brown100 => this..color(Colors.brown[100]);

  ///flutter system color [Colors.brown[200]]
  T get brown200 => this..color(Colors.brown[200]);

  ///flutter system color [Colors.brown[300]]
  T get brown300 => this..color(Colors.brown[300]);

  ///flutter system color [Colors.brown[400]]
  T get brown400 => this..color(Colors.brown[400]);

  ///flutter system color [Colors.brown[500]]
  T get brown500 => this..color(Colors.brown[500]);

  ///flutter system color [Colors.brown[600]]
  T get brown600 => this..color(Colors.brown[600]);

  ///flutter system color [Colors.brown[700]]
  T get brown700 => this..color(Colors.brown[700]);

  ///flutter system color [Colors.brown[800]]
  T get brown800 => this..color(Colors.brown[800]);

  ///flutter system color [Colors.brown[900]]
  T get brown900 => this..color(Colors.brown[900]);

  ///flutter system color [Colors.pink]
  T get pink => this..color(Colors.pink);

  ///flutter system color [Colors.pink[50]]
  T get pink50 => this..color(Colors.pink[50]);

  ///flutter system color [Colors.pink[100]]
  T get pink100 => this..color(Colors.pink[100]);

  ///flutter system color [Colors.pink[200]]
  T get pink200 => this..color(Colors.pink[200]);

  ///flutter system color [Colors.pink[300]]
  T get pink300 => this..color(Colors.pink[300]);

  ///flutter system color [Colors.pink[400]]
  T get pink400 => this..color(Colors.pink[400]);

  ///flutter system color [Colors.pink[500]]
  T get pink500 => this..color(Colors.pink[500]);

  ///flutter system color [Colors.pink[600]]
  T get pink600 => this..color(Colors.pink[600]);

  ///flutter system color [Colors.pink[700]]
  T get pink700 => this..color(Colors.pink[700]);

  ///flutter system color [Colors.pink[800]]
  T get pink800 => this..color(Colors.pink[800]);

  ///flutter system color [Colors.pink[900]]
  T get pink900 => this..color(Colors.pink[900]);

  ///flutter system color [Colors.grey]
  T get grey => this..color(Colors.grey);

  ///flutter system color [Colors.grey[50]]
  T get grey50 => this..color(Colors.grey[50]);

  ///flutter system color [Colors.grey[100]]
  T get grey100 => this..color(Colors.grey[100]);

  ///flutter system color [Colors.grey[200]]
  T get grey200 => this..color(Colors.grey[200]);

  ///flutter system color [Colors.grey[300]]
  T get grey300 => this..color(Colors.grey[300]);

  ///flutter system color [Colors.grey[400]]
  T get grey400 => this..color(Colors.grey[400]);

  ///flutter system color [Colors.grey[500]]
  T get grey500 => this..color(Colors.grey[500]);

  ///flutter system color [Colors.grey[600]]
  T get grey600 => this..color(Colors.grey[600]);

  ///flutter system color [Colors.grey[700]]
  T get grey700 => this..color(Colors.grey[700]);

  ///flutter system color [Colors.grey[800]]
  T get grey800 => this..color(Colors.grey[800]);

  ///flutter system color [Colors.grey[900]]
  T get grey900 => this..color(Colors.grey[900]);

  ///flutter system color [Colors.cyan]
  T get cyan => this..color(Colors.cyan);

  ///flutter system color [Colors.cyan[50]]
  T get cyan50 => this..color(Colors.cyan[50]);

  ///flutter system color [Colors.cyan[100]]
  T get cyan100 => this..color(Colors.cyan[100]);

  ///flutter system color [Colors.cyan[200]]
  T get cyan200 => this..color(Colors.cyan[200]);

  ///flutter system color [Colors.cyan[300]]
  T get cyan300 => this..color(Colors.cyan[300]);

  ///flutter system color [Colors.cyan[400]]
  T get cyan400 => this..color(Colors.cyan[400]);

  ///flutter system color [Colors.cyan[500]]
  T get cyan500 => this..color(Colors.cyan[500]);

  ///flutter system color [Colors.cyan[600]]
  T get cyan600 => this..color(Colors.cyan[600]);

  ///flutter system color [Colors.cyan[700]]
  T get cyan700 => this..color(Colors.cyan[700]);

  ///flutter system color [Colors.cyan[800]]
  T get cyan800 => this..color(Colors.cyan[800]);

  ///flutter system color [Colors.cyan[900]]
  T get cyan900 => this..color(Colors.cyan[900]);

  ///flutter system color [Colors.deepOrange]
  T get deepOrange => this..color(Colors.deepOrange);

  ///flutter system color [Colors.deepOrange[50]]
  T get deepOrange50 => this..color(Colors.deepOrange[50]);

  ///flutter system color [Colors.deepOrange[100]]
  T get deepOrange100 => this..color(Colors.deepOrange[100]);

  ///flutter system color [Colors.deepOrange[200]]
  T get deepOrange200 => this..color(Colors.deepOrange[200]);

  ///flutter system color [Colors.deepOrange[300]]
  T get deepOrange300 => this..color(Colors.deepOrange[300]);

  ///flutter system color [Colors.deepOrange[400]]
  T get deepOrange400 => this..color(Colors.deepOrange[400]);

  ///flutter system color [Colors.deepOrange[500]]
  T get deepOrange500 => this..color(Colors.deepOrange[500]);

  ///flutter system color [Colors.deepOrange[600]]
  T get deepOrange600 => this..color(Colors.deepOrange[600]);

  ///flutter system color [Colors.deepOrange[700]]
  T get deepOrange700 => this..color(Colors.deepOrange[700]);

  ///flutter system color [Colors.deepOrange[800]]
  T get deepOrange800 => this..color(Colors.deepOrange[800]);

  ///flutter system color [Colors.deepOrange[900]]
  T get deepOrange900 => this..color(Colors.deepOrange[900]);

  ///flutter system color [Colors.teal]
  T get teal => this..color(Colors.teal);

  ///flutter system color [Colors.teal[50]]
  T get teal50 => this..color(Colors.teal[50]);

  ///flutter system color [Colors.teal[100]]
  T get teal100 => this..color(Colors.teal[100]);

  ///flutter system color [Colors.teal[200]]
  T get teal200 => this..color(Colors.teal[200]);

  ///flutter system color [Colors.teal[300]]
  T get teal300 => this..color(Colors.teal[300]);

  ///flutter system color [Colors.teal[400]]
  T get teal400 => this..color(Colors.teal[400]);

  ///flutter system color [Colors.teal[500]]
  T get teal500 => this..color(Colors.teal[500]);

  ///flutter system color [Colors.teal[600]]
  T get teal600 => this..color(Colors.teal[600]);

  ///flutter system color [Colors.teal[700]]
  T get teal700 => this..color(Colors.teal[700]);

  ///flutter system color [Colors.teal[800]]
  T get teal800 => this..color(Colors.teal[800]);

  ///flutter system color [Colors.teal[900]]
  T get teal900 => this..color(Colors.teal[900]);

  ///flutter system color [Colors.tealAccent]
  T get tealAccent => this..color(Colors.tealAccent);

  ///flutter system color [Colors.tealAccent[100]]
  T get tealAccent100 => this..color(Colors.tealAccent[100]);

  ///flutter system color [Colors.tealAccent[200]]
  T get tealAccent200 => this..color(Colors.tealAccent[200]);

  ///flutter system color [Colors.tealAccent[400]]
  T get tealAccent400 => this..color(Colors.tealAccent[400]);

  ///flutter system color [Colors.tealAccent[700]]
  T get tealAccent700 => this..color(Colors.tealAccent[700]);

  ///flutter system color [Colors.deepPurple]
  T get deepPurple => this..color(Colors.deepPurple);

  ///flutter system color [Colors.deepPurple[50]]
  T get deepPurple50 => this..color(Colors.deepPurple[50]);

  ///flutter system color [Colors.deepPurple[100]]
  T get deepPurple100 => this..color(Colors.deepPurple[100]);

  ///flutter system color [Colors.deepPurple[200]]
  T get deepPurple200 => this..color(Colors.deepPurple[200]);

  ///flutter system color [Colors.deepPurple[300]]
  T get deepPurple300 => this..color(Colors.deepPurple[300]);

  ///flutter system color [Colors.deepPurple[400]]
  T get deepPurple400 => this..color(Colors.deepPurple[400]);

  ///flutter system color [Colors.deepPurple[500]]
  T get deepPurple500 => this..color(Colors.deepPurple[500]);

  ///flutter system color [Colors.deepPurple[600]]
  T get deepPurple600 => this..color(Colors.deepPurple[600]);

  ///flutter system color [Colors.deepPurple[700]]
  T get deepPurple700 => this..color(Colors.deepPurple[700]);

  ///flutter system color [Colors.deepPurple[800]]
  T get deepPurple800 => this..color(Colors.deepPurple[800]);

  ///flutter system color [Colors.deepPurple[900]]
  T get deepPurple900 => this..color(Colors.deepPurple[900]);

  ///flutter system color [Colors.indigo]
  T get indigo => this..color(Colors.indigo);

  ///flutter system color [Colors.indigo[50]]
  T get indigo50 => this..color(Colors.indigo[50]);

  ///flutter system color [Colors.indigo[100]]
  T get indigo100 => this..color(Colors.indigo[100]);

  ///flutter system color [Colors.indigo[200]]
  T get indigo200 => this..color(Colors.indigo[200]);

  ///flutter system color [Colors.indigo[300]]
  T get indigo300 => this..color(Colors.indigo[300]);

  ///flutter system color [Colors.indigo[400]]
  T get indigo400 => this..color(Colors.indigo[400]);

  ///flutter system color [Colors.indigo[500]]
  T get indigo500 => this..color(Colors.indigo[500]);

  ///flutter system color [Colors.indigo[600]]
  T get indigo600 => this..color(Colors.indigo[600]);

  ///flutter system color [Colors.indigo[700]]
  T get indigo700 => this..color(Colors.indigo[700]);

  ///flutter system color [Colors.indigo[800]]
  T get indigo800 => this..color(Colors.indigo[800]);

  ///flutter system color [Colors.indigo[900]]
  T get indigo900 => this..color(Colors.indigo[900]);
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

  ///set the border color [Colors.red[50]]
  T get borderRed50 => this..border(Colors.red[50]);

  ///set the border color [Colors.red[100]]
  T get borderRed100 => this..border(Colors.red[100]);

  ///set the border color [Colors.red[200]]
  T get borderRed200 => this..border(Colors.red[200]);

  ///set the border color [Colors.red[300]]
  T get borderRed300 => this..border(Colors.red[300]);

  ///set the border color [Colors.red[400]]
  T get borderRed400 => this..border(Colors.red[400]);

  ///set the border color [Colors.red[500]]
  T get borderRed500 => this..border(Colors.red[500]);

  ///set the border color [Colors.red[600]]
  T get borderRed600 => this..border(Colors.red[600]);

  ///set the border color [Colors.red[700]]
  T get borderRed700 => this..border(Colors.red[700]);

  ///set the border color [Colors.red[800]]
  T get borderRed800 => this..border(Colors.red[800]);

  ///set the border color [Colors.red[900]]
  T get borderRed900 => this..border(Colors.red[900]);

  ///set the border color [Colors.redAccent]
  T get borderRedAccent => this..border(Colors.redAccent);

  ///set the border color [Colors.redAccent[100]]
  T get borderRedAccent100 => this..border(Colors.redAccent[100]);

  ///set the border color [Colors.redAccent[200]]
  T get borderRedAccent200 => this..border(Colors.redAccent[200]);

  ///set the border color [Colors.redAccent[400]]
  T get borderRedAccent400 => this..border(Colors.redAccent[400]);

  ///set the border color [Colors.redAccent[700]]
  T get borderRedAccent700 => this..border(Colors.redAccent[700]);

  ///set the border color [Colors.green]
  T get borderGreen => this..border(Colors.green);

  ///set the border color [Colors.green[50]]
  T get borderGreen50 => this..border(Colors.green[50]);

  ///set the border color [Colors.green[100]]
  T get borderGreen100 => this..border(Colors.green[100]);

  ///set the border color [Colors.green[200]]
  T get borderGreen200 => this..border(Colors.green[200]);

  ///set the border color [Colors.green[300]]
  T get borderGreen300 => this..border(Colors.green[300]);

  ///set the border color [Colors.green[400]]
  T get borderGreen400 => this..border(Colors.green[400]);

  ///set the border color [Colors.green[500]]
  T get borderGreen500 => this..border(Colors.green[500]);

  ///set the border color [Colors.green[600]]
  T get borderGreen600 => this..border(Colors.green[600]);

  ///set the border color [Colors.green[700]]
  T get borderGreen700 => this..border(Colors.green[700]);

  ///set the border color [Colors.green[800]]
  T get borderGreen800 => this..border(Colors.green[800]);

  ///set the border color [Colors.green[900]]
  T get borderGreen900 => this..border(Colors.green[900]);

  ///set the border color [Colors.greenAccent]
  T get borderGreenAccent => this..border(Colors.greenAccent);

  ///set the border color [Colors.greenAccent[100]]
  T get borderGreenAccent100 => this..border(Colors.greenAccent[100]);

  ///set the border color [Colors.greenAccent[200]]
  T get borderGreenAccent200 => this..border(Colors.greenAccent[200]);

  ///set the border color [Colors.greenAccent[400]]
  T get borderGreenAccent400 => this..border(Colors.greenAccent[400]);

  ///set the border color [Colors.greenAccent[700]]
  T get borderGreenAccent700 => this..border(Colors.greenAccent[700]);

  ///set the border color [Colors.lightGreen]
  T get borderLightGreen => this..border(Colors.lightGreen);

  ///set the border color [Colors.lightGreen[50]]
  T get borderLightGreen50 => this..border(Colors.lightGreen[50]);

  ///set the border color [Colors.lightGreen[100]]
  T get borderLightGreen100 => this..border(Colors.lightGreen[100]);

  ///set the border color [Colors.lightGreen[200]]
  T get borderLightGreen200 => this..border(Colors.lightGreen[200]);

  ///set the border color [Colors.lightGreen[300]]
  T get borderLightGreen300 => this..border(Colors.lightGreen[300]);

  ///set the border color [Colors.lightGreen[400]]
  T get borderLightGreen400 => this..border(Colors.lightGreen[400]);

  ///set the border color [Colors.lightGreen[500]]
  T get borderLightGreen500 => this..border(Colors.lightGreen[500]);

  ///set the border color [Colors.lightGreen[600]]
  T get borderLightGreen600 => this..border(Colors.lightGreen[600]);

  ///set the border color [Colors.lightGreen[700]]
  T get borderLightGreen700 => this..border(Colors.lightGreen[700]);

  ///set the border color [Colors.lightGreen[800]]
  T get borderLightGreen800 => this..border(Colors.lightGreen[800]);

  ///set the border color [Colors.lightGreen[900]]
  T get borderLightGreen900 => this..border(Colors.lightGreen[900]);

  ///set the border color [Colors.lime]
  T get borderLime => this..border(Colors.lime);

  ///set the border color [Colors.lime[50]]
  T get borderLime50 => this..border(Colors.lime[50]);

  ///set the border color [Colors.lime[100]]
  T get borderLime100 => this..border(Colors.lime[100]);

  ///set the border color [Colors.lime[200]]
  T get borderLime200 => this..border(Colors.lime[200]);

  ///set the border color [Colors.lime[300]]
  T get borderLime300 => this..border(Colors.lime[300]);

  ///set the border color [Colors.lime[400]]
  T get borderLime400 => this..border(Colors.lime[400]);

  ///set the border color [Colors.lime[500]]
  T get borderLime500 => this..border(Colors.lime[500]);

  ///set the border color [Colors.lime[600]]
  T get borderLime600 => this..border(Colors.lime[600]);

  ///set the border color [Colors.lime[700]]
  T get borderLime700 => this..border(Colors.lime[700]);

  ///set the border color [Colors.lime[800]]
  T get borderLime800 => this..border(Colors.lime[800]);

  ///set the border color [Colors.lime[900]]
  T get borderLime900 => this..border(Colors.lime[900]);

  ///set the border color [Colors.blue]
  T get borderBlue => this..border(Colors.blue);

  ///set the border color [Colors.blue[50]]
  T get borderBlue50 => this..border(Colors.blue[50]);

  ///set the border color [Colors.blue[100]]
  T get borderBlue100 => this..border(Colors.blue[100]);

  ///set the border color [Colors.blue[200]]
  T get borderBlue200 => this..border(Colors.blue[200]);

  ///set the border color [Colors.blue[300]]
  T get borderBlue300 => this..border(Colors.blue[300]);

  ///set the border color [Colors.blue[400]]
  T get borderBlue400 => this..border(Colors.blue[400]);

  ///set the border color [Colors.blue[500]]
  T get borderBlue500 => this..border(Colors.blue[500]);

  ///set the border color [Colors.blue[600]]
  T get borderBlue600 => this..border(Colors.blue[600]);

  ///set the border color [Colors.blue[700]]
  T get borderBlue700 => this..border(Colors.blue[700]);

  ///set the border color [Colors.blue[800]]
  T get borderBlue800 => this..border(Colors.blue[800]);

  ///set the border color [Colors.blue[900]]
  T get borderBlue900 => this..border(Colors.blue[900]);

  ///set the border color [Colors.blueAccent]
  T get borderBlueAccent => this..border(Colors.blueAccent);

  ///set the border color [Colors.blueAccent[100]]
  T get borderBlueAccent100 => this..border(Colors.blueAccent[100]);

  ///set the border color [Colors.blueAccent[200]]
  T get borderBlueAccent200 => this..border(Colors.blueAccent[200]);

  ///set the border color [Colors.blueAccent[400]]
  T get borderBlueAccent400 => this..border(Colors.blueAccent[400]);

  ///set the border color [Colors.blueAccent[700]]
  T get borderBlueAccent700 => this..border(Colors.blueAccent[700]);

  ///set the border color [Colors.lightBlue]
  T get borderLightBlue => this..border(Colors.lightBlue);

  ///set the border color [Colors.lightBlue[50]]
  T get borderLightBlue50 => this..border(Colors.lightBlue[50]);

  ///set the border color [Colors.lightBlue[100]]
  T get borderLightBlue100 => this..border(Colors.lightBlue[100]);

  ///set the border color [Colors.lightBlue[200]]
  T get borderLightBlue200 => this..border(Colors.lightBlue[200]);

  ///set the border color [Colors.lightBlue[300]]
  T get borderLightBlue300 => this..border(Colors.lightBlue[300]);

  ///set the border color [Colors.lightBlue[400]]
  T get borderLightBlue400 => this..border(Colors.lightBlue[400]);

  ///set the border color [Colors.lightBlue[500]]
  T get borderLightBlue500 => this..border(Colors.lightBlue[500]);

  ///set the border color [Colors.lightBlue[600]]
  T get borderLightBlue600 => this..border(Colors.lightBlue[600]);

  ///set the border color [Colors.lightBlue[700]]
  T get borderLightBlue700 => this..border(Colors.lightBlue[700]);

  ///set the border color [Colors.lightBlue[800]]
  T get borderLightBlue800 => this..border(Colors.lightBlue[800]);

  ///set the border color [Colors.lightBlue[900]]
  T get borderLightBlue900 => this..border(Colors.lightBlue[900]);

  ///set the border color [Colors.blueGrey]
  T get borderBlueGrey => this..border(Colors.blueGrey);

  ///set the border color [Colors.blueGrey[50]]
  T get borderBlueGrey50 => this..border(Colors.blueGrey[50]);

  ///set the border color [Colors.blueGrey[100]]
  T get borderBlueGrey100 => this..border(Colors.blueGrey[100]);

  ///set the border color [Colors.blueGrey[200]]
  T get borderBlueGrey200 => this..border(Colors.blueGrey[200]);

  ///set the border color [Colors.blueGrey[300]]
  T get borderBlueGrey300 => this..border(Colors.blueGrey[300]);

  ///set the border color [Colors.blueGrey[400]]
  T get borderBlueGrey400 => this..border(Colors.blueGrey[400]);

  ///set the border color [Colors.blueGrey[500]]
  T get borderBlueGrey500 => this..border(Colors.blueGrey[500]);

  ///set the border color [Colors.blueGrey[600]]
  T get borderBlueGrey600 => this..border(Colors.blueGrey[600]);

  ///set the border color [Colors.blueGrey[700]]
  T get borderBlueGrey700 => this..border(Colors.blueGrey[700]);

  ///set the border color [Colors.blueGrey[800]]
  T get borderBlueGrey800 => this..border(Colors.blueGrey[800]);

  ///set the border color [Colors.blueGrey[900]]
  T get borderBlueGrey900 => this..border(Colors.blueGrey[900]);

  ///set the border color [Colors.indigoAccent]
  T get borderIndigoAccent => this..border(Colors.indigoAccent);

  ///set the border color [Colors.indigoAccent[100]]
  T get borderIndigoAccent100 => this..border(Colors.indigoAccent[100]);

  ///set the border color [Colors.indigoAccent[200]]
  T get borderIndigoAccent200 => this..border(Colors.indigoAccent[200]);

  ///set the border color [Colors.indigoAccent[400]]
  T get borderIndigoAccent400 => this..border(Colors.indigoAccent[400]);

  ///set the border color [Colors.indigoAccent[700]]
  T get borderIndigoAccent700 => this..border(Colors.indigoAccent[700]);

  ///set the border color [Colors.yellow]
  T get borderYellow => this..border(Colors.yellow);

  ///set the border color [Colors.yellow[50]]
  T get borderYellow50 => this..border(Colors.yellow[50]);

  ///set the border color [Colors.yellow[100]]
  T get borderYellow100 => this..border(Colors.yellow[100]);

  ///set the border color [Colors.yellow[200]]
  T get borderYellow200 => this..border(Colors.yellow[200]);

  ///set the border color [Colors.yellow[300]]
  T get borderYellow300 => this..border(Colors.yellow[300]);

  ///set the border color [Colors.yellow[400]]
  T get borderYellow400 => this..border(Colors.yellow[400]);

  ///set the border color [Colors.yellow[500]]
  T get borderYellow500 => this..border(Colors.yellow[500]);

  ///set the border color [Colors.yellow[600]]
  T get borderYellow600 => this..border(Colors.yellow[600]);

  ///set the border color [Colors.yellow[700]]
  T get borderYellow700 => this..border(Colors.yellow[700]);

  ///set the border color [Colors.yellow[800]]
  T get borderYellow800 => this..border(Colors.yellow[800]);

  ///set the border color [Colors.yellow[900]]
  T get borderYellow900 => this..border(Colors.yellow[900]);

  ///set the border color [Colors.yellowAccent]
  T get borderYellowAccent => this..border(Colors.yellowAccent);

  ///set the border color [Colors.yellowAccent[100]]
  T get borderYellowAccent100 => this..border(Colors.yellowAccent[100]);

  ///set the border color [Colors.yellowAccent[200]]
  T get borderYellowAccent200 => this..border(Colors.yellowAccent[200]);

  ///set the border color [Colors.yellowAccent[400]]
  T get borderYellowAccent400 => this..border(Colors.yellowAccent[400]);

  ///set the border color [Colors.yellowAccent[700]]
  T get borderYellowAccent700 => this..border(Colors.yellowAccent[700]);

  ///set the border color [Colors.amber]
  T get borderAmber => this..border(Colors.amber);

  ///set the border color [Colors.amber[50]]
  T get borderAmber50 => this..border(Colors.amber[50]);

  ///set the border color [Colors.amber[100]]
  T get borderAmber100 => this..border(Colors.amber[100]);

  ///set the border color [Colors.amber[200]]
  T get borderAmber200 => this..border(Colors.amber[200]);

  ///set the border color [Colors.amber[300]]
  T get borderAmber300 => this..border(Colors.amber[300]);

  ///set the border color [Colors.amber[400]]
  T get borderAmber400 => this..border(Colors.amber[400]);

  ///set the border color [Colors.amber[500]]
  T get borderAmber500 => this..border(Colors.amber[500]);

  ///set the border color [Colors.amber[600]]
  T get borderAmber600 => this..border(Colors.amber[600]);

  ///set the border color [Colors.amber[700]]
  T get borderAmber700 => this..border(Colors.amber[700]);

  ///set the border color [Colors.amber[800]]
  T get borderAmber800 => this..border(Colors.amber[800]);

  ///set the border color [Colors.amber[900]]
  T get borderAmber900 => this..border(Colors.amber[900]);

  ///set the border color [Colors.amberAccent]
  T get borderAmberAccent => this..border(Colors.amberAccent);

  ///set the border color [Colors.amberAccent[100]]
  T get borderAmberAccent100 => this..border(Colors.amberAccent[100]);

  ///set the border color [Colors.amberAccent[200]]
  T get borderAmberAccent200 => this..border(Colors.amberAccent[200]);

  ///set the border color [Colors.amberAccent[400]]
  T get borderAmberAccent400 => this..border(Colors.amberAccent[400]);

  ///set the border color [Colors.amberAccent[700]]
  T get borderAmberAccent700 => this..border(Colors.amberAccent[700]);

  ///set the border color [Colors.purple]
  T get borderPurple => this..border(Colors.purple);

  ///set the border color [Colors.purple[50]]
  T get borderPurple50 => this..border(Colors.purple[50]);

  ///set the border color [Colors.purple[100]]
  T get borderPurple100 => this..border(Colors.purple[100]);

  ///set the border color [Colors.purple[200]]
  T get borderPurple200 => this..border(Colors.purple[200]);

  ///set the border color [Colors.purple[300]]
  T get borderPurple300 => this..border(Colors.purple[300]);

  ///set the border color [Colors.purple[400]]
  T get borderPurple400 => this..border(Colors.purple[400]);

  ///set the border color [Colors.purple[500]]
  T get borderPurple500 => this..border(Colors.purple[500]);

  ///set the border color [Colors.purple[600]]
  T get borderPurple600 => this..border(Colors.purple[600]);

  ///set the border color [Colors.purple[700]]
  T get borderPurple700 => this..border(Colors.purple[700]);

  ///set the border color [Colors.purple[800]]
  T get borderPurple800 => this..border(Colors.purple[800]);

  ///set the border color [Colors.purple[900]]
  T get borderPurple900 => this..border(Colors.purple[900]);

  ///set the border color [Colors.purpleAccent]
  T get borderPurpleAccent => this..border(Colors.purpleAccent);

  ///set the border color [Colors.purpleAccent[100]]
  T get borderPurpleAccent100 => this..border(Colors.purpleAccent[100]);

  ///set the border color [Colors.purpleAccent[200]]
  T get borderPurpleAccent200 => this..border(Colors.purpleAccent[200]);

  ///set the border color [Colors.purpleAccent[400]]
  T get borderPurpleAccent400 => this..border(Colors.purpleAccent[400]);

  ///set the border color [Colors.purpleAccent[700]]
  T get borderPurpleAccent700 => this..border(Colors.purpleAccent[700]);

  ///set the border color [Colors.orange]
  T get borderOrange => this..border(Colors.orange);

  ///set the border color [Colors.orange[50]]
  T get borderOrange50 => this..border(Colors.orange[50]);

  ///set the border color [Colors.orange[100]]
  T get borderOrange100 => this..border(Colors.orange[100]);

  ///set the border color [Colors.orange[200]]
  T get borderOrange200 => this..border(Colors.orange[200]);

  ///set the border color [Colors.orange[300]]
  T get borderOrange300 => this..border(Colors.orange[300]);

  ///set the border color [Colors.orange[400]]
  T get borderOrange400 => this..border(Colors.orange[400]);

  ///set the border color [Colors.orange[500]]
  T get borderOrange500 => this..border(Colors.orange[500]);

  ///set the border color [Colors.orange[600]]
  T get borderOrange600 => this..border(Colors.orange[600]);

  ///set the border color [Colors.orange[700]]
  T get borderOrange700 => this..border(Colors.orange[700]);

  ///set the border color [Colors.orange[800]]
  T get borderOrange800 => this..border(Colors.orange[800]);

  ///set the border color [Colors.orange[900]]
  T get borderOrange900 => this..border(Colors.orange[900]);

  ///set the border color [Colors.orangeAccent]
  T get borderOrangeAccent => this..border(Colors.orangeAccent);

  ///set the border color [Colors.orangeAccent[100]]
  T get borderOrangeAccent100 => this..border(Colors.orangeAccent[100]);

  ///set the border color [Colors.orangeAccent[200]]
  T get borderOrangeAccent200 => this..border(Colors.orangeAccent[200]);

  ///set the border color [Colors.orangeAccent[400]]
  T get borderOrangeAccent400 => this..border(Colors.orangeAccent[400]);

  ///set the border color [Colors.orangeAccent[700]]
  T get borderOrangeAccent700 => this..border(Colors.orangeAccent[700]);

  ///set the border color [Colors.brown]
  T get borderBrown => this..border(Colors.brown);

  ///set the border color [Colors.brown[50]]
  T get borderBrown50 => this..border(Colors.brown[50]);

  ///set the border color [Colors.brown[100]]
  T get borderBrown100 => this..border(Colors.brown[100]);

  ///set the border color [Colors.brown[200]]
  T get borderBrown200 => this..border(Colors.brown[200]);

  ///set the border color [Colors.brown[300]]
  T get borderBrown300 => this..border(Colors.brown[300]);

  ///set the border color [Colors.brown[400]]
  T get borderBrown400 => this..border(Colors.brown[400]);

  ///set the border color [Colors.brown[500]]
  T get borderBrown500 => this..border(Colors.brown[500]);

  ///set the border color [Colors.brown[600]]
  T get borderBrown600 => this..border(Colors.brown[600]);

  ///set the border color [Colors.brown[700]]
  T get borderBrown700 => this..border(Colors.brown[700]);

  ///set the border color [Colors.brown[800]]
  T get borderBrown800 => this..border(Colors.brown[800]);

  ///set the border color [Colors.brown[900]]
  T get borderBrown900 => this..border(Colors.brown[900]);

  ///set the border color [Colors.pink]
  T get borderPink => this..border(Colors.pink);

  ///set the border color [Colors.pink[50]]
  T get borderPink50 => this..border(Colors.pink[50]);

  ///set the border color [Colors.pink[100]]
  T get borderPink100 => this..border(Colors.pink[100]);

  ///set the border color [Colors.pink[200]]
  T get borderPink200 => this..border(Colors.pink[200]);

  ///set the border color [Colors.pink[300]]
  T get borderPink300 => this..border(Colors.pink[300]);

  ///set the border color [Colors.pink[400]]
  T get borderPink400 => this..border(Colors.pink[400]);

  ///set the border color [Colors.pink[500]]
  T get borderPink500 => this..border(Colors.pink[500]);

  ///set the border color [Colors.pink[600]]
  T get borderPink600 => this..border(Colors.pink[600]);

  ///set the border color [Colors.pink[700]]
  T get borderPink700 => this..border(Colors.pink[700]);

  ///set the border color [Colors.pink[800]]
  T get borderPink800 => this..border(Colors.pink[800]);

  ///set the border color [Colors.pink[900]]
  T get borderPink900 => this..border(Colors.pink[900]);

  ///set the border color [Colors.grey]
  T get borderGrey => this..border(Colors.grey);

  ///set the border color [Colors.grey[50]]
  T get borderGrey50 => this..border(Colors.grey[50]);

  ///set the border color [Colors.grey[100]]
  T get borderGrey100 => this..border(Colors.grey[100]);

  ///set the border color [Colors.grey[200]]
  T get borderGrey200 => this..border(Colors.grey[200]);

  ///set the border color [Colors.grey[300]]
  T get borderGrey300 => this..border(Colors.grey[300]);

  ///set the border color [Colors.grey[400]]
  T get borderGrey400 => this..border(Colors.grey[400]);

  ///set the border color [Colors.grey[500]]
  T get borderGrey500 => this..border(Colors.grey[500]);

  ///set the border color [Colors.grey[600]]
  T get borderGrey600 => this..border(Colors.grey[600]);

  ///set the border color [Colors.grey[700]]
  T get borderGrey700 => this..border(Colors.grey[700]);

  ///set the border color [Colors.grey[800]]
  T get borderGrey800 => this..border(Colors.grey[800]);

  ///set the border color [Colors.grey[900]]
  T get borderGrey900 => this..border(Colors.grey[900]);

  ///set the border color [Colors.cyan]
  T get borderCyan => this..border(Colors.cyan);

  ///set the border color [Colors.cyan[50]]
  T get borderCyan50 => this..border(Colors.cyan[50]);

  ///set the border color [Colors.cyan[100]]
  T get borderCyan100 => this..border(Colors.cyan[100]);

  ///set the border color [Colors.cyan[200]]
  T get borderCyan200 => this..border(Colors.cyan[200]);

  ///set the border color [Colors.cyan[300]]
  T get borderCyan300 => this..border(Colors.cyan[300]);

  ///set the border color [Colors.cyan[400]]
  T get borderCyan400 => this..border(Colors.cyan[400]);

  ///set the border color [Colors.cyan[500]]
  T get borderCyan500 => this..border(Colors.cyan[500]);

  ///set the border color [Colors.cyan[600]]
  T get borderCyan600 => this..border(Colors.cyan[600]);

  ///set the border color [Colors.cyan[700]]
  T get borderCyan700 => this..border(Colors.cyan[700]);

  ///set the border color [Colors.cyan[800]]
  T get borderCyan800 => this..border(Colors.cyan[800]);

  ///set the border color [Colors.cyan[900]]
  T get borderCyan900 => this..border(Colors.cyan[900]);

  ///set the border color [Colors.deepOrange]
  T get borderDeepOrange => this..border(Colors.deepOrange);

  ///set the border color [Colors.deepOrange[50]]
  T get borderDeepOrange50 => this..border(Colors.deepOrange[50]);

  ///set the border color [Colors.deepOrange[100]]
  T get borderDeepOrange100 => this..border(Colors.deepOrange[100]);

  ///set the border color [Colors.deepOrange[200]]
  T get borderDeepOrange200 => this..border(Colors.deepOrange[200]);

  ///set the border color [Colors.deepOrange[300]]
  T get borderDeepOrange300 => this..border(Colors.deepOrange[300]);

  ///set the border color [Colors.deepOrange[400]]
  T get borderDeepOrange400 => this..border(Colors.deepOrange[400]);

  ///set the border color [Colors.deepOrange[500]]
  T get borderDeepOrange500 => this..border(Colors.deepOrange[500]);

  ///set the border color [Colors.deepOrange[600]]
  T get borderDeepOrange600 => this..border(Colors.deepOrange[600]);

  ///set the border color [Colors.deepOrange[700]]
  T get borderDeepOrange700 => this..border(Colors.deepOrange[700]);

  ///set the border color [Colors.deepOrange[800]]
  T get borderDeepOrange800 => this..border(Colors.deepOrange[800]);

  ///set the border color [Colors.deepOrange[900]]
  T get borderDeepOrange900 => this..border(Colors.deepOrange[900]);

  ///set the border color [Colors.teal]
  T get borderTeal => this..border(Colors.teal);

  ///set the border color [Colors.teal[50]]
  T get borderTeal50 => this..border(Colors.teal[50]);

  ///set the border color [Colors.teal[100]]
  T get borderTeal100 => this..border(Colors.teal[100]);

  ///set the border color [Colors.teal[200]]
  T get borderTeal200 => this..border(Colors.teal[200]);

  ///set the border color [Colors.teal[300]]
  T get borderTeal300 => this..border(Colors.teal[300]);

  ///set the border color [Colors.teal[400]]
  T get borderTeal400 => this..border(Colors.teal[400]);

  ///set the border color [Colors.teal[500]]
  T get borderTeal500 => this..border(Colors.teal[500]);

  ///set the border color [Colors.teal[600]]
  T get borderTeal600 => this..border(Colors.teal[600]);

  ///set the border color [Colors.teal[700]]
  T get borderTeal700 => this..border(Colors.teal[700]);

  ///set the border color [Colors.teal[800]]
  T get borderTeal800 => this..border(Colors.teal[800]);

  ///set the border color [Colors.teal[900]]
  T get borderTeal900 => this..border(Colors.teal[900]);

  ///set the border color [Colors.tealAccent]
  T get borderTealAccent => this..border(Colors.tealAccent);

  ///set the border color [Colors.tealAccent[100]]
  T get borderTealAccent100 => this..border(Colors.tealAccent[100]);

  ///set the border color [Colors.tealAccent[200]]
  T get borderTealAccent200 => this..border(Colors.tealAccent[200]);

  ///set the border color [Colors.tealAccent[400]]
  T get borderTealAccent400 => this..border(Colors.tealAccent[400]);

  ///set the border color [Colors.tealAccent[700]]
  T get borderTealAccent700 => this..border(Colors.tealAccent[700]);

  ///set the border color [Colors.deepPurple]
  T get borderDeepPurple => this..border(Colors.deepPurple);

  ///set the border color [Colors.deepPurple[50]]
  T get borderDeepPurple50 => this..border(Colors.deepPurple[50]);

  ///set the border color [Colors.deepPurple[100]]
  T get borderDeepPurple100 => this..border(Colors.deepPurple[100]);

  ///set the border color [Colors.deepPurple[200]]
  T get borderDeepPurple200 => this..border(Colors.deepPurple[200]);

  ///set the border color [Colors.deepPurple[300]]
  T get borderDeepPurple300 => this..border(Colors.deepPurple[300]);

  ///set the border color [Colors.deepPurple[400]]
  T get borderDeepPurple400 => this..border(Colors.deepPurple[400]);

  ///set the border color [Colors.deepPurple[500]]
  T get borderDeepPurple500 => this..border(Colors.deepPurple[500]);

  ///set the border color [Colors.deepPurple[600]]
  T get borderDeepPurple600 => this..border(Colors.deepPurple[600]);

  ///set the border color [Colors.deepPurple[700]]
  T get borderDeepPurple700 => this..border(Colors.deepPurple[700]);

  ///set the border color [Colors.deepPurple[800]]
  T get borderDeepPurple800 => this..border(Colors.deepPurple[800]);

  ///set the border color [Colors.deepPurple[900]]
  T get borderDeepPurple900 => this..border(Colors.deepPurple[900]);

  ///set the border color [Colors.indigo]
  T get borderIndigo => this..border(Colors.indigo);

  ///set the border color [Colors.indigo[50]]
  T get borderIndigo50 => this..border(Colors.indigo[50]);

  ///set the border color [Colors.indigo[100]]
  T get borderIndigo100 => this..border(Colors.indigo[100]);

  ///set the border color [Colors.indigo[200]]
  T get borderIndigo200 => this..border(Colors.indigo[200]);

  ///set the border color [Colors.indigo[300]]
  T get borderIndigo300 => this..border(Colors.indigo[300]);

  ///set the border color [Colors.indigo[400]]
  T get borderIndigo400 => this..border(Colors.indigo[400]);

  ///set the border color [Colors.indigo[500]]
  T get borderIndigo500 => this..border(Colors.indigo[500]);

  ///set the border color [Colors.indigo[600]]
  T get borderIndigo600 => this..border(Colors.indigo[600]);

  ///set the border color [Colors.indigo[700]]
  T get borderIndigo700 => this..border(Colors.indigo[700]);

  ///set the border color [Colors.indigo[800]]
  T get borderIndigo800 => this..border(Colors.indigo[800]);

  ///set the border color [Colors.indigo[900]]
  T get borderIndigo900 => this..border(Colors.indigo[900]);
}
