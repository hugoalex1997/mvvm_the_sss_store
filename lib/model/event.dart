import 'package:equatable/equatable.dart';

class Event extends Equatable {
  const Event(
      {required this.name,
      required this.documentID,
      required this.startDate,
      required this.endDate});

  final String name;
  final String documentID;
  final DateTime startDate;
  final DateTime endDate;

  @override
  List<Object?> get props => [name, documentID, startDate, endDate];

  Event copyWith({
    String? name,
    String? documentID,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Event(
        name: name ?? this.name,
        documentID: documentID ?? this.documentID,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'documentID': documentID,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  static Event fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'],
      documentID: json['documentID'],
      startDate: json['startDate'].toDate(),
      endDate: json['endDate'].toDate(),
    );
  }
}
