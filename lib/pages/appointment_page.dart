
import 'package:bw_blood_final/constants/routes.dart';
import 'package:bw_blood_final/models/appointment.dart';
import 'package:bw_blood_final/models/centre.dart';
import 'package:bw_blood_final/services/appointment_service.dart';
import 'package:bw_blood_final/services/centre_services.dart';
import 'package:bw_blood_final/services/user_service.dart';
import 'package:bw_blood_final/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {

  List<Appointment> _appointments = [];
  DateTime _dateTime = DateTime.now();
  var service = AppointmentService();
  Centre _centre;
  List<Centre> _centres = [];

  TimeOfDay pickedTime = TimeOfDay.now();

  @override
  void initState() {
    CenterServices().getAllCenters().then((centres){
      AppointmentService().getMyAppointments().then((appointments){
        setState(() {
          _centres = centres;
          _appointments = appointments;
          _centre = _centres.first;
          debugPrint('centres : '+_centres.length.toString());
        });
      });
    });

    super.initState();
  }

  Future<void> deleteAppointment(String id) async{
    await AppointmentService().deleteAppointment(id);

    _appointments = await service.getMyAppointments();
    setState(() {
      debugPrint('Printing app');
    });
  }

  Future<void> _addAppointment() async {
    var appointment = Appointment();
    appointment.centreId = _centre.id;
    appointment.date = DateTime.parse(_dateTime.toString());
    await service.addAppointment(appointment);
    _appointments = await service.getMyAppointments();
    setState(() {
      debugPrint('Printing app');
    });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay response = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (response != null && response != pickedTime) {
      setState(() {
        pickedTime = response;
        _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day, pickedTime.hour, pickedTime.minute);
      });
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != _dateTime)
      setState(() {
        _dateTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment'),
        centerTitle: true,
        actions: [
          UserService.isAdmin ?
          IconButton(icon: Icon(Icons.approval), onPressed: ()async{
            await Navigator.pushNamed(context, APPROVAL_PAGE);

          }) : Text('')
        ],
      ),
      body:  Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Centre>(
                        value: _centre,
                        items: _centres.map((Centre value) {
                          return new DropdownMenuItem<Centre>(
                            value: value,
                            child: new Text(value.name, style: TextStyle(color: Colors.black, fontSize: 20), ),
                          );
                        }).toList(),
                        onChanged: (v) {
                          setState(() {
                            _centre = v;
                          });
                        },
                      ),
                    ),
                  ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton.icon(
                        label: Text(_dateTime.toString().substring(0, 10)),
                        onPressed: () => _selectDate(context),
                        icon: Icon(Icons.calendar_today)),
                    TextButton.icon(
                        label: Text(pickedTime.format(context).toString()),
                        onPressed: () => _selectTime(context),
                        icon: Icon(Icons.watch)),
                  ],
                ),


                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                      icon: Icon(Icons.add),
                      onPressed: () async {
                        await _addAppointment();
                      },
                      label: Text('Add Appointment')),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _appointments.length,
              itemBuilder: (context, index) {
                Appointment a = _appointments[index];
                Centre centre = _centres.firstWhere((element) => element.id == a.centreId);
                Color color = Colors.orange;
                if(a.status == 'approved'){
                  color = Colors.green;
                }else if(a.status == 'rejected'){
                  color = Colors.red;
                }
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                     centre.name,
                      style: TextStyle(color: color),
                    ),
                    subtitle: Text('On ${a.date.toString().substring(0, 16)} [ status - ${a.status} ]', style: TextStyle(color: color),),
                    trailing: IconButton(icon: Icon(Icons.delete, color: Colors.red,), onPressed: () async {
                      await deleteAppointment(a.id);
                    },),
                  ),
                );
              },
            ),
          )
        ],
      ),
      drawer: mainDrawer(context),
    );
  }
}
