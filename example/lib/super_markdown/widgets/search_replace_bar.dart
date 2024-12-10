import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:get/get.dart';

class SearchReplaceBar extends StatefulWidget {
  final String text;
  final ValueChanged<String> onTextChanged;
  final ValueChanged<SearchMatch> onMatchSelected;
  final VoidCallback onClose;

  const SearchReplaceBar({
    required this.text,
    required this.onTextChanged,
    required this.onMatchSelected,
    required this.onClose,
    super.key,
  });

  @override
  State<SearchReplaceBar> createState() => _SearchReplaceBarState();
}

class _SearchReplaceBarState extends State<SearchReplaceBar> {
  final _searchController = TextEditingController();
  final _replaceController = TextEditingController();
  final _showReplace = false.obs;
  final _matches = <SearchMatch>[].obs;
  var _currentMatchIndex = 0;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final searchText = _searchController.text;
    if (searchText.isEmpty) {
      _matches.clear();
      return;
    }

    // 查找所有匹配
    final matches = <SearchMatch>[];
    var start = 0;
    while (true) {
      final index = widget.text.indexOf(searchText, start);
      if (index == -1) break;
      matches.add(SearchMatch(
        start: index,
        end: index + searchText.length,
        text: searchText,
      ));
      start = index + 1;
    }

    _matches.value = matches;
    if (matches.isNotEmpty) {
      _currentMatchIndex = 0;
      widget.onMatchSelected(matches[0]);
    }
  }

  void _replaceAll() {
    if (_matches.isEmpty) return;
    final replaceText = _replaceController.text;
    var newText = widget.text;
    for (final match in _matches.reversed) {
      newText = newText.replaceRange(match.start, match.end, replaceText);
    }
    widget.onTextChanged(newText);
    _matches.clear();
  }

  void _replaceCurrent() {
    if (_matches.isEmpty) return;
    final match = _matches[_currentMatchIndex];
    final replaceText = _replaceController.text;
    final newText = widget.text.replaceRange(match.start, match.end, replaceText);
    widget.onTextChanged(newText);
    _matches.removeAt(_currentMatchIndex);
    if (_matches.isNotEmpty) {
      _currentMatchIndex %= _matches.length;
      widget.onMatchSelected(_matches[_currentMatchIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return container.white.rounded8.p16.cardShadow.child(
      column.children([
        // 搜索栏
        row.children([
          // 搜索输入框
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '搜索...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Obx(() => Text(
                      '${_currentMatchIndex + 1}/${_matches.length}',
                      style: const TextStyle(color: Colors.grey),
                    )),
                border: const OutlineInputBorder(),
              ),
            ),
          ),

          // 上一个/下一个按钮
          IconButton(
            icon: Icons.keyboard_arrow_up.icon.grey600.s20.mk,
            onPressed: () {
              if (_matches.isEmpty) return;
              _currentMatchIndex = (_currentMatchIndex - 1) % _matches.length;
              widget.onMatchSelected(_matches[_currentMatchIndex]);
            },
          ),
          IconButton(
            icon: Icons.keyboard_arrow_down.icon.grey600.s20.mk,
            onPressed: () {
              if (_matches.isEmpty) return;
              _currentMatchIndex = (_currentMatchIndex + 1) % _matches.length;
              widget.onMatchSelected(_matches[_currentMatchIndex]);
            },
          ),

          // 替换按钮
          IconButton(
            icon: Icons.find_replace.icon.grey600.s20.mk,
            onPressed: _showReplace.toggle,
          ),

          // 关闭按钮
          IconButton(
            icon: Icons.close.icon.grey600.s20.mk,
            onPressed: widget.onClose,
          ),
        ]),

        // 替换栏
        Obx(() => _showReplace.value
            ? container.mt8.child(
                row.children([
                  // 替换输入框
                  Expanded(
                    child: TextField(
                      controller: _replaceController,
                      decoration: const InputDecoration(
                        hintText: '替换为...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  // 替换按钮
                  TextButton(
                    onPressed: _replaceCurrent,
                    child: '替换'.text.mk,
                  ),
                  TextButton(
                    onPressed: _replaceAll,
                    child: '全部替换'.text.mk,
                  ),
                ]),
              )
            : const SizedBox()),
      ]),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _replaceController.dispose();
    super.dispose();
  }
}

class SearchMatch {
  final int start;
  final int end;
  final String text;

  SearchMatch({
    required this.start,
    required this.end,
    required this.text,
  });
}
