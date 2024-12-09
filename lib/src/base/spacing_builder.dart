import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Barry
/// @date 2024/9/21
/// describe:
mixin SpacingBuilder {
  ///设置间距的
  double? innerSpacing, innerRunSpacing, innerMainAxisSpacing, innerCrossAxisSpacing;
}

extension SpacingBuilderExt<T extends SpacingBuilder> on T {
  T spacing(double spacing) => this..innerSpacing = spacing;

  T mainAxisSpacing(double mainAxisSpacing) => this..innerMainAxisSpacing = mainAxisSpacing;

  T runSpacing(double runSpacing) => this..innerRunSpacing = runSpacing;

  T crossAxisSpacing(double crossAxisSpacing) => this..innerCrossAxisSpacing = crossAxisSpacing;

  T get spacing2 => this..innerSpacing = 2.r;

  T get spacing4 => this..innerSpacing = 4.r;

  T get spacing6 => this..innerSpacing = 6.r;

  T get spacing8 => this..innerSpacing = 8.r;

  T get spacing10 => this..innerSpacing = 10.r;

  T get spacing12 => this..innerSpacing = 12.r;

  T get spacing14 => this..innerSpacing = 14.r;

  T get spacing16 => this..innerSpacing = 16.r;

  T get spacing18 => this..innerSpacing = 18.r;

  T get spacing20 => this..innerSpacing = 20.r;

  T get spacing22 => this..innerSpacing = 22.r;

  T get spacing24 => this..innerSpacing = 24.r;

  T get spacing26 => this..innerSpacing = 26.r;

  T get spacing28 => this..innerSpacing = 28.r;

  T get spacing30 => this..innerSpacing = 30.r;

  T get spacing32 => this..innerSpacing = 32.r;

  T get runSpacing2 => this..innerRunSpacing = 2.r;

  T get runSpacing4 => this..innerRunSpacing = 4.r;

  T get runSpacing6 => this..innerRunSpacing = 6.r;

  T get runSpacing8 => this..innerRunSpacing = 8.r;

  T get runSpacing10 => this..innerRunSpacing = 10.r;

  T get runSpacing12 => this..innerRunSpacing = 12.r;

  T get runSpacing14 => this..innerRunSpacing = 14.r;

  T get runSpacing16 => this..innerRunSpacing = 16.r;

  T get runSpacing18 => this..innerRunSpacing = 18.r;

  T get runSpacing20 => this..innerRunSpacing = 20.r;

  T get runSpacing22 => this..innerRunSpacing = 22.r;

  T get runSpacing24 => this..innerRunSpacing = 24.r;

  T get runSpacing26 => this..innerRunSpacing = 26.r;

  T get runSpacing28 => this..innerRunSpacing = 28.r;

  T get runSpacing30 => this..innerRunSpacing = 30.r;

  T get runSpacing32 => this..innerRunSpacing = 32.r;

  T get mainSpacing2 => this..innerMainAxisSpacing = 2.r;

  T get mainSpacing4 => this..innerMainAxisSpacing = 4.r;

  T get mainSpacing6 => this..innerMainAxisSpacing = 6.r;

  T get mainSpacing8 => this..innerMainAxisSpacing = 8.r;

  T get mainSpacing10 => this..innerMainAxisSpacing = 10.r;

  T get mainSpacing12 => this..innerMainAxisSpacing = 12.r;

  T get mainSpacing14 => this..innerMainAxisSpacing = 14.r;

  T get mainSpacing16 => this..innerMainAxisSpacing = 16.r;

  T get mainSpacing18 => this..innerMainAxisSpacing = 18.r;

  T get mainSpacing20 => this..innerMainAxisSpacing = 20.r;

  T get mainSpacing22 => this..innerMainAxisSpacing = 22.r;

  T get mainSpacing24 => this..innerMainAxisSpacing = 24.r;

  T get mainSpacing26 => this..innerMainAxisSpacing = 26.r;

  T get mainSpacing28 => this..innerMainAxisSpacing = 28.r;

  T get mainSpacing30 => this..innerMainAxisSpacing = 30.r;

  T get mainSpacing32 => this..innerMainAxisSpacing = 32.r;

  T get crossSpacing2 => this..innerCrossAxisSpacing = 2.r;

  T get crossSpacing4 => this..innerCrossAxisSpacing = 4.r;

  T get crossSpacing6 => this..innerCrossAxisSpacing = 6.r;

  T get crossSpacing8 => this..innerCrossAxisSpacing = 8.r;

  T get crossSpacing10 => this..innerCrossAxisSpacing = 10.r;

  T get crossSpacing12 => this..innerCrossAxisSpacing = 12.r;

  T get crossSpacing14 => this..innerCrossAxisSpacing = 14.r;

  T get crossSpacing16 => this..innerCrossAxisSpacing = 16.r;

  T get crossSpacing18 => this..innerCrossAxisSpacing = 18.r;

  T get crossSpacing20 => this..innerCrossAxisSpacing = 20.r;

  T get crossSpacing22 => this..innerCrossAxisSpacing = 22.r;

  T get crossSpacing24 => this..innerCrossAxisSpacing = 24.r;

  T get crossSpacing26 => this..innerCrossAxisSpacing = 26.r;

  T get crossSpacing28 => this..innerCrossAxisSpacing = 28.r;

  T get crossSpacing30 => this..innerCrossAxisSpacing = 30.r;

  T get crossSpacing32 => this..innerCrossAxisSpacing = 32.r;
}
