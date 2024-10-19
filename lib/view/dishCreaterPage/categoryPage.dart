import 'package:dish_creator/resource/textResources.dart';
import 'package:dish_creator/view/dishCreaterPage/genrePage.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final Function(List<String>) onNext;
  CategoryPage({required this.onNext});

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

  // エラーメッセージ表示(true)/非表示(false)
  bool _isErrorVisible = false;

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
            Visibility(
              child: Text(
                TextResources.categoryErrorMessage,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              visible: _isErrorVisible,
            ),
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
        onPressed: () {
          // カテゴリー選択されている場合
          if (selectedItems.isNotEmpty) {
            // ジャンル選択画面表示
            widget.onNext(selectedItems);
            // カテゴリー選択されていない場合
          } else {
            setState(() {
              // エラーメッセージ表示
              _isErrorVisible = true;
            });
          }
        },
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
