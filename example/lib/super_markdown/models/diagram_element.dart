import 'dart:ui';

class DiagramElement {
  final String id;
  final String type;
  final String label;
  final Offset position;
  final Map<String, dynamic> properties;

  DiagramElement({
    required this.id,
    required this.type,
    required this.label,
    required this.position,
    this.properties = const {},
  });

  // 复制并修改元素
  DiagramElement copyWith({
    String? id,
    String? type,
    String? label,
    Offset? position,
    Map<String, dynamic>? properties,
  }) {
    return DiagramElement(
      id: id ?? this.id,
      type: type ?? this.type,
      label: label ?? this.label,
      position: position ?? this.position,
      properties: properties ?? Map.from(this.properties),
    );
  }

  // 从JSON创建元素
  factory DiagramElement.fromJson(Map<String, dynamic> json) {
    return DiagramElement(
      id: json['id'] as String,
      type: json['type'] as String,
      label: json['label'] as String,
      position: Offset(
        json['position']['x'] as double,
        json['position']['y'] as double,
      ),
      properties: json['properties'] as Map<String, dynamic>? ?? {},
    );
  }

  // 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'label': label,
      'position': {
        'x': position.dx,
        'y': position.dy,
      },
      'properties': properties,
    };
  }

  // 元素类型枚举
  static const String typeParticipant = 'participant';
  static const String typeMessage = 'message';
  static const String typeNote = 'note';
  static const String typeFragment = 'fragment';
  static const String typeGroup = 'group';
  static const String typeActivation = 'activation';
  static const String typeDeactivation = 'deactivation';
  static const String typeReference = 'reference';
  static const String typeState = 'state';
  static const String typeLoop = 'loop';
  static const String typeAlt = 'alt';
  static const String typeOpt = 'opt';
  static const String typePar = 'par';
  static const String typeBreak = 'break';
  static const String typeCritical = 'critical';
}
