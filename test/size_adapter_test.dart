import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IdentitySizeAdapter', () {
    const adapter = IdentitySizeAdapter();

    test('w() returns input unchanged', () {
      expect(adapter.w(16.0), 16.0);
      expect(adapter.w(0.0), 0.0);
    });

    test('h() returns input unchanged', () {
      expect(adapter.h(100.0), 100.0);
    });

    test('r() returns input unchanged', () {
      expect(adapter.r(8.5), 8.5);
    });

    test('sp() returns input unchanged', () {
      expect(adapter.sp(14.0), 14.0);
    });
  });
}
