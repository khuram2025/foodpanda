import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_sellers_app/widgets/customeTextField.dart';
import 'package:foodpanda_sellers_app/widgets/error_dialog.dart';
import 'package:foodpanda_sellers_app/widgets/loading_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
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

  Position? position;

  String sellerImageURL = "";

  Future<void> _getImage() async {

    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }


  Future<void> _formValidation() async {
    if(imageXFile == null){
      showDialog(context: context, builder: (c){
        return ErrorDialog(
          message: "Please Select an Image",
        );
      });
    }
    else{
      if(passwordController.text == confirmpasswordController.text)
      {
        //start uploading
        if(confirmpasswordController.text.isNotEmpty
            && emailController.text.isNotEmpty
            && nameController.text.isNotEmpty
            && phoneController.text.isNotEmpty
            )
        {
          //start uploading
          showDialog(context: context, builder: (c)
          {
            return LoadingDialog(
              message: "Registring Account",
            );
          }
          );
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          fStorage.Reference reference = fStorage.FirebaseStorage.instance.ref().
          child("sellers").child(fileName);
          fStorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
          fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url) {
            sellerImageURL = url;
          });
        }
        else{
          showDialog(context: context, builder: (c){
            return ErrorDialog(
              message: "Complete the Required info",
            );
          });

        }
      }
      else{
          showDialog(context: context, builder: (c){
            return ErrorDialog(
              message: "Password Incorrect",
            );
          });

    }
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children:  [
            SizedBox(height: 10,),
            InkWell(
              onTap: (){
                _getImage();
              },
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
              onPressed: ()
              {
                // print("Text");
                _formValidation();
              }, child: Text(
              "Sign Up",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
              primary: Colors.cyan,
            ),),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}

