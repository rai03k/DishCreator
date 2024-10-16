import 'package:dish_creator/resource/textResources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DishCreaterPage extends StatefulWidget {
  const DishCreaterPage({super.key});

  @override
  State<DishCreaterPage> createState() => _DishCreatePageState();
}

class _DishCreatePageState extends State<DishCreaterPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(TextResources.dishCreatePageTitle),
    );
  }
}