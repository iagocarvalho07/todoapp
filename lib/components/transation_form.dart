import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class transationForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  transationForm(this.onSubmit);

  @override
  State<transationForm> createState() => _transationFormState();
}

class _transationFormState extends State<transationForm> {
  final titleControler = TextEditingController();
  final valueControler = TextEditingController();
  DateTime? _SelecteDate = DateTime.now();

  _submitForm() {
    final tittle = titleControler.text;
    final value = double.tryParse(valueControler.text) ?? 0.0;
    if (tittle.isEmpty || value <= 0 || _SelecteDate == null) {
      return;
    }
    widget.onSubmit(tittle, value, _SelecteDate!);
  }

  _showDatePick() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _SelecteDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleControler,
                decoration: InputDecoration(labelText: "Titulo"),
              ),
              TextField(
                controller: valueControler,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(labelText: "Valor "),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Text(
                      _SelecteDate == null
                          ? "Nenhuma Data Selecionada"
                          : DateFormat('dd/MM/y').format(_SelecteDate!),
                    ),
                    TextButton(
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.purple),
                      onPressed: _showDatePick,
                      child: Text("Selecionar Data"),
                    )
                  ],
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 240, 184, 221)),
                onPressed: () {
                  _submitForm();
                },
                child: Text('Nova Transação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
