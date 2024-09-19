/// Barry
/// @date 7/11/23
/// describe:
mixin MaxLineBuilder {
  int? innerMaxLines;
}

extension MaxLineBuilderExt<T extends MaxLineBuilder> on T {
  /// set the max line value is maxLines
  T maxLines(int maxLines) => this..innerMaxLines = maxLines;

  /// set the max line value is 1
  T get maxLine1 => this..innerMaxLines = 1;

  /// set the max line value is 2
  T get maxLine2 => this..innerMaxLines = 2;

  /// set the max line value is 3
  T get maxLine3 => this..innerMaxLines = 3;

  /// set the max line value is 4
  T get maxLine4 => this..innerMaxLines = 4;

  /// set the max line value is 5
  T get maxLine5 => this..innerMaxLines = 5;

  /// set the max line value is 6
  T get maxLine6 => this..innerMaxLines = 6;

  /// set the max line value is 7
  T get maxLine7 => this..innerMaxLines = 7;

  /// set the max line value is 8
  T get maxLine8 => this..innerMaxLines = 8;

  /// set the max line value is 9
  T get maxLine9 => this..innerMaxLines = 9;
}
