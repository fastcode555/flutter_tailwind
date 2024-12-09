import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

class ChartExportService {
  // 导出为图片
  static Future<void> exportToImage(RenderRepaintBoundary boundary) async {
    final image = await boundary.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    final blob = html.Blob([bytes], 'image/png');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'flowchart.png')
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
