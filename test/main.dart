/// Barry
/// @date 2024/9/20
/// describe:
///
void main() {
  print('''///set border top width 1
        T get borderT => this..innerBorderT = 1;\n''');
  for (var i = 0; i <= 40; i++) {
    print('''///set border top width $i
        T get borderT$i => this..innerBorderT = $i;\n''');
  }

  print('''///set border right width 1
        T get borderR => this..innerBorderR = 1;\n''');
  for (var i = 0; i <= 40; i++) {
    print('''///set border right width $i
        T get borderR$i => this..innerBorderR = $i;\n''');
  }

  print('''///set border bottom width 1
        T get borderB => this..innerBorderB = 1;\n''');
  for (var i = 0; i <= 40; i++) {
    print('''///set border bottom width $i
        T get borderB$i => this..innerBorderB = $i;\n''');
  }

  print('''///set border left width 1
        T get borderL => this..innerBorderL = 1;\n''');
  for (var i = 0; i <= 40; i++) {
    print('''///set border left width $i
        T get borderL$i => this..innerBorderL = $i;\n''');
  }
}
