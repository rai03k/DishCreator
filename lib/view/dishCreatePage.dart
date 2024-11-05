import 'package:auto_route/auto_route.dart';
import 'package:dish_creator/view/dishCreaterPage/categoryPage.dart';
import 'package:flutter/material.dart';

@RoutePage()
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
    return CategoryPage();
  }
}
