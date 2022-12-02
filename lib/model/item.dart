import 'package:equatable/equatable.dart';

class Item extends Equatable {
  const Item(
      {required this.name,
      required this.documentID,
      required this.available,
      required this.stock});

  final String name;
  final String documentID;
  final int available;
  final int stock;

  @override
  List<Object?> get props => [name, documentID, available, stock];

  Item copyWith(
      {String? name, String? documentID, int? available, int? stock}) {
    return Item(
      name: name ?? this.name,
      documentID: documentID ?? this.documentID,
      available: available ?? this.available,
      stock: stock ?? this.stock,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'documentID': documentID,
      'available': available,
      'stock': stock,
    };
  }

  static Item fromJson(Map<String, dynamic> json) {
    return Item(
        name: json['name'],
        documentID: json['documentID'],
        available: json['available'],
        stock: json['stock']);
  }
}
