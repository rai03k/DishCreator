import 'package:dish_creator/view/dishCreaterPage/categoryPage.dart';
import 'package:flutter/material.dart';

class DishCreaterPage extends StatefulWidget {
  const DishCreaterPage({super.key});

  @override
  State<DishCreaterPage> createState() => _DishCreatePageState();
}

class _DishCreatePageState extends State<DishCreaterPage> {
  @override
  Widget build(BuildContext context) {
    return CategoryPage();
  }
}
