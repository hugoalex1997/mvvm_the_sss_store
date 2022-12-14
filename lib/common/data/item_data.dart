import 'package:equatable/equatable.dart';
import 'package:the_sss_store/model/item.dart';

class ItemData extends Equatable {
  const ItemData({
    required this.name,
    required this.available,
    required this.stock,
  });

  ItemData.fromItem(Item item)
      : name = item.name,
        available = item.available,
        stock = item.stock;

  final String name;
  final int available;
  final int stock;

  @override
  List<Object?> get props => [name, available, stock];

  ItemData copyWith({
    String? name,
    int? available,
    int? stock,
  }) {
    return ItemData(
      name: name ?? this.name,
      available: available ?? this.available,
      stock: stock ?? this.stock,
    );
  }
}
