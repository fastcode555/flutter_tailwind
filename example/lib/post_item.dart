import 'package:example/res/tailwind_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// Barry
/// @date 2024/8/26
/// describe:
String _avatar = 'https://cdn.wujiebantu.com/ai/5BACBCDC2F2889FDBE02FCF0F4ADE2E0-01.jpg';
String _image = 'https://gd-hbimg.huaban.com/7300e038910823c1db920c1349e1185fc0c06e717d09a-j8CYtU';

class PostItem extends StatelessWidget {
  const PostItem({super.key});

  @override
  Widget build(BuildContext context) {
    return container.border5.borderBrown.p16.rounded16.child(
      column.crossStart.children(
        [
          Row(
            children: [
              _avatar.image.s50.circle.shadowMd.borderRed.border2.pr6.click(
                onTap: () => debugPrint('You are hero'),
              ),
              column.crossStart.expanded.children(
                [
                  ('Naruto' * 15).text.f16.conther.maxLine1.ellipsis.bold.mk,
                  'Just Now'.text.black54.conther.f12.mk,
                ],
              ),
              Icons.more_vert_rounded.icon.s26.black.mk,
            ],
          ),
          'This is my favorite playlist of all time!'.text.f14.conther.pt12.mk,
          _image.image.s121.rounded8.shadowMd.borderRedColor.border2.pv12.mk,
          container.p8.rounded8.border1.borderRedColor.pl10.brown.child(
            Row(
              children: [
                _image.image.s62.rounded8.pr6.mk,
                column.crossStart.expanded.children(
                  [
                    ('English Songs' * 15).text.white.maxLine2.ellipsis.w700.f14.mk,
                    '20 Songs'.text.white54.f12.pt2.mk,
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
