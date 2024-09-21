/// Barry
/// @date 2024/9/20
/// describe:
///
void main() {
  for (int value = 52; value <= 80; value++) {
    if (value % 2 == 1) continue;
    print('  /// padding all $value');
    print('T get p$value => this..paddingValue = $value.r;\n');
  }

  for (int value = 52; value <= 80; value++) {
    if (value % 2 == 1) continue;
    print('  /// set the padding left is $value');
    print('T get pl$value => this..paddingLeft = $value.r;\n');
  }

  for (int value = 52; value <= 80; value++) {
    if (value % 2 == 1) continue;
    print('  /// set the padding right is $value');
    print('  T get pr$value => this..paddingRight = $value.r;\n');
  }

  for (int value = 52; value <= 80; value++) {
    if (value % 2 == 1) continue;
    print('  /// set the padding top is $value');
    print('  T get pt$value => this..paddingTop = $value.r;\n');
  }

  for (int value = 52; value <= 80; value++) {
    if (value % 2 == 1) continue;
    print('  /// set the padding bottom is $value');
    print('  T get pb$value => this..paddingBottom = $value.r;\n');
  }

  for (int value = 52; value <= 80; value++) {
    if (value % 2 == 1) continue;
    print('  /// set the padding horizontal value is $value');
    print('  T get ph$value => this..paddingHorizontal = $value.r;\n');
  }

  for (int value = 52; value <= 80; value++) {
    if (value % 2 == 1) continue;
    print('  /// set the padding vertical value is $value');
    print('  T get pv$value => this..paddingVertical = $value.r;\n');
  }
}
