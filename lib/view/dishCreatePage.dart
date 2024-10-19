import 'package:dish_creator/resource/textResources.dart';
import 'package:dish_creator/view/dishCreaterPage/categoryPage.dart';
import 'package:dish_creator/view/dishCreaterPage/genrePage.dart';
import 'package:flutter/material.dart';

class DishCreaterPage extends StatefulWidget {
  const DishCreaterPage({super.key});

  @override
  State<DishCreaterPage> createState() => _DishCreatePageState();
}

class _DishCreatePageState extends State<DishCreaterPage> {
  bool _isGenrePage = false; // ジャンルページの表示フラグ
  List<String> _selectedCategories = []; // 選択されたカテゴリのリスト

  void _goToGenrePage(List<String> selectedCategories) {
    setState(() {
      _isGenrePage = true;
      _selectedCategories = selectedCategories; // 選択されたカテゴリを保存
    });
  }

  void _goBackToCategoryPage() {
    setState(() {
      _isGenrePage = false; // カテゴリページに戻る
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TextResources.dishCreatePageTitle),
        leading: _isGenrePage
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: _goBackToCategoryPage,
              )
            : null,
      ),
      body: _isGenrePage
          ? GenrePage(
              onBack: _goBackToCategoryPage,
              categoryList: _selectedCategories,
            )
          : CategoryPage(onNext: _goToGenrePage),
    );
  }
}
