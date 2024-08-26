/// Barry
/// @date 7/11/23
/// describe:
mixin MaxLineBuilder {
  int? maxLines;
}

extension MaxLineBuilderExt<T extends MaxLineBuilder> on T {
  T maxLines(int maxLines) => this..maxLines = maxLines;

  T get maxLine1 => this..maxLines = 1;

  T get maxLine2 => this..maxLines = 2;

  T get maxLine3 => this..maxLines = 3;

  T get maxLine4 => this..maxLines = 4;

  T get maxLine5 => this..maxLines = 5;

  T get maxLine6 => this..maxLines = 6;

  T get maxLine7 => this..maxLines = 7;

  T get maxLine8 => this..maxLines = 8;

  T get maxLine9 => this..maxLines = 9;
}
