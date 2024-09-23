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
}
