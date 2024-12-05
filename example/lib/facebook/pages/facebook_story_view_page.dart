import 'package:example/facebook/models/story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookStoryViewPage extends StatefulWidget {
  final List<Story> stories;
  final int initialIndex;

  const FacebookStoryViewPage({
    required this.stories,
    this.initialIndex = 0,
    super.key,
  });

  @override
  State<FacebookStoryViewPage> createState() => _FacebookStoryViewPageState();
}

class _FacebookStoryViewPageState extends State<FacebookStoryViewPage> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _progressController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _nextStory();
        }
      });
    _progressController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _nextStory() {
    if (_currentIndex < widget.stories.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  void _previousStory() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) {
          final width = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < width / 2) {
            _previousStory();
          } else {
            _nextStory();
          }
        },
        child: Stack(
          children: [
            // 故事内容
            PageView.builder(
              controller: _pageController,
              itemCount: widget.stories.length,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
                _progressController
                  ..reset()
                  ..forward();
              },
              itemBuilder: (context, index) {
                final story = widget.stories[index];
                return _buildStoryContent(story);
              },
            ),
            // 顶部进度条
            positioned.t0.l0.r0.child(
              container.p16.child(
                column.children([
                  // 进度条
                  row.children([
                    for (int i = 0; i < widget.stories.length; i++)
                      Expanded(
                        child: container.h2.ml(i > 0 ? 4 : 0).child(
                          LinearProgressIndicator(
                            value: i < _currentIndex
                                ? 1.0
                                : i == _currentIndex
                                    ? _progressController.value
                                    : 0.0,
                            backgroundColor: Colors.white30,
                            valueColor: const AlwaysStoppedAnimation(Colors.white),
                          ),
                        ),
                      ),
                  ]),
                  h16,
                  // 用户信息
                  row.spaceBetween.children([
                    row.children([
                      widget.stories[_currentIndex].userAvatar.image.s40.circle.mk,
                      w12,
                      column.crossStart.children([
                        widget.stories[_currentIndex].userName.text.white.f16.bold.mk,
                        '5分钟前'.text.white.f14.mk,
                      ]),
                    ]),
                    row.children([
                      container.s40.circle.black54.center
                          .child(Icons.more_horiz.icon.white.s24.mk)
                          .click(onTap: _showMoreOptions),
                      w16,
                      container.s40.circle.black54.center
                          .child(Icons.close.icon.white.s24.mk)
                          .click(onTap: () => Navigator.pop(context)),
                    ]),
                  ]),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryContent(Story story) {
    if (story.imageUrl != null) {
      return story.imageUrl!.image.wFull.hFull.cover.mk;
    } else {
      return container.wFull.hFull.color(story.backgroundColor ?? Colors.black).center.child(
            story.text?.text.white.f24.center.mk ?? const SizedBox(),
          );
    }
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => container.white.roundedT16.child(
        column.crossStart.children([
          container.p16.borderB1.borderGrey200.wFull.child(
            '更多选项'.text.f16.bold.mk,
          ),
          _buildOptionItem(Icons.share, '分享故事'),
          _buildOptionItem(Icons.report_outlined, '举报'),
          _buildOptionItem(Icons.block_outlined, '屏蔽此人'),
          container.h8.grey100.wFull.mk,
          _buildOptionItem(Icons.close, '取消', isRed: true),
        ]),
      ),
    );
  }

  Widget _buildOptionItem(IconData icon, String label, {bool isRed = false}) {
    return container.p16.wFull.child(
      row.children([
        icon.icon.s24.color(isRed ? Colors.red : Colors.grey[800]).mk,
        w16,
        label.text.f16.color(isRed ? Colors.red : Colors.black).mk,
      ]),
    ).click(onTap: () => Navigator.pop(context));
  }
} 