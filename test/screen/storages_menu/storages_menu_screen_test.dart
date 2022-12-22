import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_sss_store/common/data/popup_data.dart';

import 'package:the_sss_store/screen/storages_menu/storages_menu_screen.dart';
import 'package:the_sss_store/screen/storages_menu/storages_menu_data.dart';
import 'package:the_sss_store/screen/storages_menu/storages_menu_view_model.dart';
import 'package:the_sss_store/inject/dependency_injection.dart';
import 'package:the_sss_store/common/widgets/popup.dart';

import 'storages_menu_screen_test.mocks.dart';

@GenerateMocks([StoragesMenuViewModel])
void main() {
  initializeGetIt();

  group('Test Progress Bar Widget', () {
    Widget createProgressBar(StoragesMenuViewModel viewModel) {
      return MultiProvider(
        providers: [
          ValueListenableProvider<StoragesMenuData>.value(value: viewModel),
        ],
        builder: (context, _) => const ProgressBar(),
      );
    }

    testWidgets('Progress Bar should appear', (WidgetTester tester) async {
      MockStoragesMenuViewModel viewModel = MockStoragesMenuViewModel();
      when(viewModel.value).thenReturn(const StoragesMenuData(
          storageButtonData: [],
          showEmptyState: false,
          showLoading: true,
          createStoragePopup: PopupData.initial(),
          removeStoragePopup: PopupData.initial()));

      await tester.pumpWidget(createProgressBar(viewModel));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    testWidgets('Progress Bar should not appear', (WidgetTester tester) async {
      MockStoragesMenuViewModel viewModel = MockStoragesMenuViewModel();
      when(viewModel.value).thenReturn(const StoragesMenuData.initial());
      await tester.pumpWidget(createProgressBar(viewModel));

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });

  group('Test Empty State Widget', () {
    Widget createEmptyState(StoragesMenuViewModel viewModel) {
      return MultiProvider(
        providers: [
          ValueListenableProvider<StoragesMenuData>.value(value: viewModel),
        ],
        builder: (context, _) => const EmptyState(),
      );
    }

    testWidgets('Empty State Widget should appear',
        (WidgetTester tester) async {
      MockStoragesMenuViewModel viewModel = MockStoragesMenuViewModel();
      when(viewModel.value).thenReturn(const StoragesMenuData(
          storageButtonData: [],
          showEmptyState: true,
          showLoading: false,
          createStoragePopup: PopupData.initial(),
          removeStoragePopup: PopupData.initial()));

      await tester.pumpWidget(MaterialApp(home: createEmptyState(viewModel)));

      expect(find.byType(Padding), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text('Não foram encontrados Armazéns'), findsOneWidget);
    });

    testWidgets('Empty State Widget should not appear',
        (WidgetTester tester) async {
      MockStoragesMenuViewModel viewModel = MockStoragesMenuViewModel();
      when(viewModel.value).thenReturn(const StoragesMenuData.initial());

      await tester.pumpWidget(createEmptyState(viewModel));

      expect(find.byType(Padding), findsNothing);
      expect(find.byType(Text), findsNothing);
    });
  });

  group('Test Settings Button Widget', () {
    Widget createSettingsButton(StoragesMenuViewModel viewModel) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Armazéns'),
            actions: [
              SettingsButton(viewModel: viewModel),
            ],
          ),
        ),
      );
    }

    testWidgets('Settings Button is spawned', (WidgetTester tester) async {
      MockStoragesMenuViewModel viewModel = MockStoragesMenuViewModel();

      await tester.pumpWidget(createSettingsButton(viewModel));
      expect(find.byType(PopupMenuButton), findsOneWidget);
    });

    testWidgets('Settings Button on tap', (WidgetTester tester) async {
      MockStoragesMenuViewModel viewModel = MockStoragesMenuViewModel();

      await tester.pumpWidget(createSettingsButton(viewModel));
      await tester.tap(find.byType(SettingsButton));
      await tester.pumpAndSettle();

      expect(find.byType(PopupMenuItem), findsNWidgets(2));

      expect(find.byType(CreateStorageSettingsButton), findsOneWidget);
      expect(find.byType(RemoveStorageSettingsButton), findsOneWidget);

      expect(find.byType(TextButton), findsNWidgets(2));
      expect(find.text("Criar armazém"), findsOneWidget);
      expect(find.text("Remover armazém"), findsOneWidget);
    });

    testWidgets('Test Create Storage Button', (WidgetTester tester) async {
      MockStoragesMenuViewModel viewModel = MockStoragesMenuViewModel();

      await tester.pumpWidget(createSettingsButton(viewModel));
      await tester.tap(find.byType(SettingsButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CreateStorageSettingsButton));
      await tester.pumpAndSettle();

      verify(viewModel.showCreateStoragePopup()).called(1);
    });

    testWidgets('Test Remove Storage Button', (WidgetTester tester) async {
      MockStoragesMenuViewModel viewModel = MockStoragesMenuViewModel();

      await tester.pumpWidget(createSettingsButton(viewModel));
      await tester.tap(find.byType(SettingsButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(RemoveStorageSettingsButton));
      await tester.pumpAndSettle();

      verify(viewModel.showRemoveStoragePopup()).called(1);
    });
  });

  group('Test Storage List View', () {
    Widget createStorageList(StoragesMenuViewModel viewModel) {
      return MultiProvider(
        providers: [
          ValueListenableProvider<StoragesMenuData>.value(value: viewModel),
        ],
        builder: (context, _) => StorageList(onTap: (_) => ""),
      );
    }

    testWidgets('Display Storage Button', (WidgetTester tester) async {
      String storageName = "norte";
      await tester.pumpWidget(MaterialApp(
          home: StorageButton(name: storageName, onTap: (_) => {})));

      expect(find.byType(TextButton), findsOneWidget);
      expect(find.text(storageName), findsOneWidget);
    });

    testWidgets('Display Storage List Empty', (WidgetTester tester) async {
      MockStoragesMenuViewModel viewModel = MockStoragesMenuViewModel();

      when(viewModel.value).thenReturn(const StoragesMenuData.initial());
      await tester.pumpWidget(MaterialApp(home: createStorageList(viewModel)));

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(StorageButton), findsNothing);
      expect(find.byType(Divider), findsNothing);
    });

    testWidgets('Display Storage List with 3 storages',
        (WidgetTester tester) async {
      List<StorageButtonData> storageButtonDataList = [
        const StorageButtonData(name: "storage1"),
        const StorageButtonData(name: "storage2"),
        const StorageButtonData(name: "storage3")
      ];

      MockStoragesMenuViewModel viewModel = MockStoragesMenuViewModel();
      when(viewModel.value).thenReturn(StoragesMenuData(
          storageButtonData: storageButtonDataList,
          showEmptyState: false,
          showLoading: false,
          createStoragePopup: const PopupData.initial(),
          removeStoragePopup: const PopupData.initial()));

      await tester.pumpWidget(MaterialApp(home: createStorageList(viewModel)));

      expect(find.byType(StorageButton), findsNWidgets(3));
      expect(find.byType(Divider), findsNWidgets(2));
    });
  });

  group('Test Storages Menu Popups', () {
    testWidgets('Create Storage Menu popup holder',
        (WidgetTester tester) async {
      Widget createStoragesMenuPopupsList(StoragesMenuViewModel viewModel) {
        return MultiProvider(
          providers: [
            ValueListenableProvider<StoragesMenuData>.value(value: viewModel),
          ],
          builder: (context, _) => StoragesMenuPopups(viewModel: viewModel),
        );
      }

      MockStoragesMenuViewModel viewModel = MockStoragesMenuViewModel();
      when(viewModel.value).thenReturn(const StoragesMenuData.initial());

      await tester.pumpWidget(
          MaterialApp(home: createStoragesMenuPopupsList(viewModel)));
      expect(find.byType(Stack), findsOneWidget);
      expect(find.byType(CreateStoragePopup), findsOneWidget);
      expect(find.byType(RemoveStoragePopup), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    });

    group('Test Create Storage Popup', () {
      Widget createCreateStoragePopup(StoragesMenuViewModel viewModel) {
        return MultiProvider(
          providers: [
            ValueListenableProvider<StoragesMenuData>.value(value: viewModel),
          ],
          builder: (context, _) => CreateStoragePopup(viewModel: viewModel),
        );
      }

      testWidgets('Display Create Storage popup', (WidgetTester tester) async {
        MockStoragesMenuViewModel viewModel = MockStoragesMenuViewModel();
        when(viewModel.value).thenReturn(const StoragesMenuData(
            storageButtonData: [],
            showEmptyState: false,
            showLoading: false,
            createStoragePopup: PopupData.show(),
            removeStoragePopup: PopupData.initial()));

        await tester
            .pumpWidget(MaterialApp(home: createCreateStoragePopup(viewModel)));

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.byType(SingleChildScrollView), findsOneWidget);
        expect(find.byType(Container), findsOneWidget);
        expect(find.text('Adicionar Armazém'), findsOneWidget);
        expect(find.byType(TextField), findsOneWidget);
        expect(find.text('Nome do Armazém'), findsOneWidget);
        expect(find.byType(Row), findsOneWidget);
        expect(find.byType(TextButton), findsNWidgets(2));
        expect(find.text('Confirmar'), findsOneWidget);
        expect(find.text('Cancelar'), findsOneWidget);
      });

      testWidgets('Do not display Create Storage popup',
          (WidgetTester tester) async {
        MockStoragesMenuViewModel viewModel = MockStoragesMenuViewModel();
        when(viewModel.value).thenReturn(const StoragesMenuData(
            storageButtonData: [],
            showEmptyState: false,
            showLoading: false,
            createStoragePopup: PopupData.initial(),
            removeStoragePopup: PopupData.initial()));

        await tester
            .pumpWidget(MaterialApp(home: createCreateStoragePopup(viewModel)));

        expect(find.byType(AlertDialog), findsNothing);
      });
    });

    group('Test Remove Storage Popup', () {
      Widget createRemoveStoragePopup(StoragesMenuViewModel viewModel) {
        return MultiProvider(
          providers: [
            ValueListenableProvider<StoragesMenuData>.value(value: viewModel),
          ],
          builder: (context, _) => RemoveStoragePopup(viewModel: viewModel),
        );
      }

      testWidgets('Display Remove Storage popup', (WidgetTester tester) async {
        MockStoragesMenuViewModel viewModel = MockStoragesMenuViewModel();
        when(viewModel.value).thenReturn(const StoragesMenuData(
            storageButtonData: [],
            showEmptyState: false,
            showLoading: false,
            createStoragePopup: PopupData.initial(),
            removeStoragePopup: PopupData.show()));

        await tester
            .pumpWidget(MaterialApp(home: createRemoveStoragePopup(viewModel)));

        expect(
            find.byType(Selector<StoragesMenuData, PopupData>), findsOneWidget);
        expect(find.byType(Popup), findsOneWidget);
        expect(find.text('Remover Armazém'), findsOneWidget);
        expect(find.byType(StorageList), findsOneWidget);
      });

      testWidgets('Do not display Remove Storage popup',
          (WidgetTester tester) async {
        MockStoragesMenuViewModel viewModel = MockStoragesMenuViewModel();
        when(viewModel.value).thenReturn(const StoragesMenuData(
            storageButtonData: [],
            showEmptyState: false,
            showLoading: false,
            createStoragePopup: PopupData.initial(),
            removeStoragePopup: PopupData.initial()));

        await tester
            .pumpWidget(MaterialApp(home: createRemoveStoragePopup(viewModel)));

        expect(find.byType(Popup), findsNothing);
      });

      testWidgets('Remove Storage popup Text is refreshed correctly',
          (WidgetTester tester) async {
        String storageName = "testStorage";
        List<StorageButtonData> storageButtonDataList = [
          StorageButtonData(name: storageName),
        ];

        MockStoragesMenuViewModel viewModel = MockStoragesMenuViewModel();
        when(viewModel.value).thenReturn(StoragesMenuData(
            storageButtonData: storageButtonDataList,
            showEmptyState: false,
            showLoading: false,
            createStoragePopup: const PopupData.initial(),
            removeStoragePopup: const PopupData.show()));

        await tester
            .pumpWidget(MaterialApp(home: createRemoveStoragePopup(viewModel)));

        expect(find.text("Remover armazém - "), findsOneWidget);

        await tester.tap(find.byType(StorageButton));
        await tester.pumpAndSettle();

        expect(find.text("Remover armazém - " "$storageName"), findsOneWidget);
      });
    });
  });
}
