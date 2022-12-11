import 'package:flutter/material.dart';
import 'package:the_sss_store/navigation/app_route.dart';
import 'package:the_sss_store/navigation/routes.dart';
import 'package:the_sss_store/screen/events_menu/events_menu_data.dart';
import 'package:the_sss_store/screen/events_menu/events_menu_view_model.dart';
import 'package:the_sss_store/screen/screen.dart';
import 'package:provider/provider.dart';
import 'package:the_sss_store/screen/event/event_screen.dart';

class EventsMenuScreenRoute extends AppRoute {
  EventsMenuScreenRoute()
      : super(
          path: Routes.eventsMenu,
          builder: (context, state) => EventsMenuScreen(key: state.pageKey),
        );
}

class EventsMenuScreen extends Screen {
  const EventsMenuScreen({Key? key}) : super(key: key);

  @override
  _EventsMenuScreenState createState() => _EventsMenuScreenState();
}

class _EventsMenuScreenState extends ScreenState<EventsMenuScreen, EventsMenuViewModel, EventsMenuData> {
  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),
        actions: [
          SettingsButton(viewModel: viewModel),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          EventList(
            onTap: _onEventButtonTap,
            eventButtonStyle: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.black,
            ),
          ),
          const Center(child: ProgressBar()),
          const EmptyState(),
          EventsMenuPopups(viewModel: viewModel),
        ],
      ),
    );
  }

  void _onEventButtonTap(String name) {
    EventScreenRoute().push(context);
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<EventsMenuData, bool>(
      selector: (_, data) => data.showLoading,
      builder: (context, showLoading, _) => Visibility(
        visible: showLoading,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<EventsMenuData, bool>(
      selector: (_, data) => data.showEmptyState,
      builder: (context, showEmptyState, _) => Visibility(
        visible: showEmptyState,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            'Não foram encontrados Eventos',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({required this.viewModel, Key? key}) : super(key: key);

  final EventsMenuViewModel viewModel;

  void _onAddEventButtonTap() {
    viewModel.showCreateEventPopup();
  }

  void _onRemoveEventButtonTap() {
    viewModel.showRemoveEventPopup();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: CreateEventSettingsButton(onTap: () {
              _onAddEventButtonTap();
              Navigator.pop(context);
            }),
          ),
          PopupMenuItem(
            child: RemoveEventSettingsButton(onTap: () {
              _onRemoveEventButtonTap();
              Navigator.pop(context);
            }),
          ),
        ];
      },
    );
  }
}

class CreateEventSettingsButton extends StatelessWidget {
  const CreateEventSettingsButton({
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
      child: const Text("Criar evento"),
      onPressed: () {
        onTap();
      },
    );
  }
}

class RemoveEventSettingsButton extends StatelessWidget {
  const RemoveEventSettingsButton({
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
      child: const Text("Remover evento"),
      onPressed: () {
        onTap();
      },
    );
  }
}

class EventList extends StatelessWidget {
  const EventList({
    required this.onTap,
    this.eventButtonStyle,
    Key? key,
  }) : super(key: key);

  final Function(String) onTap;
  final ButtonStyle? eventButtonStyle;

  @override
  Widget build(BuildContext context) {
    return Selector<EventsMenuData, List<EventButtonData>>(
      selector: (_, data) => data.eventButtonData,
      builder: (context, eventButtonData, _) {
        return ListView.separated(
          itemBuilder: (context, index) {
            final data = eventButtonData[index];
            return EventButton(
              name: data.name,
              buttonStyle: eventButtonStyle,
              onTap: onTap,
            );
          },
          separatorBuilder: (_, __) {
            return const Divider();
          },
          itemCount: eventButtonData.length,
        );
      },
    );
  }
}

class EventButton extends StatelessWidget {
  const EventButton({
    Key? key,
    required this.name,
    this.buttonStyle,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final ButtonStyle? buttonStyle;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextButton(
          style: buttonStyle,
          child: Text(name),
          onPressed: () {
            onTap(name);
          }),
    );
  }
}

class EventsMenuPopups extends StatelessWidget {
  const EventsMenuPopups({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final EventsMenuViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CreateEventPopup(viewModel: viewModel),
        RemoveEventPopup(viewModel: viewModel),
      ],
    );
  }
}

class CreateEventPopup extends StatelessWidget {
  CreateEventPopup({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final EventsMenuViewModel viewModel;
  final TextEditingController nameController = TextEditingController();

  Future<void> _confirmButtonTap() async {
    bool isCreated = await viewModel.createEvent(nameController.text);

    if (isCreated) {
      nameController.text = "";
      viewModel.hidePopup();
    }
  }

  void _cancelButtonTap() {
    nameController.text = "";
    viewModel.hidePopup();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<EventsMenuData, bool>(
      selector: (_, data) => data.showCreateEventPopup,
      builder: (context, showAddEventPopup, _) => Visibility(
        visible: showAddEventPopup,
        child: AlertDialog(
          title: const Text('Adicionar Evento'),
          content: SizedBox(
            height: 130,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome do Evento',
                    ),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      child: const Text('Confirmar'),
                      onPressed: _confirmButtonTap,
                    ),
                    TextButton(
                      child: const Text('Cancelar'),
                      onPressed: _cancelButtonTap,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RemoveEventPopup extends StatelessWidget {
  RemoveEventPopup({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final EventsMenuViewModel viewModel;
  final ValueNotifier<String> eventNameNotifier = ValueNotifier<String>("");

  Future<void> _confirmButtonTap() async {
    bool isRemoved = await viewModel.removeEvent(eventNameNotifier.value);

    if (isRemoved) {
      viewModel.hidePopup();
      resetParameters();
    }
  }

  void _cancelButtonTap() {
    viewModel.hidePopup();
    resetParameters();
  }

  void _selectedEvent(String name) {
    eventNameNotifier.value = name;
  }

  void resetParameters() {
    eventNameNotifier.value = "";
  }

  Widget _removeLabelName() {
    return AnimatedBuilder(
      animation: eventNameNotifier,
      builder: (BuildContext context, Widget? child) {
        return Text(
          "Remover evento - " "${eventNameNotifier.value}",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.blue),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Selector<EventsMenuData, bool>(
      selector: (_, data) => data.showRemoveEventPopup,
      builder: (context, showRemoveEventPopup, _) => Visibility(
        visible: showRemoveEventPopup,
        child: AlertDialog(
          title: const Text('Remover Evento'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  height: 300.0,
                  width: 300.0,
                  child: EventList(
                    onTap: _selectedEvent,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _removeLabelName(),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Confirmar'),
              onPressed: _confirmButtonTap,
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: _cancelButtonTap,
            ),
          ],
        ),
      ),
    );
  }
}
