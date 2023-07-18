import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:qoutes_app/utils/GlobalVar.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  String select = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            children: GlobalVar.categories.map((e) {
              return GestureDetector(
                onTap: (){
                 setState(() {
                   select = e['title'];
                   GlobalVar.endpoint = e['title'];
                 });
                 print(GlobalVar.endpoint);
                  Navigator.of(context).pushNamed('quotesPage',arguments: e['title']);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    e['title'].toString(),
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList()),
      ),
    );
  }
}
