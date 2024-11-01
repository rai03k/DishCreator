import 'package:dish_creator/resource/ingredientResources.dart';
import 'package:dish_creator/resource/textResources.dart';
import 'package:flutter/material.dart';

class IngredientPage extends StatefulWidget {
  final Function onBack;
  IngredientPage({super.key, required this.onBack});

  @override
  _IngredientPageState createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  List<List<String>> ingredientList = IngredientResources.ingredientList;

  // すべての食材を含むリスト
  late List<String> allIngredients;

  // 各タブの選択状態を管理するリスト
  List<List<bool>> selectedStatus = [];

  @override
  void initState() {
    super.initState();
    // 全ての食材を格納
    allIngredients = ingredientList.expand((category) => category).toList();

    // 各カテゴリの食材ごとに選択状態を初期化
    selectedStatus = [
      List.generate(allIngredients.length, (index) => false), // すべての食材
      ...ingredientList.map((category) =>
          List.generate(category.length, (index) => false)), // 各カテゴリの選択状態
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: TextResources.tabs.length,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).colorScheme.onPrimary,
              child: TabBar(
                dividerColor: Colors.transparent,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                tabs: TextResources.tabs.map((tab) => Tab(text: tab)).toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildAllIngredients(), // すべての食材を表示
                  ...List<Widget>.generate(
                    ingredientList.length,
                    (index) {
                      return _buildChoiceChips(
                          ingredientList[index], index + 1);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Row(
          children: [
            Text(TextResources.dishCreatePageBtn),
            SizedBox(width: 8),
            Icon(Icons.search)
          ],
        ),
        icon: Container(),
        shape: StadiumBorder(), // 楕円形
        elevation: 0.0,
        highlightElevation: 0.0,
      ),
    );
  }

  // すべての食材タブを表示
  Widget _buildAllIngredients() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List<Widget>.generate(
          ingredientList.length,
          (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      index != 0 ? EdgeInsets.only(top: 32) : EdgeInsets.all(0),
                  child: Text(
                    TextResources.tabs[index + 1], // カテゴリ名を表示
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                  height: 20.0,
                ),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: List<Widget>.generate(
                    ingredientList[index].length,
                    (int ingredientIndex) {
                      return ChoiceChip(
                        label: Text(ingredientList[index][ingredientIndex]),
                        selected: selectedStatus[index + 1][ingredientIndex],
                        shape: StadiumBorder(
                          side: BorderSide(
                            width: 0.0, // アウトラインを細く設定
                          ),
                        ),
                        selectedColor: Theme.of(context).colorScheme.primary,
                        showCheckmark: false,
                        onSelected: (bool isSelected) {
                          setState(() {
                            selectedStatus[index + 1][ingredientIndex] =
                                isSelected;

                            // 全体タブの選択を他のカテゴリに同期
                            _syncWithCategory(
                                ingredientList[index][ingredientIndex],
                                isSelected);
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ChoiceChipのリストを生成
  Widget _buildChoiceChips(List<String> ingredients, int categoryIndex) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: List<Widget>.generate(
          ingredients.length,
          (int index) {
            return ChoiceChip(
              label: Text(ingredients[index]),
              selected: selectedStatus[categoryIndex][index],
              shape: StadiumBorder(
                side: BorderSide(
                  width: 0.0, // アウトラインを細く設定
                ),
              ),
              selectedColor: Theme.of(context).colorScheme.primary,
              showCheckmark: false,
              onSelected: (bool isSelected) {
                setState(() {
                  selectedStatus[categoryIndex][index] = isSelected;

                  // 「すべて」タブで選択した場合、他のカテゴリでも連動
                  if (categoryIndex == 0) {
                    _syncWithAllIngredients(index, isSelected);
                  } else {
                    _syncWithCategory(ingredients[index], isSelected);
                  }
                });
              },
            );
          },
        ),
      ),
    );
  }

  // 「すべて」タブでの選択をカテゴリごとに同期
  void _syncWithAllIngredients(int index, bool isSelected) {
    String selectedIngredient = allIngredients[index];

    // 他のカテゴリで該当する食材を選択状態に更新
    for (int i = 1; i < selectedStatus.length; i++) {
      for (int j = 0; j < selectedStatus[i].length; j++) {
        if (ingredientList[i - 1][j] == selectedIngredient) {
          selectedStatus[i][j] = isSelected;
        }
      }
    }
  }

  // 各カテゴリの選択を「すべて」タブに同期
  void _syncWithCategory(String ingredient, bool isSelected) {
    int index = allIngredients.indexOf(ingredient);
    if (index != -1) {
      selectedStatus[0][index] = isSelected;
    }
  }
}
