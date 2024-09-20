/// Barry
/// @date 2024/9/20
/// describe:
///
void main() {
  for (int value = 1; value < 20; value++) {
    print('/// set the height $value');
    print('T get h$value => this..height = $value.h;');
  }
  for (int value = 10; value < 50; value++) {
    print('/// set the height ${value * 2}');
    print('T get h${value * 2} => this..height = ${value * 2}.h;');
  }
  for (int i = 10; i < 81; i++) {
    var value = i * 5;
    print('/// set the height $value');
    print('T get h$value => this..height = $value.h;');
  }

  for (int value = 1; value < 20; value++) {
    print('/// set the width $value');
    print('T get w$value => this..width = $value.w;');
  }
  for (int value = 10; value < 50; value++) {
    print('/// set the width ${value * 2}');
    print('T get w${value * 2} => this..width = ${value * 2}.w;');
  }
  for (int i = 10; i < 81; i++) {
    var value = i * 5;
    print('/// set the width $value');
    print('T get w$value => this..width = $value.w;');
  }

  for (int value = 1; value < 20; value++) {
    print('/// set the size $value');
    print('T get s$value => this..size = $value.r;');
  }

  for (int value = 10; value < 50; value++) {
    print('/// set the size ${value * 2}');
    print('T get s${value * 2} => this..size = ${value * 2}.r;');
  }

  for (int i = 10; i < 81; i++) {
    var value = i * 5;

    print('/// set the size $value');
    print('T get s$value => this..size = $value.r;');
  }
}
