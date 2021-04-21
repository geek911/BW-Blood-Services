import 'package:bw_blood_final/models/tip.dart';
import 'package:bw_blood_final/services/tip_service.dart';
import 'package:bw_blood_final/utils/validator.dart';
import 'package:flutter/material.dart';

class AddDailyTipPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  TipService _service=TipService();

  Future<void> _addTip() async {
    Tip tip=Tip()
        ..title = titleController.value.text
        ..body = bodyController.value.text;
    await _service.addTip(tip);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Daily Tip'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: titleController,
                validator: validate,
                decoration: InputDecoration(
                  labelText: 'TITLE',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: TextFormField(
                  controller: bodyController,
                  validator: validate,
                  maxLines: 20,
                  decoration: InputDecoration(
                    labelText: 'BODY',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('POST'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await _addTip();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tip Added')));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Something is not right')));
                    }
                  },
                ),
              ),
              Divider(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('CANCEL'))
            ],
          ),
        ),
      ),
    );
  }
}
