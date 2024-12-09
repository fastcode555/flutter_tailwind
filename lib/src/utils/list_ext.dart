/// Barry
/// @date 2024/9/21
/// describe:
extension ListExt<T> on List<T>? {
  T? get(int index) {
    if (this == null || this!.isEmpty) return null;
    if (index < this!.length) {
      return this![index];
    }
    return null;
  }

  List<T> joinWidget(T separatedWidth) {
    if (this == null || this!.isEmpty) return <T>[];
    final newChildren = <T>[];
    for (var i = 0; i < this!.length; i++) {
      final t = this![i];
      newChildren.add(t);
      if (i != this!.length - 1) {
        newChildren.add(separatedWidth);
      }
    }
    return newChildren;
  }
}
