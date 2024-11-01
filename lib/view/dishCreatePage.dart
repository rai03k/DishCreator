import 'package:dish_creator/resource/textResources.dart';
import 'package:dish_creator/view/dishCreaterPage/categoryPage.dart';
import 'package:dish_creator/view/dishCreaterPage/genrePage.dart';
import 'package:dish_creator/view/dishCreaterPage/ingredientPage.dart';
import 'package:flutter/material.dart';

class DishCreaterPage extends StatefulWidget {
  const DishCreaterPage({super.key});

  @override
  State<DishCreaterPage> createState() => _DishCreatePageState();
}

class _DishCreatePageState extends State<DishCreaterPage> {
  bool _isGenrePage = false; // ジャンルページの表示フラグ
  bool _isIngredientPage = false; // 食材ページの表示フラグ
  List<String> _selectedCategories = []; // 選択されたカテゴリのリスト
  List<String> _selectedGenres = []; // 選択されたジャンルのリスト

  void _goToGenrePage(List<String> selectedCategories) {
    setState(() {
      _isGenrePage = true;
      _selectedCategories = selectedCategories; // 選択されたカテゴリを保存
    });
  }

  void _goToIngredientPage(List<String> selectedGenres) {
    setState(() {
      _isIngredientPage = true;
      _selectedGenres = selectedGenres;
    });
  }

  void _goBackToCategoryPage() {
    setState(() {
      _isGenrePage = false; // カテゴリページに戻る
    });
  }

  void _goBackToGenrePage() {
    setState(() {
      _isIngredientPage = false;
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
                  onPressed: _isIngredientPage
                      ? _goBackToGenrePage
                      : _goBackToCategoryPage,
                )
              : null,
        ),
        body: _isIngredientPage
            ? IngredientPage(onBack: _goBackToGenrePage)
            : _isGenrePage
                ? GenrePage(
                    onNext: _goToIngredientPage,
                    onBack: _goBackToCategoryPage,
                    categoryList: _selectedCategories,
                  )
                : CategoryPage(onNext: _goToGenrePage));
  }
}
