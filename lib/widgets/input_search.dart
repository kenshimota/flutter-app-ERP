import 'dart:async';
import 'package:flutter/material.dart';

class InputSearch extends StatefulWidget {
  final Function(String)? onSearch;
  const InputSearch({ super. key, this.onSearch});
  @override
  _InputSearchState createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  Timer? _debounceTimer;
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _textEditingController.dispose();
    super.dispose();
  }

  void _onTextChanged(String newText) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(const Duration(seconds: 1), () {
      // Aquí puedes realizar alguna acción después de que el usuario termine de escribir
     widget.onSearch!(newText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      onChanged: _onTextChanged,
      decoration: const InputDecoration(
        hintText: 'Escribe algo...',
        prefixIcon: IconButton(onPressed: null, icon: Icon(Icons.search),),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}