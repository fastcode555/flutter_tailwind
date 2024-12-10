import 'package:example/facebook/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookImagePreviewPage extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const FacebookImagePreviewPage({
    required this.imageUrls,
    this.initialIndex = 0,
    super.key,
  });

  @override
  State<FacebookImagePreviewPage> createState() => _FacebookImagePreviewPageState();
}

class _FacebookImagePreviewPageState extends State<FacebookImagePreviewPage> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: '${_currentIndex + 1}/${widget.imageUrls.length}'.text.white.f16.mk,
        actions: [
          container.s40.circle.black54.center
              .child(Icons.edit.icon.white.s24.mk)
              .click(onTap: () => AppRoutes.toImageEdit(context, widget.imageUrls[_currentIndex])),
          w16,
          container.s40.circle.black54.center
              .child(Icons.share.icon.white.s24.mk)
              .click(onTap: () => _showShareOptions(context)),
          w16,
          container.s40.circle.black54.center
              .child(Icons.more_horiz.icon.white.s24.mk)
              .click(onTap: () => _showMoreOptions(context)),
          w16,
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.imageUrls.length,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        itemBuilder: (context, index) => InteractiveViewer(
          minScale: 0.5,
          maxScale: 3,
          child: Center(
            child: widget.imageUrls[index].image.wFull.cover.mk,
          ),
        ),
      ),
    );
  }

  void _showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => container.white.roundedT16.child(
        column.crossStart.children([
          container.p16.borderB1.borderGrey200.wFull.child(
            '分享到'.text.f16.bold.mk,
          ),
          _buildOptionItem(Icons.chat_bubble_outline, '发送给好友'),
          _buildOptionItem(Icons.group_outlined, '分享到群组'),
          _buildOptionItem(Icons.timeline_outlined, '分享到动态'),
          _buildOptionItem(Icons.save_alt_outlined, '保存图片'),
          container.h8.grey100.wFull.mk,
          _buildOptionItem(Icons.close, '取消', isRed: true),
        ]),
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => container.white.roundedT16.child(
        column.crossStart.children([
          container.p16.borderB1.borderGrey200.wFull.child(
            '更多操作'.text.f16.bold.mk,
          ),
          _buildOptionItem(Icons.info_outline, '查看详情'),
          _buildOptionItem(Icons.report_outlined, '举报'),
          _buildOptionItem(Icons.block_outlined, '屏蔽'),
          container.h8.grey100.wFull.mk,
          _buildOptionItem(Icons.close, '取消', isRed: true),
        ]),
      ),
    );
  }

  Widget _buildOptionItem(IconData icon, String label, {bool isRed = false}) {
    return container.p16.wFull
        .child(
          row.children([
            icon.icon.s24.color(isRed ? Colors.red : Colors.grey[800]).mk,
            w16,
            label.text.f16.color(isRed ? Colors.red : Colors.black).mk,
          ]),
        )
        .click(onTap: () => Navigator.pop(context));
  }
}
