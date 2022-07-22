import 'package:firebase_auth/firebase_auth.dart';
import'package:flutter/material.dart';

    class HomePage extends StatefulWidget {
      const HomePage({Key? key}) : super(key: key);

      @override
      State<HomePage> createState() => _HomePageState();
    }
 final user_mail = FirebaseAuth.instance.currentUser?.email.toString().trim();
    class _HomePageState extends State<HomePage> {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.lightBlueAccent[100],
          appBar: AppBar(
            title: Text('Home Page'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              children  : [
                SizedBox(height: 250,),
                Text('You are signed in as:',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.green
                ),
                ),
                SizedBox(height: 20,),
                Text('$user_mail',
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                    color: Colors.blue
                ),
                ),
            SizedBox(height: 15,),

            MaterialButton(onPressed: (){
              FirebaseAuth.instance.signOut();
            },
            child: Text('Log Out'),
              color: Colors.greenAccent,
            )
              ],
            ),
          ),
        );
      }
    }

