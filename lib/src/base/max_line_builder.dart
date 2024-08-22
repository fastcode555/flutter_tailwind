/// @date 7/11/23
/// describe:
mixin MaxLineBuilder {
  int? maxLines;
}

extension MaxLineBuilderExt<T extends MaxLineBuilder> on T {
  T maxLines(int maxLines) => this..maxLines = maxLines;

  T get maxLiner2 => this..maxLines = 2;

  T get maxLiner3 => this..maxLines = 3;

  T get maxLiner4 => this..maxLines = 4;

  T get maxLiner5 => this..maxLines = 5;

  T get maxLiner6 => this..maxLines = 6;

  T get maxLiner7 => this..maxLines = 7;

  T get maxLiner8 => this..maxLines = 8;

  T get maxLiner9 => this..maxLines = 9;
}
