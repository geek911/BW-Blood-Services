import 'package:bw_blood_final/models/AppointmentUser.dart';
import 'package:bw_blood_final/models/appointment.dart';
import 'package:bw_blood_final/services/appointment_service.dart';
import 'package:flutter/material.dart';

class ApprovalPage extends StatefulWidget {
  @override
  _ApprovalPageState createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {
  List<AppointmentUser> _appointments = [];
  AppointmentService _service = AppointmentService();

  @override
  void initState() {
    _service.getAppointmentJoinedWithUser().then((value) {
      setState(() {
        _appointments = value;
        debugPrint('appointments loaded : '+value.length.toString());
      });
    });
    super.initState();
  }

  Widget initList(List<AppointmentUser> appointments) {
    if (appointments.length == 0) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          var item = appointments[index]; Color color = Colors.orange;
          if(item.appointment.status == 'approved'){
            color = Colors.green;
          }else if(item.appointment.status == 'rejected'){
            color = Colors.red;
          }
          return ListTile(
            title: Text(item.user.name, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20),),
            subtitle: Text('Applied for '+item.appointment.date.toString().substring(0, 10)+", Status : [${item.appointment.status}]"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.check, color: Colors.green,), onPressed: ()async{
                  await _service.approveAppointment(item.appointment.id);
                  _service.getAppointmentJoinedWithUser().then((value) {
                    setState(() {
                      _appointments = value;
                      debugPrint(
                          'appointments loaded : ' + value.length.toString());
                    });
                  });

                }),
                IconButton(icon: Icon(Icons.close, color: Colors.red), onPressed: ()async{
                  await _service.rejectAppointment(item.appointment.id);
                  _service.getAppointmentJoinedWithUser().then((value) {
                    setState(() {
                      _appointments = value;
                      debugPrint(
                          'appointments loaded : ' + value.length.toString());
                    });
                  });

                }),
                IconButton(icon: Icon(Icons.delete, color: Colors.red,), onPressed: () async{
               await _service.deleteAppointment(item.appointment.id);
               _service.getAppointmentJoinedWithUser().then((value) {
                 setState(() {
                   _appointments = value;
                   debugPrint('appointments loaded : '+value.length.toString());
                 });
               });

                }),
              ],
            ),
          );
      },);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approve Appointments'),
        centerTitle: true,
      ),
      body: initList(this._appointments),
    );
  }
}
