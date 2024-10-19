import 'package:dish_creator/resource/textResources.dart';
import 'package:dish_creator/view/accountPage.dart';
import 'package:dish_creator/view/dishCreatePage.dart';
import 'package:dish_creator/view/dishCreaterPage/genrePage.dart';
import 'package:dish_creator/view/shoppingListPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFf5f5f5),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF19ac19),
          onPrimary: Colors.white,
          secondary: Color(0xFFff0068),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.transparent,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // BottomNavigationBarで選択中のアイテムindex
  int _currentIndex = 0;

  // 画面ごとのwidget
  final List<Widget> _pages = [
    ShoppingListPage(),
    DishCreaterPage(),
    AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedFontSize: 12,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: (selectedIndex) => setState(() {
          _currentIndex = selectedIndex;
        }),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: TextResources.shoppingListPageTitle),
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant),
              label: TextResources.dishCreatePageTitle),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: TextResources.accountPageTitle),
        ],
      ),
    );
  }
}
