import 'package:flutter_tailwind/tailwind.dart';

import 'colours.dart';

extension CustomSizeBuilderExt<T extends SizeBuilder> on T {
  T get h200 => this..height = 200.h;

  T get w200 => this..width = 200.w;

  T get s200 => this..size = 200.r;
}

extension CustomColorBuilderExt<T extends ColorBuilder> on T {
  T get secondaryColor => this..color = Colours.secondaryColor;

  T get app_main => this..color = Colours.app_main;

  T get gray_33 => this..color = Colours.gray_33;

  T get gray_99 => this..color = Colours.gray_99;

  T get main_text_color => this..color = Colours.main_text_color;

  T get text_hint_color => this..color = Colours.text_hint_color;

  T get line_color => this..color = Colours.line_color;

  T get blue => this..color = Colours.blue;

  T get color_e8e8e8 => this..color = Colours.color_e8e8e8;

  T get color_11151C => this..color = Colours.color_11151C;

  T get color_ffbd49 => this..color = Colours.color_ffbd49;

  T get color_FE2042 => this..color = Colours.color_FE2042;

  T get color_d05301 => this..color = Colours.color_d05301;

  T get color_303030 => this..color = Colours.color_303030;

  T get color_f2f2f7 => this..color = Colours.color_f2f2f7;

  T get backgroundColor => this..color = Colours.backgroundColor;

  T get disableColor => this..color = Colours.disableColor;

  T get mainText2 => this..color = Colours.mainText2;

  T get x00212639 => this..color = Colours.x00212639;

  T get primaryColor => this..color = Colours.primaryColor;

  T get x26ffffff => this..color = Colours.x26ffffff;

  T get redColor => this..color = Colours.redColor;

  T get transparent => this..color = Colours.transparent;

  T get ccfa94fb => this..color = Colours.ccfa94fb;

  T get ccad83e4 => this..color = Colours.ccad83e4;

  T get ccfdf194 => this..color = Colours.ccfdf194;

  T get ff4d4d4d => this..color = Colours.ff4d4d4d;

  T get ff2e3a56 => this..color = Colours.ff2e3a56;

  T get btnDisableColor => this..color = Colours.btnDisableColor;

  T get unselectedColor => this..color = Colours.unselectedColor;

  T get red_accent => this..color = Colours.red_accent;

  T get blue_accent => this..color = Colours.blue_accent;

  T get purple_accent => this..color = Colours.purple_accent;

  T get unSelectedColor => this..color = Colours.unSelectedColor;

  T get gray => this..color = Colours.gray;

  T get grey_text => this..color = Colours.grey_text;

  T get ff0c4e5f => this..color = Colours.ff0c4e5f;

  T get ff172f35 => this..color = Colours.ff172f35;

  T get ff333333 => this..color = Colours.ff333333;

  T get ff363636 => this..color = Colours.ff363636;

  T get ffb7d547 => this..color = Colours.ffb7d547;

  T get fff46b29 => this..color = Colours.fff46b29;

  T get redFF5F5F => this..color = Colours.redFF5F5F;

  T get appbarActiveColor => this..color = Colours.appbarActiveColor;

  T get ffffa88f => this..color = Colours.ffffa88f;

  T get orange => this..color = Colours.orange;

  T get colorGrey => this..color = Colours.colorGrey;

  T get colorGrey495057 => this..color = Colours.colorGrey495057;

  T get colorBlack494949 => this..color = Colours.colorBlack494949;

  T get colorRed3A28 => this..color = Colours.colorRed3A28;

  T get colorWhiteF8F9FA => this..color = Colours.colorWhiteF8F9FA;

  T get colorWhiteF5F5 => this..color = Colours.colorWhiteF5F5;

  T get colorGreyF0F0 => this..color = Colours.colorGreyF0F0;

  T get gray_66 => this..color = Colours.gray_66;
}

