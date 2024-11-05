import 'package:auto_route/auto_route.dart';
import 'package:dish_creator/resource/textResources.dart';
import 'package:dish_creator/view/accountPage.dart';
import 'package:dish_creator/view/dishCreatePage.dart';
import 'package:dish_creator/view/dishCreaterPage/categoryPage.dart';
import 'package:dish_creator/view/dishCreaterPage/genrePage.dart';
import 'package:dish_creator/view/shoppingListPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
      home: _MyHomePageState(),
    );
  }
}

enum TabItem {
  shoppingListPage(
    title: '買い物リスト',
    icon: Icons.shopping_cart_outlined,
    page: ShoppingListPage(),
  ),

  dishCreatePage(
    title: '献立作成',
    icon: Icons.restaurant,
    page: DishCreaterPage(),
  ),

  accountPage(
    title: 'マイページ',
    icon: Icons.person_outlined,
    page: AccountPage(),
  );

  const TabItem({
    required this.title,
    required this.icon,
    required this.page,
  });

  /// タイトル
  final String title;

  /// アイコン
  final IconData icon;

  /// 画面
  final Widget page;
}

final _navigatorKeys = <TabItem, GlobalKey<NavigatorState>>{
  TabItem.shoppingListPage: GlobalKey<NavigatorState>(),
  TabItem.dishCreatePage: GlobalKey<NavigatorState>(),
  TabItem.accountPage: GlobalKey<NavigatorState>(),
};

class _MyHomePageState extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final currentTab = useState(TabItem.shoppingListPage);
    return Scaffold(
      body: Stack(
        children: TabItem.values
            .map(
              (tabItem) => Offstage(
                offstage: currentTab.value != tabItem,
                child: Navigator(
                  key: _navigatorKeys[tabItem],
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute<Widget>(
                      builder: (context) => tabItem.page,
                    );
                  },
                ),
              ),
            )
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: TabItem.values.indexOf(currentTab.value),
        selectedFontSize: 12,
        items: TabItem.values
            .map(
              (tabItem) => BottomNavigationBarItem(
                icon: Icon(tabItem.icon),
                label: tabItem.title,
              ),
            )
            .toList(),
        onTap: (index) {
          final selectedTab = TabItem.values[index];
          if (currentTab.value == selectedTab) {
            _navigatorKeys[selectedTab]
                ?.currentState
                ?.popUntil((route) => route.isFirst);
          } else {
            // 未選択
            currentTab.value = selectedTab;
          }
        },
      ),
    );
  }
}
