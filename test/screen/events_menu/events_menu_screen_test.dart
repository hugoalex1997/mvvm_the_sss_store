import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:the_sss_store/screen/events_menu/events_menu_screen.dart';
import 'package:the_sss_store/screen/events_menu/events_menu_data.dart';
import 'package:the_sss_store/screen/events_menu/events_menu_view_model.dart';
import 'package:the_sss_store/inject/dependency_injection.dart';
import 'package:the_sss_store/common/data/popup_data.dart';
import 'package:the_sss_store/common/widgets/error_popup_label.dart';
import 'package:the_sss_store/common/widgets/popup.dart';

import '../events_menu/events_menu_screen_test.mocks.dart';

@GenerateMocks([EventsMenuViewModel])
void main() {
  initializeGetIt();

  group('Test Progress Bar Widget', () {
    Widget createProgressBar(EventsMenuViewModel viewModel) {
      return MultiProvider(
        providers: [
          ValueListenableProvider<EventsMenuData>.value(value: viewModel),
        ],
        builder: (context, _) => const ProgressBar(),
      );
    }

    testWidgets('Progress Bar should appear', (WidgetTester tester) async {
      MockEventsMenuViewModel viewModel = MockEventsMenuViewModel();
      when(viewModel.value).thenReturn(EventsMenuData(
          eventButtonData: const [],
          showEmptyState: false,
          showLoading: true,
          createEventPopup: CreateEventPopupData.initial(),
          removeEventPopup: const PopupData.initial()));

      await tester.pumpWidget(createProgressBar(viewModel));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    testWidgets('Progress Bar should not appear', (WidgetTester tester) async {
      MockEventsMenuViewModel viewModel = MockEventsMenuViewModel();
      when(viewModel.value).thenReturn(EventsMenuData.initial());
      await tester.pumpWidget(createProgressBar(viewModel));

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });

  group('Test Empty State Widget', () {
    Widget createEmptyState(EventsMenuViewModel viewModel) {
      return MultiProvider(
        providers: [
          ValueListenableProvider<EventsMenuData>.value(value: viewModel),
        ],
        builder: (context, _) => const EmptyState(),
      );
    }

    testWidgets('Empty State Widget should appear',
        (WidgetTester tester) async {
      MockEventsMenuViewModel viewModel = MockEventsMenuViewModel();
      when(viewModel.value).thenReturn(EventsMenuData(
          eventButtonData: const [],
          showEmptyState: true,
          showLoading: false,
          createEventPopup: CreateEventPopupData.initial(),
          removeEventPopup: const PopupData.initial()));

      await tester.pumpWidget(MaterialApp(home: createEmptyState(viewModel)));

      expect(find.byType(Padding), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text('Não foram encontrados Eventos'), findsOneWidget);
    });

    testWidgets('Empty State Widget should not appear',
        (WidgetTester tester) async {
      MockEventsMenuViewModel viewModel = MockEventsMenuViewModel();
      when(viewModel.value).thenReturn(EventsMenuData.initial());

      await tester.pumpWidget(createEmptyState(viewModel));

      expect(find.byType(Padding), findsNothing);
      expect(find.byType(Text), findsNothing);
    });
  });

  group('Test Settings Button Widget', () {
    Widget createSettingsButton(EventsMenuViewModel viewModel) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Eventos'),
            actions: [
              SettingsButton(viewModel: viewModel),
            ],
          ),
        ),
      );
    }

    testWidgets('Settings Button is spawned', (WidgetTester tester) async {
      MockEventsMenuViewModel viewModel = MockEventsMenuViewModel();

      await tester.pumpWidget(createSettingsButton(viewModel));
      expect(find.byType(PopupMenuButton), findsOneWidget);
    });

    testWidgets('Settings Button on tap', (WidgetTester tester) async {
      MockEventsMenuViewModel viewModel = MockEventsMenuViewModel();

      await tester.pumpWidget(createSettingsButton(viewModel));
      await tester.tap(find.byType(SettingsButton));
      await tester.pumpAndSettle();

      expect(find.byType(PopupMenuItem), findsNWidgets(2));

      expect(find.byType(CreateEventSettingsButton), findsOneWidget);
      expect(find.byType(RemoveEventSettingsButton), findsOneWidget);

      expect(find.byType(TextButton), findsNWidgets(2));
      expect(find.text("Criar evento"), findsOneWidget);
      expect(find.text("Remover evento"), findsOneWidget);
    });

    testWidgets('Test Create Event Button', (WidgetTester tester) async {
      MockEventsMenuViewModel viewModel = MockEventsMenuViewModel();

      await tester.pumpWidget(createSettingsButton(viewModel));
      await tester.tap(find.byType(SettingsButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CreateEventSettingsButton));
      await tester.pumpAndSettle();

      verify(viewModel.showCreateEventPopup()).called(1);
    });

    testWidgets('Test Remove Event Button', (WidgetTester tester) async {
      MockEventsMenuViewModel viewModel = MockEventsMenuViewModel();

      await tester.pumpWidget(createSettingsButton(viewModel));
      await tester.tap(find.byType(SettingsButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(RemoveEventSettingsButton));
      await tester.pumpAndSettle();

      verify(viewModel.showRemoveEventPopup()).called(1);
    });
  });

  group('Test Event List View', () {
    Widget createEventList(EventsMenuViewModel viewModel) {
      return MultiProvider(
        providers: [
          ValueListenableProvider<EventsMenuData>.value(value: viewModel),
        ],
        builder: (context, _) => EventList(onTap: (_) => ""),
      );
    }

    testWidgets('Display Event Button', (WidgetTester tester) async {
      String eventName = "norte";
      await tester.pumpWidget(
          MaterialApp(home: EventButton(name: eventName, onTap: (_) => {})));

      expect(find.byType(TextButton), findsOneWidget);
      expect(find.text(eventName), findsOneWidget);
    });

    testWidgets('Display Event List Empty', (WidgetTester tester) async {
      MockEventsMenuViewModel viewModel = MockEventsMenuViewModel();

      when(viewModel.value).thenReturn(EventsMenuData.initial());
      await tester.pumpWidget(MaterialApp(home: createEventList(viewModel)));

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(EventButton), findsNothing);
      expect(find.byType(Divider), findsNothing);
    });

    testWidgets('Display Event List with 3 events',
        (WidgetTester tester) async {
      List<EventButtonData> eventButtonDataList = [
        const EventButtonData(name: "event1"),
        const EventButtonData(name: "event2"),
        const EventButtonData(name: "event3")
      ];

      MockEventsMenuViewModel viewModel = MockEventsMenuViewModel();
      when(viewModel.value).thenReturn(EventsMenuData(
          eventButtonData: eventButtonDataList,
          showEmptyState: false,
          showLoading: false,
          createEventPopup: CreateEventPopupData.initial(),
          removeEventPopup: const PopupData.initial()));

      await tester.pumpWidget(MaterialApp(home: createEventList(viewModel)));

      expect(find.byType(EventButton), findsNWidgets(3));
      expect(find.byType(Divider), findsNWidgets(2));
    });
  });

  group('Test Events Menu Popups', () {
    testWidgets('Create Event Menu popup holder', (WidgetTester tester) async {
      Widget createEventMenuPopupList(EventsMenuViewModel viewModel) {
        return MultiProvider(
          providers: [
            ValueListenableProvider<EventsMenuData>.value(value: viewModel),
          ],
          builder: (context, _) => EventsMenuPopups(viewModel: viewModel),
        );
      }

      MockEventsMenuViewModel viewModel = MockEventsMenuViewModel();
      when(viewModel.value).thenReturn(EventsMenuData.initial());

      await tester
          .pumpWidget(MaterialApp(home: createEventMenuPopupList(viewModel)));
      expect(find.byType(Stack), findsOneWidget);
      expect(find.byType(CreateEventPopup), findsOneWidget);
      expect(find.byType(RemoveEventPopup), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    });

    group('Test Create Event Popup', () {
      Widget createCreateEventPopup(EventsMenuViewModel viewModel) {
        return MultiProvider(
          providers: [
            ValueListenableProvider<EventsMenuData>.value(value: viewModel),
          ],
          builder: (context, _) => CreateEventPopup(viewModel: viewModel),
        );
      }

      testWidgets('Display Create Event popup', (WidgetTester tester) async {
        MockEventsMenuViewModel viewModel = MockEventsMenuViewModel();
        when(viewModel.value).thenReturn(EventsMenuData(
            eventButtonData: const [],
            showEmptyState: false,
            showLoading: false,
            createEventPopup: CreateEventPopupData.show(),
            removeEventPopup: const PopupData.initial()));

        await tester
            .pumpWidget(MaterialApp(home: createCreateEventPopup(viewModel)));

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.byType(SingleChildScrollView), findsOneWidget);
        expect(find.text('Adicionar Evento'), findsOneWidget);
        expect(find.byType(TextField), findsOneWidget);
        expect(find.text('Nome do Evento'), findsOneWidget);
        expect(find.text('Data de Início: '), findsOneWidget);
        expect(find.text('Data de Fim: '), findsOneWidget);
        expect(find.byType(Row), findsNWidgets(3));
        expect(find.byType(TextButton), findsNWidgets(4));
        expect(find.text('Confirmar'), findsOneWidget);
        expect(find.text('Cancelar'), findsOneWidget);
        expect(find.byType(ErrorPopupLabel), findsOneWidget);
      });

      //TODO: Tests Start Date and End Date Text Update

      // testWidgets('Create Event Popup Start and End Date is updated correctly', (WidgetTester tester) async {
      //   String eventName = "testEvent";
      //   DateTime initialDate = DateTime.utc(2022, 11, 9);
      //   DateTime updatedDate = DateTime.utc(2050, 3, 5);

      //   MockEventsMenuViewModel viewModel = MockEventsMenuViewModel();
      //   when(viewModel.value).thenReturn(EventsMenuData(
      //       eventButtonData: const [],
      //       showEmptyState: false,
      //       showLoading: false,
      //       createEventPopup: CreateEventPopupData.startDate(initialDate),
      //       removeEventPopup: const PopupData.initial()));

      //   when(viewModel.updateStartDate).thenReturn((date) => {
      //         if (date != null)
      //           {
      //             EventsMenuData(
      //                 eventButtonData: const [],
      //                 showEmptyState: false,
      //                 showLoading: false,
      //                 createEventPopup: CreateEventPopupData.startDate(date),
      //                 removeEventPopup: const PopupData.initial())
      //           }
      //       });

      //   await tester.pumpWidget(MaterialApp(home: createCreateEventPopup(viewModel)));

      //   expect(find.text(Utils.dateToString(updatedDate)), findsNothing);

      //   viewModel.updateStartDate(updatedDate);

      //   expect(find.text(Utils.dateToString(updatedDate)), findsOneWidget);
      // });

      testWidgets('Do not display Create Event popup',
          (WidgetTester tester) async {
        MockEventsMenuViewModel viewModel = MockEventsMenuViewModel();
        when(viewModel.value).thenReturn(EventsMenuData(
            eventButtonData: const [],
            showEmptyState: false,
            showLoading: false,
            createEventPopup: CreateEventPopupData.initial(),
            removeEventPopup: const PopupData.initial()));

        await tester
            .pumpWidget(MaterialApp(home: createCreateEventPopup(viewModel)));

        expect(find.byType(AlertDialog), findsNothing);
      });
    });

    group('Test Remove Event Popup', () {
      Widget createRemoveEventPopup(EventsMenuViewModel viewModel) {
        return MultiProvider(
          providers: [
            ValueListenableProvider<EventsMenuData>.value(value: viewModel),
          ],
          builder: (context, _) => RemoveEventPopup(viewModel: viewModel),
        );
      }

      testWidgets('Display Remove Event popup', (WidgetTester tester) async {
        MockEventsMenuViewModel viewModel = MockEventsMenuViewModel();
        when(viewModel.value).thenReturn(EventsMenuData(
            eventButtonData: const [],
            showEmptyState: false,
            showLoading: false,
            createEventPopup: CreateEventPopupData.initial(),
            removeEventPopup: const PopupData.show()));

        await tester
            .pumpWidget(MaterialApp(home: createRemoveEventPopup(viewModel)));

        expect(
            find.byType(Selector<EventsMenuData, PopupData>), findsOneWidget);
        expect(find.byType(Popup), findsOneWidget);
        expect(find.text('Remover Evento'), findsOneWidget);
        expect(find.byType(EventList), findsOneWidget);
      });

      testWidgets('Do not display Remove Event popup',
          (WidgetTester tester) async {
        MockEventsMenuViewModel viewModel = MockEventsMenuViewModel();
        when(viewModel.value).thenReturn(EventsMenuData(
            eventButtonData: const [],
            showEmptyState: false,
            showLoading: false,
            createEventPopup: CreateEventPopupData.initial(),
            removeEventPopup: const PopupData.initial()));

        await tester
            .pumpWidget(MaterialApp(home: createRemoveEventPopup(viewModel)));

        expect(find.byType(Popup), findsNothing);
      });

      testWidgets('Remove Event popup Text is refreshed correctly',
          (WidgetTester tester) async {
        String eventName = "testEvent";
        List<EventButtonData> eventButtonDataList = [
          EventButtonData(name: eventName),
        ];

        MockEventsMenuViewModel viewModel = MockEventsMenuViewModel();
        when(viewModel.value).thenReturn(EventsMenuData(
            eventButtonData: eventButtonDataList,
            showEmptyState: false,
            showLoading: false,
            createEventPopup: CreateEventPopupData.initial(),
            removeEventPopup: const PopupData.show()));

        await tester
            .pumpWidget(MaterialApp(home: createRemoveEventPopup(viewModel)));

        expect(find.text("Remover evento - "), findsOneWidget);

        await tester.tap(find.byType(EventButton));
        await tester.pumpAndSettle();

        expect(find.text("Remover evento - " "$eventName"), findsOneWidget);
      });
    });
  });
}
