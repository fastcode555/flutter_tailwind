import 'dart:convert';
import 'dart:html' as html;

import 'package:get/get.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:markdown/markdown.dart' as md;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ExportService extends GetxService {
  // 导出为 PDF
  Future<void> exportToPdf(String markdown) async {
    final pdf = pw.Document();

    // 转换 Markdown 为 HTML
    final htmlContent = md.markdownToHtml(markdown);
    final document = html_parser.parse(htmlContent);

    // 创建 PDF 页面
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                document.body?.text ?? '',
                style: const pw.TextStyle(fontSize: 12),
              ),
            ],
          );
        },
      ),
    );

    // 保存 PDF
    final bytes = await pdf.save();
    _downloadFile(bytes, 'document.pdf', 'application/pdf');
  }

  // 导出为 HTML
  Future<void> exportToHtml(String markdown) async {
    // 转换 Markdown 为 HTML
    final content = md.markdownToHtml(markdown);

    // 创建完整的 HTML 文档
    final html = '''
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <title>Markdown Document</title>
        <style>
          body {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            line-height: 1.6;
          }
          pre {
            background: #f5f5f5;
            padding: 15px;
            border-radius: 5px;
            overflow-x: auto;
          }
          code {
            font-family: monospace;
          }
          blockquote {
            border-left: 4px solid #ddd;
            margin: 0;
            padding-left: 15px;
            color: #666;
          }
          img {
            max-width: 100%;
          }
          table {
            border-collapse: collapse;
            width: 100%;
          }
          th, td {
            border: 1px solid #ddd;
            padding: 8px;
          }
          th {
            background: #f5f5f5;
          }
        </style>
      </head>
      <body>
        $content
      </body>
      </html>
    ''';

    // 下载 HTML 文件
    final bytes = utf8.encode(html);
    _downloadFile(bytes, 'document.html', 'text/html');
  }

  // 导出为 Word
  Future<void> exportToWord(String markdown) async {
    // 转换 Markdown 为 HTML
    final content = md.markdownToHtml(markdown);

    // 创建简单的 Word XML
    final wordXml = '''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<?mso-application progid="Word.Document"?>
<w:wordDocument xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml">
  <w:body>
    <w:p>
      <w:r>
        <w:t>$content</w:t>
      </w:r>
    </w:p>
  </w:body>
</w:wordDocument>
''';

    final bytes = utf8.encode(wordXml);
    _downloadFile(
      bytes,
      'document.doc',
      'application/msword',
    );
  }

  // 导出为 PowerPoint
  Future<void> exportToPowerPoint(String markdown) async {
    // 转换 Markdown 为 HTML
    final content = md.markdownToHtml(markdown);

    // 创建简单的 PPTX XML
    final pptXml = '''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<p:presentation xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main">
  <p:sldMaster>
    <p:cSld>
      <p:spTree>
        <p:sp>
          <p:txBody>
            <a:p>
              <a:r>
                <a:t>$content</a:t>
              </a:r>
            </a:p>
          </p:txBody>
        </p:sp>
      </p:spTree>
    </p:cSld>
  </p:sldMaster>
</p:presentation>
''';

    final bytes = utf8.encode(pptXml);
    _downloadFile(
      bytes,
      'presentation.pptx',
      'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    );
  }

  // 通用下载文件方法
  void _downloadFile(List<int> bytes, String filename, String mimeType) {
    final blob = html.Blob([bytes], mimeType);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', filename)
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
