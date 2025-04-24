import 'package:flutter/material.dart';

class TextFormFieldStyle extends StatelessWidget{
  final String title;
  final String label;

  final TextEditingController controller;
  IconButton? visable;
  bool sec;
  Icon? logo;

  TextFormFieldStyle({required this.title, required this.controller,this.visable,this.sec=false,required this.label,this.logo});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: sec,
      decoration: InputDecoration(
        hintText: title,
          labelText: label,
          suffixIcon: visable,
          prefixIcon: logo,
          filled: true,
          fillColor: Colors.purple.shade600,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white),
        ),

      ),
      controller: controller,
    );
  }

}