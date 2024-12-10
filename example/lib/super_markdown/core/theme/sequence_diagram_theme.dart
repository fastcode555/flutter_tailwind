import 'package:flutter/material.dart';

class SequenceDiagramTheme {
  final ParticipantStyle participantStyle;
  final LifelineStyle lifelineStyle;
  final MessageStyle messageStyle;
  final NoteStyle noteStyle;
  final Color backgroundColor;

  const SequenceDiagramTheme({
    this.participantStyle = const ParticipantStyle(),
    this.lifelineStyle = const LifelineStyle(),
    this.messageStyle = const MessageStyle(),
    this.noteStyle = const NoteStyle(),
    this.backgroundColor = Colors.white,
  });

  SequenceDiagramTheme copyWith({
    ParticipantStyle? participantStyle,
    LifelineStyle? lifelineStyle,
    MessageStyle? messageStyle,
    NoteStyle? noteStyle,
    Color? backgroundColor,
  }) {
    return SequenceDiagramTheme(
      participantStyle: participantStyle ?? this.participantStyle,
      lifelineStyle: lifelineStyle ?? this.lifelineStyle,
      messageStyle: messageStyle ?? this.messageStyle,
      noteStyle: noteStyle ?? this.noteStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}

class ParticipantStyle {
  final double width;
  final double height;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final TextStyle textStyle;
  final double cornerRadius;
  final List<BoxShadow>? shadows;

  const ParticipantStyle({
    this.width = 120,
    this.height = 40,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.blue,
    this.borderWidth = 1.0,
    this.textStyle = const TextStyle(fontSize: 14),
    this.cornerRadius = 4.0,
    this.shadows,
  });
}

class LifelineStyle {
  final Color color;
  final double width;
  final List<double>? dashPattern;
  final bool animated;
  final Color? activationColor;
  final double activationWidth;

  const LifelineStyle({
    this.color = Colors.grey,
    this.width = 1.0,
    this.dashPattern,
    this.animated = false,
    this.activationColor,
    this.activationWidth = 10.0,
  });
}

class MessageStyle {
  final Color color;
  final double width;
  final double arrowSize;
  final TextStyle textStyle;
  final double spacing;
  final double textSpacing;
  final bool animated;
  final List<double>? dashPattern;
  final StrokeCap strokeCap;

  const MessageStyle({
    this.color = Colors.blue,
    this.width = 1.0,
    this.arrowSize = 6.0,
    this.textStyle = const TextStyle(fontSize: 12),
    this.spacing = 40.0,
    this.textSpacing = 4.0,
    this.animated = true,
    this.dashPattern,
    this.strokeCap = StrokeCap.round,
  });
}

class NoteStyle {
  final double width;
  final double height;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final TextStyle textStyle;
  final double padding;
  final double cornerRadius;
  final List<BoxShadow>? shadows;

  const NoteStyle({
    this.width = 120,
    this.height = 60,
    this.backgroundColor = const Color(0xFFFFF9C4),
    this.borderColor = Colors.amber,
    this.borderWidth = 1.0,
    this.textStyle = const TextStyle(fontSize: 12),
    this.padding = 8.0,
    this.cornerRadius = 4.0,
    this.shadows,
  });
}

// 预定义主题
class SequenceDiagramThemes {
  // 亮色主题
  static final light = SequenceDiagramTheme(
    participantStyle: ParticipantStyle(
      borderColor: Colors.blue.shade300,
      shadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    lifelineStyle: LifelineStyle(
      color: Colors.grey.shade300,
      activationColor: Colors.blue.shade100,
    ),
    messageStyle: MessageStyle(
      color: Colors.blue.shade700,
      textStyle: TextStyle(
        fontSize: 12,
        color: Colors.grey.shade700,
      ),
    ),
    noteStyle: NoteStyle(
      textStyle: TextStyle(
        fontSize: 12,
        color: Colors.grey.shade800,
      ),
      shadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ],
    ),
  );

  // 暗色主题
  static final dark = SequenceDiagramTheme(
    backgroundColor: Colors.grey.shade900,
    participantStyle: ParticipantStyle(
      backgroundColor: Colors.grey.shade800,
      borderColor: Colors.blue.shade300,
      textStyle: const TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
      shadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    lifelineStyle: LifelineStyle(
      color: Colors.grey.shade700,
      activationColor: Colors.blue.shade900,
    ),
    messageStyle: MessageStyle(
      color: Colors.blue.shade300,
      textStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white70,
      ),
    ),
    noteStyle: NoteStyle(
      backgroundColor: Colors.grey.shade800,
      borderColor: Colors.amber.shade700,
      textStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white70,
      ),
      shadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
  );
}
