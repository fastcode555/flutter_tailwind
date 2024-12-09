import 'package:example/super_markdown/core/suggestions/suggestion_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class SuggestionList extends StatelessWidget {
  final List<Suggestion> suggestions;
  final Function(Suggestion) onSelected;

  const SuggestionList({
    required this.suggestions, required this.onSelected, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return container.white.rounded8.cardShadow.w300.maxH(300).child(
          ListView.builder(
            itemCount: suggestions.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => _buildSuggestionItem(
              suggestions[index],
              context,
            ),
          ),
        );
  }

  Widget _buildSuggestionItem(Suggestion suggestion, BuildContext context) {
    return InkWell(
      onTap: () => onSelected(suggestion),
      child: container.p12.borderB1.borderGrey200.child(
        row.children([
          // 图标
          if (suggestion.icon != null)
            container.s24.mr8.child(
              Icon(suggestion.icon, size: 16),
            ),

          // 内容
          column.crossStart.expanded.children([
            // 标题
            row.children([
              suggestion.label.text.f14.bold.mk,
              if (suggestion.shortcut != null) ...[
                const Spacer(),
                suggestion.shortcut!.text.grey600.f12.mk,
              ],
            ]),

            // 描述
            if (suggestion.description.isNotEmpty) suggestion.description.text.grey600.f12.mk,

            // 示例
            if (suggestion.example != null)
              container.grey100.rounded4.p4.mt4.child(
                suggestion.example!.text.grey600.f12.mk,
              ),
          ]),
        ]),
      ),
    );
  }
}
