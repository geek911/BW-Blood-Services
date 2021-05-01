import 'package:bw_blood_final/models/centre.dart';
import 'package:bw_blood_final/services/centre_services.dart';
import 'package:bw_blood_final/utils/validator.dart';
import 'package:flutter/material.dart';

class AddBTCPage extends StatelessWidget {
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final otherController = TextEditingController();
  CenterServices _service = CenterServices();

  final _formKey = GlobalKey<FormState>();

  Future<void> addCentre() async {
    Centre centre = Centre()
      ..name = nameController.value.text
      ..location = locationController.value.text
      ..phoneNumber = phoneNumberController.value.text
      ..other = otherController.value.text;
    await _service.addCentre(centre);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Blood Transfusion Centre'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: nameController,
                    validator: validate,
                    decoration: InputDecoration(
                      labelText: 'NAME',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: locationController,
                    validator: validate,
                    decoration: InputDecoration(
                      labelText: 'LOCATION',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: phoneNumberController,
                    validator: validate,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: otherController,
                    validator: validate,
                    decoration: InputDecoration(
                      labelText: 'More Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('UPDATE'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await addCentre();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Centre Added')));
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Something is not right')));
                        }
                      },
                    ),
                  ),
                  Divider(),
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: Text('CANCEL'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
