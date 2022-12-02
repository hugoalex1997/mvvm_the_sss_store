import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:the_sss_store/model/storage.dart';


class StorageButtonData extends Equatable {
  const StorageButtonData({
    required this.name,
  });

  StorageButtonData.fromStorage(Storage storage)
      : name = storage.name;

  final String name;

  @override
  List<Object?> get props => [name];

  StorageButtonData copyWith({
    String? name,
  }) {
    return StorageButtonData(
      name: name ?? this.name,
    );
  }
}

class StorageText extends StatelessWidget {
  const StorageText({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

@override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Text("Armazém - " "$name"),
      );
  }
}
