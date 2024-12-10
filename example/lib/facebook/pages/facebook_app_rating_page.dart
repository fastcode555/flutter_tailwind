import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookAppRatingPage extends StatefulWidget {
  const FacebookAppRatingPage({super.key});

  @override
  State<FacebookAppRatingPage> createState() => _FacebookAppRatingPageState();
}

class _FacebookAppRatingPageState extends State<FacebookAppRatingPage> {
  int _rating = 0;
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '应用评分'.text.f20.bold.mk,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          // 应用信息
          container.white.p16.child(
            column.center.children([
              'https://picsum.photos/100'.image.s80.mk,
              h16,
              'Facebook'.text.f20.bold.mk,
              h8,
              '版本 1.0.0'.text.grey600.f14.mk,
            ]),
          ),
          h16,
          // 评分
          container.white.p16.child(
            column.center.children([
              '请为应用评分'.text.f16.bold.mk,
              h16,
              row.center.children([
                for (var i = 1; i <= 5; i++)
                  container.p8.child(
                    (i <= _rating ? Icons.star : Icons.star_border)
                        .icon
                        .amber
                        .s32
                        .mk
                        .click(onTap: () => setState(() => _rating = i)),
                  ),
              ]),
              h8,
              _getRatingText().text.grey600.f14.mk,
            ]),
          ),
          h16,
          // 评价内容
          container.white.p16.child(
            column.crossStart.children([
              '写下你的评价'.text.f16.bold.mk,
              h16,
              container.grey100.rounded8.p12.wFull.child(
                TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    hintText: '分享你的使用体验...',
                    border: InputBorder.none,
                  ),
                  maxLines: 5,
                ),
              ),
            ]),
          ),
          h16,
          // 提交按钮
          container.blue.rounded8.p16.center.child('提交评价'.text.white.f16.bold.mk).click(onTap: _submitRating),
        ],
      ),
    );
  }

  String _getRatingText() {
    switch (_rating) {
      case 1:
        return '非常差';
      case 2:
        return '较差';
      case 3:
        return '一般';
      case 4:
        return '很好';
      case 5:
        return '非常好';
      default:
        return '请选择评分';
    }
  }

  void _submitRating() {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: '请先选择评分'.text.white.mk),
      );
      return;
    }

    if (_commentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: '请填写评价内容'.text.white.mk),
      );
      return;
    }

    // TODO: 提交评分和评价
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: '评价提交成功'.text.white.mk),
    );
    Navigator.pop(context);
  }
}
