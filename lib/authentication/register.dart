import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_sellers_app/widgets/customeTextField.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children:  [
            SizedBox(height: 10,),
            InkWell(
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width*0.20,
                backgroundColor: Colors.white,
                backgroundImage: imageXFile==null ? null : FileImage(
                  File(
                    imageXFile!.path
                  )
                ),
                child: imageXFile== null ? Icon(
                  Icons.add_photo_alternate,
                  size: MediaQuery.of(context).size.width*0.20,
                  color: Colors.grey,
                ) : null,
              ),
            ),
            SizedBox(height: 10,),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  CustomTextField(
                    data: Icons.person,
                    controller: nameController,
                    hintText: "Name",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    data: Icons.email,
                    controller: emailController,
                    hintText: "Email",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    data: Icons.lock,
                    controller: passwordController,
                    hintText: "Password",
                    isObsecure: true,
                  ),
                  CustomTextField(
                    data: Icons.lock,
                    controller: confirmpasswordController,
                    hintText: "Confirm Password",
                    isObsecure: true,
                  ),
                  CustomTextField(
                    data: Icons.phone,
                    controller: phoneController,
                    hintText: "Phone",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    data: Icons.my_location,
                    controller: locationController,
                    hintText: "Cafe/Resturent Location",
                    isObsecure: false,
                    enabled: false,
                  ),
                  Container(
                    width: 400,
                    height: 40,
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                        onPressed: ()=>print("Clicked"),
                        label: Text(
                          "Get my Location",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30),

                        )
                      ),
                    ),

                  )
                ],
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: ()=>print("Clicked"), child: Text(
              "Sign Up",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
              primary: Colors.cyan,
            ),),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}

