import 'package:dish_creator/resource/textResources.dart';
import 'package:flutter/material.dart';

class GenrePage extends StatefulWidget {
  final VoidCallback onBack;
  final List<String> categoryList;

  GenrePage({required this.onBack, required this.categoryList});

  @override
  _GenrePageState createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  // カテゴリー選択内容受け取り
  late List<String> categoryList;
  @override
  void initState() {
    super.initState();
    categoryList = widget.categoryList;
  }

  // アイコンとテキストをまとめたリスト
  final List<String> genres = [
    TextResources.japaneseCuisine,
    TextResources.westernCuisine,
    TextResources.chineseCuisine,
    TextResources.koreanCuisine
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
            Text(TextResources.genreDescText),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2列
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        // タップ時に色を変更し、選択された文字列を配列に保存
                        isSelected[index] = !isSelected[index];

                        if (isSelected[index]) {
                          selectedItems.add(genres[index]);
                        } else {
                          selectedItems.remove(genres[index]);
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
                        child: Center(
                          child: Text(
                            genres[index],
                            style: TextStyle(
                                fontSize: 16,
                                color: isSelected[index]
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.onSurface),
                          ),
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
            Text(TextResources.ingredientPageBtn),
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
