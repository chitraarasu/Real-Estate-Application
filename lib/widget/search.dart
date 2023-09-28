import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  Function(String) onChange;
  final controller;

  Search(this.onChange, this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      decoration: const BoxDecoration(
        color: Color(0xFFebebec),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: TextField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: controller,
        maxLines: 1,
        onChanged: onChange,
        decoration: const InputDecoration(
          hintText: "Search",
          hintStyle: TextStyle(color: Color(0xFF86898f)),
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: EdgeInsets.only(bottom: 3.0),
            child: Icon(
              Icons.search,
              color: Color(0xFF86898f),
            ),
          ),
        ),
      ),
    );
  }
}
