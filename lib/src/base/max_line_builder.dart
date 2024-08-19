/// @date 7/11/23
/// describe:
mixin MaxLineBuilder {
  int? maxLines;
}

extension MaxLineBuilderExt<T extends MaxLineBuilder> on T {
  T maxLines(int maxLines) => this..maxLines = maxLines;

  T get maxLines2 => this..maxLines = 2;

  T get maxLines3 => this..maxLines = 3;

  T get maxLines4 => this..maxLines = 4;

  T get maxLines5 => this..maxLines = 5;

  T get maxLines6 => this..maxLines = 6;

  T get maxLines7 => this..maxLines = 7;

  T get maxLines8 => this..maxLines = 8;

  T get maxLines9 => this..maxLines = 9;
}
