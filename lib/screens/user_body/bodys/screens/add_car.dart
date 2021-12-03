import 'dart:io';

import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/widget/default_button.dart';
import 'package:carwash/widget/default_text_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class AddCar extends StatefulWidget {
  @override
  _AddCarState createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  final _formKey=GlobalKey<FormState>();
  File? image;
  bool loading=false;
  final _nameControlle = TextEditingController();
  final _modelControlle = TextEditingController();
  final _numbergControlle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Car',style: TextStyle(
            color: Colors.black
        ),),
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        child: SingleChildScrollView(
          child: Form(
            key:_formKey ,
            child: Column(
              children: [
                GestureDetector(
                  onTap: ()=>_showPhotoDialog(),
                  child: Container(
                    width: 230,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 150,
                            width: 230,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: KbtnColor)),
                            child: image == null
                                ? Icon(
                              Icons.car_rental,
                              size: 50,
                            )
                                : ClipRRect(
                              child: Image.file(
                                image!,
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: KbtnColor,
                            child: Icon(
                              image == null ? Icons.camera_alt : Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                DefaultTextField(
                  textInputType: TextInputType.text,
                  textEditingController: _nameControlle,
                  hint: 'Car Name',
                  validetor: (v) {
                    if (v.toString().isEmpty) return 'Enter valid name';
                  },
                ),
                SizedBox(height: 15,),
                DefaultTextField(
                  textInputType: TextInputType.text,
                  textEditingController: _modelControlle,
                  hint: 'Car Model',
                  validetor: (v) {
                    if (v.toString().isEmpty) return 'Enter valid name';
                  },
                ),
                SizedBox(height: 15,),
                DefaultTextField(
                  textInputType: TextInputType.number,
                  textEditingController: _numbergControlle,
                  hint: 'Car Number',
                  validetor: (v) {
                    if (v.toString().isEmpty) return 'Enter valid address';
                  },
                ),
                SizedBox(height: 30,),
                loading? Center(child: CircularProgressIndicator(color: KbtnColor,),): Row(
                  children: [
                    Flexible(
                      child: DefaultButton(
                        color: Colors.redAccent,
                        text: 'Cancel',
                        function: (){
                         Navigator.pop(context);
                        },
                      ),
                    ),
                    Flexible(
                      child: DefaultButton(
                        text: 'Add',
                        function: (){
                          _add();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  _add()async{
    String error = '';
    if (_formKey.currentState!.validate()){
      if (image == null) {
        return ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('you must chose photo'),backgroundColor: Colors.red,)
        );
      }
      setState(() {
        loading=true;
      });
      try {
        final User? user =FirebaseAuth.instance.currentUser;
        final ref = FirebaseStorage.instance
            .ref()
            .child('cars Images')
            .child(user!.uid +_nameControlle.value.text+ '.jpg');
        await ref.putFile(image!);
        final url = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('cars')
            .doc()
            .set({
          'ownerId': FirebaseAuth.instance.currentUser!.uid,
          'carName': _nameControlle.text,
          'imageUrl': url,
          'createdAt': Timestamp.now(),
          'model':_modelControlle.text,
          'carNumber':_numbergControlle.text,
        });
        _numbergControlle.clear();
        _nameControlle.clear();
        _modelControlle.clear();
      } on FirebaseAuthException catch (e) {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('error :)'+e.toString()),backgroundColor: Colors.red,));
      } catch (e) {
        print(e);
      }
    }
    setState(() {
      loading = false;
    });
  }
  _showPhotoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Chose photo from'),
        content: Container(
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.image,
                  color: Colors.blue,
                  size: 25,
                ),
                label: Text(
                  'Gallery',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.blue,
                  size: 25,
                ),
                label: Text(
                  'Camera',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('close'))
        ],
      ),
    );
  }
  final picker = ImagePicker();
  Future getImage(ImageSource crs) async {
    final pickerFile = await picker.pickImage(source: crs);
    setState(() {
      if (pickerFile != null) {
        image = File(pickerFile.path);
      } else {
        print('No photo');
      }
    });
  }
}
