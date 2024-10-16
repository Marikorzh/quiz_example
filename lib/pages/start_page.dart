import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/pages/quiz_page.dart';

import '../widgets/widget_filter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Quiz'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool isVisible = false;
  String? selectedNumber;
  String? selectedCategory;
  String? selectedDifficulty;

  List<String> itemsOfFilterNumber = ["5", "8", "10", "12"];
  List<String> itemsOfFilterCategory = ["Books", "Films", "Music", "Video Games"];
  List<String> itemsOfFilterDifficulty = ["Easy", "Medium", "Hard", "Any"];

  double heigthBtwFilters = 10;

  @override
  void initState() {
    super.initState();
    selectedNumber = itemsOfFilterNumber[0];
    selectedCategory = itemsOfFilterCategory[0];
    selectedDifficulty = itemsOfFilterDifficulty[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title)
      ),
        body: Column(
          children: [
            Text('Number of questions '),
            FilterWidget(
              items: itemsOfFilterNumber,
              onSelected: (value) {
                setState(() {
                  selectedNumber = value;
                });
              },
            ),
            SizedBox(height: heigthBtwFilters,),

            Text('Select category '),
            FilterWidget(
                items: itemsOfFilterCategory,
                onSelected: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                }
            ),
            SizedBox(height: heigthBtwFilters,),

            Text("Select difficulty "),
            FilterWidget(
                items: itemsOfFilterDifficulty,
                onSelected: (value) {
                  setState(() {
                    selectedDifficulty = value;
                  });
                }
            ),
            SizedBox(height: heigthBtwFilters,),

            ElevatedButton(onPressed: ()=>{
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuizPage(res: [selectedNumber!, selectedCategory!, selectedDifficulty!],),
                  ),
              )
            }, child: Text("Create Quiz"),)
          ],
        )
    );
  }
}