extension CustomBorderColorBuilderExt<T extends BorderColorBuilder> on T {
  T get borderSecondaryColor => this..border(Colours.secondaryColor);

  T get borderApp_main => this..border(Colours.app_main);

  T get borderGray_33 => this..border(Colours.gray_33);

  T get borderGray_99 => this..border(Colours.gray_99);

  T get borderMain_text_color => this..border(Colours.main_text_color);

  T get borderText_hint_color => this..border(Colours.text_hint_color);

  T get borderLine_color => this..border(Colours.line_color);

  T get borderBlue => this..border(Colours.blue);

  T get borderColor_e8e8e8 => this..border(Colours.color_e8e8e8);

  T get borderColor_11151C => this..border(Colours.color_11151C);

  T get borderColor_ffbd49 => this..border(Colours.color_ffbd49);

  T get borderColor_FE2042 => this..border(Colours.color_FE2042);

  T get borderColor_d05301 => this..border(Colours.color_d05301);

  T get borderColor_303030 => this..border(Colours.color_303030);

  T get borderColor_f2f2f7 => this..border(Colours.color_f2f2f7);

  T get borderBackgroundColor => this..border(Colours.backgroundColor);

  T get borderDisableColor => this..border(Colours.disableColor);

  T get borderMainText2 => this..border(Colours.mainText2);

  T get borderX00212639 => this..border(Colours.x00212639);

  T get borderPrimaryColor => this..border(Colours.primaryColor);

  T get borderX26ffffff => this..border(Colours.x26ffffff);

  T get borderRedColor => this..border(Colours.redColor);

  T get borderTransparent => this..border(Colours.transparent);

  T get borderCcfa94fb => this..border(Colours.ccfa94fb);

  T get borderCcad83e4 => this..border(Colours.ccad83e4);

  T get borderCcfdf194 => this..border(Colours.ccfdf194);

  T get borderFf4d4d4d => this..border(Colours.ff4d4d4d);

  T get borderFf2e3a56 => this..border(Colours.ff2e3a56);

  T get borderBtnDisableColor => this..border(Colours.btnDisableColor);

  T get borderUnselectedColor => this..border(Colours.unselectedColor);

  T get borderRed_accent => this..border(Colours.red_accent);

  T get borderBlue_accent => this..border(Colours.blue_accent);

  T get borderPurple_accent => this..border(Colours.purple_accent);

  T get borderUnSelectedColor => this..border(Colours.unSelectedColor);

  T get borderGray => this..border(Colours.gray);

  T get borderGrey_text => this..border(Colours.grey_text);

  T get borderFf0c4e5f => this..border(Colours.ff0c4e5f);

  T get borderFf172f35 => this..border(Colours.ff172f35);

  T get borderFf333333 => this..border(Colours.ff333333);

  T get borderFf363636 => this..border(Colours.ff363636);

  T get borderFfb7d547 => this..border(Colours.ffb7d547);

  T get borderFff46b29 => this..border(Colours.fff46b29);

  T get borderRedFF5F5F => this..border(Colours.redFF5F5F);

  T get borderAppbarActiveColor => this..border(Colours.appbarActiveColor);

  T get borderFfffa88f => this..border(Colours.ffffa88f);

  T get borderOrange => this..border(Colours.orange);

  T get borderColorGrey => this..border(Colours.colorGrey);

  T get borderColorGrey495057 => this..border(Colours.colorGrey495057);

  T get borderColorBlack494949 => this..border(Colours.colorBlack494949);

  T get borderColorRed3A28 => this..border(Colours.colorRed3A28);

  T get borderColorWhiteF8F9FA => this..border(Colours.colorWhiteF8F9FA);

  T get borderColorWhiteF5F5 => this..border(Colours.colorWhiteF5F5);

  T get borderColorGreyF0F0 => this..border(Colours.colorGreyF0F0);

  T get borderGray_66 => this..border(Colours.gray_66);
}
