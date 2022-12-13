import 'package:equatable/equatable.dart';

class PopupData extends Equatable {
  const PopupData({
    required this.visible,
    required this.error,
  });

  const PopupData.initial()
      : visible = false,
        error = "";

  const PopupData.show()
      : visible = true,
        error = "";

  const PopupData.error(this.error) : visible = true;

  final bool visible;
  final String error;

  @override
  List<Object?> get props => [visible, error];

  PopupData copyWith({
    bool? visible,
    String? error,
  }) {
    return PopupData(
      visible: visible ?? this.visible,
      error: error ?? this.error,
    );
  }
}
