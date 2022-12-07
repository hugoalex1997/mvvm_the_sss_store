import 'package:equatable/equatable.dart';

class Event extends Equatable {
  const Event({
    required this.name,
    required this.documentID,
  });

  final String name;
  final String documentID;

  @override
  List<Object?> get props => [
        name,
        documentID,
      ];

  Event copyWith({
    String? name,
    String? documentID,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Event(
      name: name ?? this.name,
      documentID: documentID ?? this.documentID,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'documentID': documentID,
    };
  }

  static Event fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'],
      documentID: json['documentID'],
    );
  }
}
