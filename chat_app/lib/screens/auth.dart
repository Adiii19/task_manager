import 'dart:io';

import 'package:chat_app/widgets/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  File? selectedimage;
  var isAuthenticating=false;
  var enteredusername='';

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid || !_isLogin && selectedimage==null) {
      return;
    }

    _form.currentState!.save();

    if (_isLogin) {

      setState(() {
        isAuthenticating=true;
      });

        try {
  final UserCredential=await _firebase.signInWithEmailAndPassword(email: _enteredEmail, password: _enteredPassword);
} on FirebaseAuthException catch (error) {
    if (error.code == 'email-already-in-use') {
          // ...
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Authentication failed.'),

          ),
          
);
     setState(() {
       isAuthenticating=false;
     });
}

    }
     else {
      try {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        print(userCredentials);

        final storageRef=  FirebaseStorage.instance.ref().child('user_images').child('${userCredentials.user!.uid}.jpg');
        await storageRef.putFile(selectedimage!);
             final imageurl=await storageRef.getDownloadURL();

             await FirebaseFirestore.instance.collection('users').doc(userCredentials.user!.uid).
             set(
              {
                  'name':enteredusername,
                  'email':_enteredEmail,
                  'imageURL':imageurl
                   
              }
             );


      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {
          // ...
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Authentication failed.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset('assets/images/chat.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                    
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            if(!_isLogin)
                      
                        UserImagePicker(onpickedimage: (pickedimage) {
                          selectedimage=pickedimage;
                        },),
                           if(!_isLogin)
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Username'
                            ),
                            enableSuggestions:false ,
                            validator:(value) {
                              
                                if(value==null||value.trim().length<4||value.isEmpty)
                                {
                                  return 'Please enter atleast 4 characters';
                                }
                                return null;

                            },

                            onSaved:(newValue) {
                             enteredusername= newValue!;
                            },
                          ),


                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Email Address'),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password must be at least 6 characters long.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(height: 12),
                          if(isAuthenticating)
                            CircularProgressIndicator(),
                          if(!isAuthenticating)
                          ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            child: Text(_isLogin ? 'Login' : 'Signup'),
                          ),
                        if(!isAuthenticating)

                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(_isLogin
                                ? 'Create an account'
                                : 'I already have an account'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}