import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';

Future<void> main() async {
  //todo: add edit profile function to update stuff
  // todo: add logo
  //
  try{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(App());
  }catch(e){
    print(e);
  }

}
