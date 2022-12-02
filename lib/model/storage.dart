import 'package:equatable/equatable.dart';

class Storage extends Equatable {
  const Storage({
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

  Storage copyWith({
    String? name,
    String? documentID,
  }) {
    return Storage(
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

  static Storage fromJson(Map<String, dynamic> json) {
    return Storage(
      name: json['name'],
      documentID: json['documentID'],
    );
  }
}
