import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class transationForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  transationForm(this.onSubmit);

  @override
  State<transationForm> createState() => _transationFormState();
}

class _transationFormState extends State<transationForm> {
  final titleControler = TextEditingController();

  final valueControler = TextEditingController();

  _submitForm(){
    final tittle = titleControler.text;
    final value = double.tryParse(valueControler.text) ?? 0.0;
    if( tittle.isEmpty || value <= 0){
      return;
    }
    widget.onSubmit(tittle, value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
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
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 240, 184, 221)),
                onPressed: () { _submitForm();},
                child: Text('Nova Transação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
