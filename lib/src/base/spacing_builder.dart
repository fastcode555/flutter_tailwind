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

  T get spacing2 => this..innerSpacing = 2;

  T get spacing4 => this..innerSpacing = 4;

  T get spacing6 => this..innerSpacing = 6;

  T get spacing8 => this..innerSpacing = 8;

  T get spacing10 => this..innerSpacing = 10;

  T get spacing12 => this..innerSpacing = 12;

  T get spacing14 => this..innerSpacing = 14;

  T get spacing16 => this..innerSpacing = 16;

  T get spacing18 => this..innerSpacing = 18;

  T get spacing20 => this..innerSpacing = 20;

  T get spacing22 => this..innerSpacing = 22;

  T get spacing24 => this..innerSpacing = 24;

  T get spacing26 => this..innerSpacing = 26;

  T get spacing28 => this..innerSpacing = 28;

  T get spacing30 => this..innerSpacing = 30;

  T get spacing32 => this..innerSpacing = 32;

  T get runSpacing2 => this..innerRunSpacing = 2;

  T get runSpacing4 => this..innerRunSpacing = 4;

  T get runSpacing6 => this..innerRunSpacing = 6;

  T get runSpacing8 => this..innerRunSpacing = 8;

  T get runSpacing10 => this..innerRunSpacing = 10;

  T get runSpacing12 => this..innerRunSpacing = 12;

  T get runSpacing14 => this..innerRunSpacing = 14;

  T get runSpacing16 => this..innerRunSpacing = 16;

  T get runSpacing18 => this..innerRunSpacing = 18;

  T get runSpacing20 => this..innerRunSpacing = 20;

  T get runSpacing22 => this..innerRunSpacing = 22;

  T get runSpacing24 => this..innerRunSpacing = 24;

  T get runSpacing26 => this..innerRunSpacing = 26;

  T get runSpacing28 => this..innerRunSpacing = 28;

  T get runSpacing30 => this..innerRunSpacing = 30;

  T get runSpacing32 => this..innerRunSpacing = 32;

  T get mainSpacing2 => this..innerMainAxisSpacing = 2;

  T get mainSpacing4 => this..innerMainAxisSpacing = 4;

  T get mainSpacing6 => this..innerMainAxisSpacing = 6;

  T get mainSpacing8 => this..innerMainAxisSpacing = 8;

  T get mainSpacing10 => this..innerMainAxisSpacing = 10;

  T get mainSpacing12 => this..innerMainAxisSpacing = 12;

  T get mainSpacing14 => this..innerMainAxisSpacing = 14;

  T get mainSpacing16 => this..innerMainAxisSpacing = 16;

  T get mainSpacing18 => this..innerMainAxisSpacing = 18;

  T get mainSpacing20 => this..innerMainAxisSpacing = 20;

  T get mainSpacing22 => this..innerMainAxisSpacing = 22;

  T get mainSpacing24 => this..innerMainAxisSpacing = 24;

  T get mainSpacing26 => this..innerMainAxisSpacing = 26;

  T get mainSpacing28 => this..innerMainAxisSpacing = 28;

  T get mainSpacing30 => this..innerMainAxisSpacing = 30;

  T get mainSpacing32 => this..innerMainAxisSpacing = 32;

  T get crossSpacing2 => this..innerCrossAxisSpacing = 2;

  T get crossSpacing4 => this..innerCrossAxisSpacing = 4;

  T get crossSpacing6 => this..innerCrossAxisSpacing = 6;

  T get crossSpacing8 => this..innerCrossAxisSpacing = 8;

  T get crossSpacing10 => this..innerCrossAxisSpacing = 10;

  T get crossSpacing12 => this..innerCrossAxisSpacing = 12;

  T get crossSpacing14 => this..innerCrossAxisSpacing = 14;

  T get crossSpacing16 => this..innerCrossAxisSpacing = 16;

  T get crossSpacing18 => this..innerCrossAxisSpacing = 18;

  T get crossSpacing20 => this..innerCrossAxisSpacing = 20;

  T get crossSpacing22 => this..innerCrossAxisSpacing = 22;

  T get crossSpacing24 => this..innerCrossAxisSpacing = 24;

  T get crossSpacing26 => this..innerCrossAxisSpacing = 26;

  T get crossSpacing28 => this..innerCrossAxisSpacing = 28;

  T get crossSpacing30 => this..innerCrossAxisSpacing = 30;

  T get crossSpacing32 => this..innerCrossAxisSpacing = 32;
}
