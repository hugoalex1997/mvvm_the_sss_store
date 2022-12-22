import 'package:flutter/material.dart';
import 'package:the_sss_store/common/widgets/error_popup_label.dart';

class Popup extends StatelessWidget {
  const Popup({
    required this.confirmButtonTap,
    required this.cancelButtonTap,
    required this.bodyWidget,
    required this.popupSize,
    this.title = "",
    this.errorLabel = "",
    Key? key,
  }) : super(key: key);

  final Function() confirmButtonTap;
  final Function() cancelButtonTap;
  final Widget bodyWidget;
  final double popupSize;
  final String title;
  final String errorLabel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: SizedBox(
          height: popupSize,
          child: Column(
            children: <Widget>[
              bodyWidget,
              const SizedBox(
                height: 10,
              ),
              ErrorPopupLabel(errorText: errorLabel),
              Row(
                children: [
                  ConfirmTextButton(
                    onTap: confirmButtonTap,
                  ),
                  CancelTextButton(
                    onTap: cancelButtonTap,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmTextButton extends StatelessWidget {
  const ConfirmTextButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Confirmar'),
      onPressed: onTap,
    );
  }
}

class CancelTextButton extends StatelessWidget {
  const CancelTextButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Cancelar'),
      onPressed: onTap,
    );
  }
}
