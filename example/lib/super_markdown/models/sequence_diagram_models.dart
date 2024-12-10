class SequenceDiagram {
  final List<Participant> participants;
  final List<Message> messages;
  final List<Note> notes;

  const SequenceDiagram({
    required this.participants,
    required this.messages,
    required this.notes,
  });

  // 从 Markdown 解析
  factory SequenceDiagram.fromMarkdown(String markdown) {
    final lines = markdown.split('\n');
    final participants = <Participant>[];
    final messages = <Message>[];
    final notes = <Note>[];
    var order = 0;

    for (final line in lines) {
      final trimmed = line.trim();

      // 解析参与者
      if (trimmed.startsWith('participant ')) {
        final parts = trimmed.split(' ');
        if (parts.length >= 2) {
          participants.add(Participant(
            name: parts[1],
            label: parts.length > 2 ? parts.sublist(2).join(' ') : parts[1],
          ));
        }
      }

      // 解析消息
      else if (trimmed.contains('->') || trimmed.contains('-->')) {
        final isAsync = trimmed.contains('-->');
        final parts = trimmed.split(isAsync ? '-->' : '->');
        if (parts.length == 2) {
          final from = parts[0].trim();
          final remaining = parts[1].trim();
          final colonIndex = remaining.indexOf(':');
          if (colonIndex != -1) {
            final to = remaining.substring(0, colonIndex).trim();
            final text = remaining.substring(colonIndex + 1).trim();
            messages.add(Message(
              from: from,
              to: to,
              text: text,
              isAsync: isAsync,
              order: order++,
            ));
          }
        }
      }

      // 解析注释
      else if (trimmed.startsWith('note ')) {
        final parts = trimmed.split(' ');
        if (parts.length >= 4) {
          final position = parts[1]; // over, left of, right of
          final participant = parts[3];
          final text = parts.sublist(4).join(' ');
          String? endParticipant;

          // 处理跨多个参与者的注释
          if (position == 'between' && parts.length >= 6 && parts[4] == 'and') {
            endParticipant = parts[5];
          }

          notes.add(Note(
            text: text,
            participant: participant,
            endParticipant: endParticipant,
            position: NotePosition.values.firstWhere(
              (p) => p.toString().split('.').last == position,
              orElse: () => NotePosition.over,
            ),
            order: order++,
          ));
        }
      }
    }

    return SequenceDiagram(
      participants: participants,
      messages: messages,
      notes: notes,
    );
  }
}

class Participant {
  final String name;
  final String label;
  final String? type;
  final Map<String, dynamic>? properties;

  const Participant({
    required this.name,
    required this.label,
    this.type,
    this.properties,
  });
}

class Message {
  final String from;
  final String to;
  final String text;
  final bool isAsync;
  final int order;
  final String? type;
  final Map<String, dynamic>? properties;

  const Message({
    required this.from,
    required this.to,
    required this.text,
    required this.order,
    this.isAsync = false,
    this.type,
    this.properties,
  });
}

class Note {
  final String text;
  final String participant;
  final String? endParticipant;
  final NotePosition position;
  final int order;
  final Map<String, dynamic>? properties;

  const Note({
    required this.text,
    required this.participant,
    required this.order,
    this.endParticipant,
    this.position = NotePosition.over,
    this.properties,
  });
}

enum NotePosition {
  left,
  right,
  over,
  between,
}
