import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:the_sss_store/navigation/app_route.dart';
import 'package:the_sss_store/navigation/routes.dart';
import 'package:the_sss_store/screen/event/event_data.dart';
import 'package:the_sss_store/screen/event/event_view_model.dart';
import 'package:the_sss_store/screen/screen.dart';

class EventScreenRoute extends AppRoute {
  EventScreenRoute()
      : super(
            path: Routes.event,
            builder: (context, state) {
              Map<String, String> params = state.extra as Map<String, String>;
              return EventScreen(
                  documentID: params["documentID"]!, key: state.pageKey);
            });
}

class EventScreen extends Screen {
  const EventScreen({required this.documentID, Key? key}) : super(key: key);

  final String documentID;

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState
    extends ScreenState<EventScreen, EventViewModel, EventData> {
  @override
  void initState() {
    super.initState();
    viewModel.init(widget.documentID);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Selector<EventData, String>(
            selector: (_, data) => data.name,
            builder: (context, name, _) {
              return Text("Evento " "$name");
            }),
        actions: [
          SettingsButton(viewModel: viewModel),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          EventPage(
            viewModel: viewModel,
          ),
          const Center(child: ProgressBar()),
          const EmptyState(),
        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  @visibleForTesting
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<EventData, bool>(
      selector: (_, data) => data.showLoading,
      builder: (context, showLoading, _) => Visibility(
        visible: showLoading,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  @visibleForTesting
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<EventData, bool>(
      selector: (_, data) => data.showEmptyState,
      builder: (context, showEmptyState, _) => Visibility(
        visible: showEmptyState,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            'Não foi possível carregar o stock do armazém',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
    );
  }
}

class EventPage extends StatelessWidget {
  @visibleForTesting
  const EventPage({required this.viewModel, Key? key}) : super(key: key);

  final EventViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 10),
        StartDateText(),
        SizedBox(height: 10),
        EndDateText(),
        SizedBox(height: 10),
      ],
    );
  }
}

class StartDateText extends StatelessWidget {
  @visibleForTesting
  const StartDateText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<EventData, String>(
        selector: (_, data) => data.startDate,
        builder: (context, startDate, _) {
          return Text("Data de início: " "$startDate");
        });
  }
}

class EndDateText extends StatelessWidget {
  @visibleForTesting
  const EndDateText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<EventData, String>(
        selector: (_, data) => data.endDate,
        builder: (context, endDate, _) {
          return Text("Data de fim: " "$endDate");
        });
  }
}

class SettingsButton extends StatelessWidget {
  @visibleForTesting
  const SettingsButton({required this.viewModel, Key? key}) : super(key: key);

  final EventViewModel viewModel;

  void _onChangeEventButtonTap() {
    viewModel.showChangeEventPopup();
  }

  void _onAddItemButtonTap() {
    viewModel.showAddItemPopup();
  }

  void _onRemoveItemButton() {
    viewModel.showRemoveItemPopup();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: ChangeEventSettingsButton(onTap: () {
              _onChangeEventButtonTap();
              Navigator.pop(context);
            }),
          ),
          PopupMenuItem(
            child: AddItemSettingsButton(onTap: () {
              _onAddItemButtonTap();
              Navigator.pop(context);
            }),
          ),
          PopupMenuItem(
            child: RemoveItemSettingsButton(onTap: () {
              _onRemoveItemButton();
              Navigator.pop(context);
            }),
          ),
        ];
      },
    );
  }
}

class ChangeEventSettingsButton extends StatelessWidget {
  @visibleForTesting
  const ChangeEventSettingsButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
      ),
      child: const Text("Alterar Evento"),
      onPressed: () {
        onTap();
      },
    );
  }
}

class AddItemSettingsButton extends StatelessWidget {
  @visibleForTesting
  const AddItemSettingsButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
      ),
      child: const Text("Adicionar item"),
      onPressed: () {
        onTap();
      },
    );
  }
}

class RemoveItemSettingsButton extends StatelessWidget {
  @visibleForTesting
  const RemoveItemSettingsButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
      ),
      child: const Text("Remover item"),
      onPressed: () {
        onTap();
      },
    );
  }
}
