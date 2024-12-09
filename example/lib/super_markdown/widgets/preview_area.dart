import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:url_launcher/url_launcher.dart';

class PreviewArea extends StatelessWidget {
  final String markdown;
  final ScrollController? scrollController;

  const PreviewArea({
    required this.markdown, super.key,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return container.white.p16.child(
      Markdown(
        data: markdown,
        controller: scrollController,
        selectable: true,
        onTapLink: (text, href, title) async {
          if (href != null) {
            final uri = Uri.parse(href);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          }
        },
        styleSheet: MarkdownStyleSheet(
          h1: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          h2: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          h3: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          h4: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          h5: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          h6: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          p: const TextStyle(fontSize: 16),
          code: TextStyle(
            backgroundColor: Colors.grey[200],
            fontFamily: 'monospace',
          ),
          codeblockDecoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          blockquote: TextStyle(
            color: Colors.grey[700],
            fontStyle: FontStyle.italic,
          ),
          tableHead: const TextStyle(fontWeight: FontWeight.bold),
          tableBorder: TableBorder.all(
            color: Colors.grey[300]!,
          ),
        ),
      ),
    );
  }
}
