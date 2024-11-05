import 'package:dish_creator/resource/textResources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(TextResources.shoppingListPageTitle),
    );
  }
}
