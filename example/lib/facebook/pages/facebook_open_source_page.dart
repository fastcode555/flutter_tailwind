import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookOpenSourcePage extends StatelessWidget {
  const FacebookOpenSourcePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '开源许可'.text.f20.bold.mk,
      ),
      body: ListView(
        children: [
          // 说明
          container.white.p16.child(
            '本应用使用了以下开源项目，在此感谢这些项目的贡献者。'.text.grey600.f14.mk,
          ),
          h8,
          // 许可列表
          container.white.child(
            column.children([
              _buildLicenseItem(
                'flutter_tailwind',
                'MIT License',
                'https://github.com/example/flutter_tailwind',
              ),
              _buildLicenseItem(
                'flutter_screenutil',
                'MIT License',
                'https://github.com/example/flutter_screenutil',
              ),
              _buildLicenseItem(
                'cached_network_image',
                'MIT License',
                'https://github.com/example/cached_network_image',
              ),
              _buildLicenseItem(
                'flutter_svg',
                'MIT License',
                'https://github.com/example/flutter_svg',
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildLicenseItem(String name, String license, String url) {
    return container.borderB1.borderGrey200.child(
      container.p16.child(
        column.crossStart.children([
          name.text.f16.bold.mk,
          h4,
          license.text.grey600.f14.mk,
          h4,
          url.text.blue.f14.mk,
        ]),
      ),
    );
  }
}
