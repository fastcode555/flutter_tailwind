import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TemplateService extends GetxService {
  final Map<String, ExportTemplate> _templates = {};

  @override
  void onInit() {
    super.onInit();
    _loadDefaultTemplates();
  }

  void _loadDefaultTemplates() {
    // Word 模板
    _templates['default_word'] = ExportTemplate(
      name: 'Default Word',
      type: ExportType.word,
      path: 'assets/templates/default.docx',
      styles: {
        'heading1': const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        'heading2': const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        'paragraph': const TextStyle(fontSize: 12),
        'code': const TextStyle(fontFamily: 'Courier New', fontSize: 10),
      },
    );

    // PowerPoint 模板
    _templates['default_ppt'] = ExportTemplate(
      name: 'Default PowerPoint',
      type: ExportType.powerPoint,
      path: 'assets/templates/default.pptx',
      styles: {
        'title': const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        'subtitle': const TextStyle(fontSize: 24),
        'body': const TextStyle(fontSize: 18),
        'footer': const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
      },
      layouts: {
        'title': SlideLayout(
          elements: [
            LayoutElement(
              type: ElementType.text,
              rect: const Rect.fromLTWH(40, 40, 600, 100),
              style: 'title',
            ),
            LayoutElement(
              type: ElementType.text,
              rect: const Rect.fromLTWH(40, 160, 600, 300),
              style: 'subtitle',
            ),
          ],
        ),
        'content': SlideLayout(
          elements: [
            LayoutElement(
              type: ElementType.text,
              rect: const Rect.fromLTWH(40, 40, 600, 50),
              style: 'title',
            ),
            LayoutElement(
              type: ElementType.text,
              rect: const Rect.fromLTWH(40, 100, 600, 400),
              style: 'body',
            ),
          ],
        ),
      },
    );

    // PDF 模板
    _templates['default_pdf'] = ExportTemplate(
      name: 'Default PDF',
      type: ExportType.pdf,
      styles: {
        'heading1': const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        'heading2': const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        'paragraph': const TextStyle(fontSize: 12),
        'code': const TextStyle(fontFamily: 'Courier New', fontSize: 10),
      },
      pageSetup: PageSetup(
        header: HeaderFooter(
          text: DateTime.now().toString(),
          alignment: Alignment.centerRight,
        ),
        footer: HeaderFooter(
          text: 'Page ${PageNumber.current} of ${PageNumber.total}',
        ),
      ),
    );
  }

  // 获取可用模板
  List<ExportTemplate> getTemplates(ExportType type) {
    return _templates.values.where((t) => t.type == type).toList();
  }

  // 添加自定义模板
  void addTemplate(String key, ExportTemplate template) {
    _templates[key] = template;
  }

  // 删除模板
  void removeTemplate(String key) {
    _templates.remove(key);
  }
}

// 导出类型
enum ExportType {
  word,
  powerPoint,
  pdf,
  html,
}

// 页面大小
enum PageSize {
  a4,
  letter,
  legal,
  custom,
}

// 元素类型
enum ElementType {
  text,
  image,
  table,
  chart,
}

// 页码
class PageNumber {
  static const String current = '{current}';
  static const String total = '{total}';
}

// 导出模板
class ExportTemplate {
  final String name;
  final ExportType type;
  final String? path;
  final Map<String, TextStyle> styles;
  final Map<String, SlideLayout>? layouts;
  final PageSetup? pageSetup;

  ExportTemplate({
    required this.name,
    required this.type,
    required this.styles,
    this.path,
    this.layouts,
    this.pageSetup,
  });
}

// 页面设置
class PageSetup {
  final PageSize size;
  final EdgeInsets margin;
  final HeaderFooter? header;
  final HeaderFooter? footer;
  final Size? customSize;

  PageSetup({
    this.size = PageSize.a4,
    this.margin = const EdgeInsets.all(72),
    this.header,
    this.footer,
    this.customSize,
  });
}

// 页眉页脚
class HeaderFooter {
  final String text;
  final Alignment alignment;
  final TextStyle? style;

  HeaderFooter({
    required this.text,
    this.alignment = Alignment.center,
    this.style,
  });
}

// 幻灯片布局
class SlideLayout {
  final List<LayoutElement> elements;
  final Color? backgroundColor;

  SlideLayout({
    required this.elements,
    this.backgroundColor,
  });
}

// 布局元素
class LayoutElement {
  final ElementType type;
  final Rect rect;
  final String style;
  final Map<String, dynamic>? properties;

  LayoutElement({
    required this.type,
    required this.rect,
    required this.style,
    this.properties,
  });
}
