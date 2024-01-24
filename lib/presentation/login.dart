import 'package:flutter/material.dart';
import 'homepage.dart';

import 'package:bootcampday6_chatroom_app_24jan/domain/entities/username.dart';
import 'package:bootcampday6_chatroom_app_24jan/domain/usecases/get_username.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MeChat App'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'Masukkan Username...',

                ),
              ),
              SizedBox(height: 50,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage(username: _usernameController.text)),
                    );
                  },
                  child: Text('Login')
              )
            ],
          ),
        ),
      ),
    );
  }
}
