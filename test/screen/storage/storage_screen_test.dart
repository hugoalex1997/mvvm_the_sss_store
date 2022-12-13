import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:the_sss_store/screen/storage/storage_screen.dart';
import 'package:the_sss_store/screen/storage/storage_data.dart';
import 'package:the_sss_store/screen/storage/storage_view_model.dart';
import 'package:the_sss_store/inject/dependency_injection.dart';
import 'package:the_sss_store/common/data/popup_data.dart';

import 'storage_screen_test.mocks.dart';

@GenerateMocks([StorageViewModel])
void main() {
  initializeGetIt();

  group('Test Progress Bar Widget', () {
    Widget createProgressBar(StorageViewModel viewModel) {
      return MultiProvider(
        providers: [
          ValueListenableProvider<StorageData>.value(value: viewModel),
        ],
        builder: (context, _) => const ProgressBar(),
      );
    }

    testWidgets('Progress Bar should appear', (WidgetTester tester) async {
      MockStorageViewModel viewModel = MockStorageViewModel();
      when(viewModel.value).thenReturn(const StorageData(
          name: "",
          itemData: [],
          showEmptyState: false,
          showLoading: true,
          showAddItemPopup: PopupData.initial(),
          showRemoveItemPopup: PopupData.initial()));

      await tester.pumpWidget(createProgressBar(viewModel));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    testWidgets('Progress Bar should not appear', (WidgetTester tester) async {
      MockStorageViewModel viewModel = MockStorageViewModel();
      when(viewModel.value).thenReturn(const StorageData.initial());
      await tester.pumpWidget(createProgressBar(viewModel));

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });

  group('Test Empty State Widget', () {
    Widget createEmptyState(StorageViewModel viewModel) {
      return MultiProvider(
        providers: [
          ValueListenableProvider<StorageData>.value(value: viewModel),
        ],
        builder: (context, _) => const EmptyState(),
      );
    }

    testWidgets('Empty State Widget should appear',
        (WidgetTester tester) async {
      MockStorageViewModel viewModel = MockStorageViewModel();
      when(viewModel.value).thenReturn(const StorageData(
          name: "",
          itemData: [],
          showEmptyState: true,
          showLoading: true,
          showAddItemPopup: PopupData.initial(),
          showRemoveItemPopup: PopupData.initial()));

      await tester.pumpWidget(MaterialApp(home: createEmptyState(viewModel)));

      expect(find.byType(Padding), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text('Não foi possível carregar o stock do armazém'),
          findsOneWidget);
    });

    testWidgets('Empty State Widget should not appear',
        (WidgetTester tester) async {
      MockStorageViewModel viewModel = MockStorageViewModel();
      when(viewModel.value).thenReturn(const StorageData.initial());

      await tester.pumpWidget(createEmptyState(viewModel));

      expect(find.byType(Padding), findsNothing);
      expect(find.byType(Text), findsNothing);
    });
  });

  group('Test Settings Button Widget', () {
    Widget createSettingsButton(StorageViewModel viewModel) {
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
      MockStorageViewModel viewModel = MockStorageViewModel();

      await tester.pumpWidget(createSettingsButton(viewModel));
      expect(find.byType(PopupMenuButton), findsOneWidget);
    });

    testWidgets('Settings Button on tap', (WidgetTester tester) async {
      MockStorageViewModel viewModel = MockStorageViewModel();

      await tester.pumpWidget(createSettingsButton(viewModel));
      await tester.tap(find.byType(SettingsButton));
      await tester.pumpAndSettle();

      expect(find.byType(PopupMenuItem), findsNWidgets(2));

      expect(find.byType(AddItemSettingsButton), findsOneWidget);
      expect(find.byType(RemoveItemSettingsButton), findsOneWidget);

      expect(find.byType(TextButton), findsNWidgets(2));
      expect(find.text("Adicionar item"), findsOneWidget);
      expect(find.text("Remover item"), findsOneWidget);
    });

    testWidgets('Test Add Item Button', (WidgetTester tester) async {
      MockStorageViewModel viewModel = MockStorageViewModel();

      await tester.pumpWidget(createSettingsButton(viewModel));
      await tester.tap(find.byType(SettingsButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(AddItemSettingsButton));
      await tester.pumpAndSettle();

      verify(viewModel.showAddItemPopup()).called(1);
    });

    testWidgets('Test Remove Item Button', (WidgetTester tester) async {
      MockStorageViewModel viewModel = MockStorageViewModel();

      await tester.pumpWidget(createSettingsButton(viewModel));
      await tester.tap(find.byType(SettingsButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(RemoveItemSettingsButton));
      await tester.pumpAndSettle();

      verify(viewModel.showRemoveItemPopup()).called(1);
    });
  });

  group('Test Item List View', () {
    Widget createItemList(StorageViewModel viewModel) {
      return MultiProvider(
        providers: [
          ValueListenableProvider<StorageData>.value(value: viewModel),
        ],
        builder: (context, _) => ItemList(onTap: (_) => ""),
      );
    }

    testWidgets('Display Item Button', (WidgetTester tester) async {
      String itemName = "norte";
      int available = 25;
      int stock = 30;
      await tester.pumpWidget(MaterialApp(
          home: ItemButton(
              name: itemName,
              available: available,
              stock: stock,
              onTap: (_) => {})));

      expect(find.byType(TextButton), findsOneWidget);
      expect(
          find.text("$itemName"
              " - "
              "Available: "
              "$available"
              " | "
              " Stock: "
              "$stock"),
          findsOneWidget);
    });

    testWidgets('Display Item List Empty', (WidgetTester tester) async {
      MockStorageViewModel viewModel = MockStorageViewModel();

      when(viewModel.value).thenReturn(const StorageData.initial());
      await tester.pumpWidget(MaterialApp(home: createItemList(viewModel)));

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ItemButton), findsNothing);
      expect(find.byType(Divider), findsNothing);
    });

    testWidgets('Display Item List with 3 Items', (WidgetTester tester) async {
      List<ItemData> itemDataList = [
        const ItemData(name: "item1", available: 20, stock: 30),
        const ItemData(name: "item2", available: 10, stock: 10),
        const ItemData(name: "item3", available: 4, stock: 5),
      ];

      MockStorageViewModel viewModel = MockStorageViewModel();
      when(viewModel.value).thenReturn(StorageData(
          name: "",
          itemData: itemDataList,
          showEmptyState: false,
          showLoading: false,
          showAddItemPopup: const PopupData.initial(),
          showRemoveItemPopup: const PopupData.initial()));

      await tester.pumpWidget(MaterialApp(home: createItemList(viewModel)));

      expect(find.byType(ItemButton), findsNWidgets(3));
      expect(find.byType(Divider), findsNWidgets(2));
    });
  });

  group('Test Storage Popups', () {
    testWidgets('Create Storage popup holder', (WidgetTester tester) async {
      Widget createStoragePopupsList(StorageViewModel viewModel) {
        return MultiProvider(
          providers: [
            ValueListenableProvider<StorageData>.value(value: viewModel),
          ],
          builder: (context, _) => StoragePopups(viewModel: viewModel),
        );
      }

      MockStorageViewModel viewModel = MockStorageViewModel();
      when(viewModel.value).thenReturn(const StorageData.initial());

      await tester
          .pumpWidget(MaterialApp(home: createStoragePopupsList(viewModel)));
      expect(find.byType(Stack), findsOneWidget);
      expect(find.byType(AddItemPopup), findsOneWidget);
      expect(find.byType(RemoveItemPopup), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    });

    group('Test Add  Item Popup', () {
      Widget createAddItemPopup(StorageViewModel viewModel) {
        return MultiProvider(
          providers: [
            ValueListenableProvider<StorageData>.value(value: viewModel),
          ],
          builder: (context, _) => AddItemPopup(viewModel: viewModel),
        );
      }

      testWidgets('Display Add Item popup', (WidgetTester tester) async {
        MockStorageViewModel viewModel = MockStorageViewModel();
        when(viewModel.value).thenReturn(const StorageData(
            name: "",
            itemData: [],
            showEmptyState: false,
            showLoading: false,
            showAddItemPopup: PopupData.show(),
            showRemoveItemPopup: PopupData.initial()));

        await tester
            .pumpWidget(MaterialApp(home: createAddItemPopup(viewModel)));

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.byType(SingleChildScrollView), findsOneWidget);
        expect(find.text('Adicionar Item'), findsOneWidget);
        expect(find.byType(TextField), findsNWidgets(2));
        expect(find.text('Nome do Item'), findsOneWidget);
        expect(find.text('Stock Total'), findsOneWidget);
        expect(find.byType(Row), findsOneWidget);
        expect(find.byType(TextButton), findsNWidgets(2));
        expect(find.text('Confirmar'), findsOneWidget);
        expect(find.text('Cancelar'), findsOneWidget);
      });

      testWidgets('Do not display add item popup', (WidgetTester tester) async {
        MockStorageViewModel viewModel = MockStorageViewModel();
        when(viewModel.value).thenReturn(const StorageData(
            name: "",
            itemData: [],
            showEmptyState: false,
            showLoading: false,
            showAddItemPopup: PopupData.initial(),
            showRemoveItemPopup: PopupData.initial()));

        await tester
            .pumpWidget(MaterialApp(home: createAddItemPopup(viewModel)));

        expect(find.byType(AlertDialog), findsNothing);
      });
    });

    group('Test Remove item popup', () {
      Widget createRemoveItemPopup(StorageViewModel viewModel) {
        return MultiProvider(
          providers: [
            ValueListenableProvider<StorageData>.value(value: viewModel),
          ],
          builder: (context, _) => RemoveItemPopup(viewModel: viewModel),
        );
      }

      testWidgets('Display remove item popup', (WidgetTester tester) async {
        MockStorageViewModel viewModel = MockStorageViewModel();
        when(viewModel.value).thenReturn(const StorageData(
            name: "",
            itemData: [],
            showEmptyState: false,
            showLoading: false,
            showAddItemPopup: PopupData.initial(),
            showRemoveItemPopup: PopupData.show()));

        await tester
            .pumpWidget(MaterialApp(home: createRemoveItemPopup(viewModel)));

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Remover Item'), findsOneWidget);
        expect(find.byType(SingleChildScrollView), findsOneWidget);
        expect(find.byType(ListBody), findsOneWidget);
        expect(find.byType(ItemList), findsOneWidget);
        expect(find.byType(TextButton), findsNWidgets(2));
        expect(find.text('Confirmar'), findsOneWidget);
        expect(find.text('Cancelar'), findsOneWidget);
      });

      testWidgets('Do not display remove item popup',
          (WidgetTester tester) async {
        MockStorageViewModel viewModel = MockStorageViewModel();
        when(viewModel.value).thenReturn(const StorageData(
            name: "",
            itemData: [],
            showEmptyState: false,
            showLoading: false,
            showAddItemPopup: PopupData.initial(),
            showRemoveItemPopup: PopupData.initial()));

        await tester
            .pumpWidget(MaterialApp(home: createRemoveItemPopup(viewModel)));

        expect(find.byType(AlertDialog), findsNothing);
      });

      testWidgets('Remove item popup Text is refreshed correctly',
          (WidgetTester tester) async {
        String itemName = "test_item";
        int stock = 30;
        List<ItemData> itemDataList = [
          ItemData(name: itemName, available: stock, stock: stock),
        ];

        MockStorageViewModel viewModel = MockStorageViewModel();
        when(viewModel.value).thenReturn(StorageData(
            name: "",
            itemData: itemDataList,
            showEmptyState: false,
            showLoading: false,
            showAddItemPopup: const PopupData.initial(),
            showRemoveItemPopup: const PopupData.show()));

        await tester
            .pumpWidget(MaterialApp(home: createRemoveItemPopup(viewModel)));

        expect(find.text("Remover item - "), findsOneWidget);

        await tester.tap(find.byType(ItemButton));
        await tester.pumpAndSettle();

        expect(find.text("Remover item - " "$itemName"), findsOneWidget);
      });
    });
  });
}
