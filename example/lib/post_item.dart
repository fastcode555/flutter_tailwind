import 'package:example/res/tailwind_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/tailwind.dart';

/// Barry
/// @date 2024/8/26
/// describe:
String _avatar = "https://cdn.wujiebantu.com/ai/5BACBCDC2F2889FDBE02FCF0F4ADE2E0-01.jpg";
String _image = 'https://gd-hbimg.huaban.com/7300e038910823c1db920c1349e1185fc0c06e717d09a-j8CYtU';

class PostItem extends StatelessWidget {
  const PostItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bd.border1.borderBrown.r16.mk,
      padding: p16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _avatar.image.s50.circle.mk,
              w6,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Naruto".text.f16.bold.mk,
                    "Just Now".text.black54.f12.mk,
                  ],
                ),
              ),
            ],
          ),
          h12,
          "This is my favorite playlist of all time!".text.f12.mk,
          h12,
          _image.image.s121.r8.mk,
          h12,
          Container(
            padding: REdgeInsets.all(8),
            decoration: bd.r8.brown.mk,
            child: Row(
              children: [
                _image.image.s62.r8.mk,
                w6,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "English Songs".text.white.w700.f14.mk,
                    h6,
                    "2o Songs".text.white54.f12.mk,
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
