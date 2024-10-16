import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  final List<String> items;
  Function(String) onSelected;

  FilterWidget({required this.items, required this.onSelected});

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.items.map((e) => filterItems(e)).toList(),
      ),
    );
  }


  Widget filterItems(String item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItem = item;
        });
        widget.onSelected(item);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: _selectedItem == item ? Colors.deepPurple : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          item,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
