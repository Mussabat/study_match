import 'package:equatable/equatable.dart';

class Tag extends Equatable {
  const Tag({
    required this.id,
    required this.tag,
    required this.isConnected,
  });

  final String id;
  final String tag;
  final bool isConnected;

  @override
  List<Object?> get props => [
        tag,
        isConnected,
      ];

  Tag copyWith({
    String? tag,
    bool? isConnected,
  }) {
    return Tag(
      id: id,
      tag: tag ?? this.tag,
      isConnected: isConnected ?? this.isConnected,
    );
  }
}
