import 'package:dish_creator/resource/textResources.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // アイコンとテキストをまとめたリスト
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.lunch_dining, 'text': TextResources.mainDish},
    {'icon': Icons.eco, 'text': TextResources.sideDish},
    {'icon': Icons.local_cafe, 'text': TextResources.soup},
    {'icon': Icons.cake, 'text': TextResources.dessert},
  ];

  // タップされた要素を保存するリスト
  List<String> selectedItems = [];

  // タップされたボタンのインデックスを保存
  List<bool> isSelected = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(TextResources.categoryDescText),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2列
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        // タップ時に色を変更し、選択された文字列を配列に保存
                        isSelected[index] = !isSelected[index];

                        if (isSelected[index]) {
                          selectedItems.add(categories[index]['text']);
                        } else {
                          selectedItems.remove(categories[index]['text']);
                        }
                      });
                      print(selectedItems); // 選択された項目を表示
                    },
                    child: Card(
                      color: isSelected[index]
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              categories[index]['icon'],
                              size: 48,
                              color: isSelected[index]
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.primary,
                            ),
                            SizedBox(height: 8),
                            Text(
                              categories[index]['text'],
                              style: TextStyle(
                                  fontSize: 16,
                                  color: isSelected[index]
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Row(
          children: [
            Text(TextResources.genrePageBtn),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward)
          ],
        ),
        icon: Container(),
        shape: StadiumBorder(), // 楕円形
        elevation: 0.0,
        highlightElevation: 0.0,
      ),
    );
  }
}
