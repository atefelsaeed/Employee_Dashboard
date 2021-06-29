
import 'package:flutter/material.dart';

Widget defaultFormField({
   controller,
  required TextInputType type,
  required validate,
  required String label,
  required IconData prefix,
  onTap,
  onSave, initialValue,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onTap: onTap,
      onSaved: onSave,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        border: OutlineInputBorder(),
      ),
    );
