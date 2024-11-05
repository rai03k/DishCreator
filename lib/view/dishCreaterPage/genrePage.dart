import 'package:dish_creator/resource/textResources.dart';
import 'package:dish_creator/view/dishCreaterPage/ingredientPage.dart';
import 'package:flutter/material.dart';

class GenrePage extends StatefulWidget {
  final List<String> categoryList;

  GenrePage({required this.categoryList});

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

  // エラーメッセージ表示(true)/非表示(false)
  bool _isErrorVisible = false;

  // タップされた要素を保存するリスト
  List<String> selectedItems = [];

  // タップされたボタンのインデックスを保存
  List<bool> isSelected = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(TextResources.dishCreatePageTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(TextResources.genreDescText),
            Visibility(
              child: Text(
                TextResources.genreErrorMessage,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              visible: _isErrorVisible,
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2列
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                physics: NeverScrollableScrollPhysics(), // スクロール不可
                children: List.generate(
                  genres.length,
                  (index) {
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
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IngredientPage(), // 遷移先のページ
              ),
            );

            setState(() {
              _isErrorVisible = false;
            });
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
