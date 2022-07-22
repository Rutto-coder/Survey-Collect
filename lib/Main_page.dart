import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:survey_collect/Home_page.dart';
import 'package:survey_collect/sign_In_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.idTokenChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return HomePage();
          }
          else{
            return sign_In_page();
          }
        },
      ),
    );
  }
}
