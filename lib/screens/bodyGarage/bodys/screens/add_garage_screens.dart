import 'dart:io';

import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/widget/default_button.dart';
import 'package:carwash/widget/default_text_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class AddGarage extends StatefulWidget {
  @override
  _AddGarageState createState() => _AddGarageState();
}

class _AddGarageState extends State<AddGarage> {
  final _nameControlle = TextEditingController();
  final _nameOwnerControlle = TextEditingController();
  final _timeOpiningControlle = TextEditingController();
  final _timeClosingControlle = TextEditingController();
  final _addressControlle = TextEditingController();
  final _formKey=GlobalKey<FormState>();
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Garage',style: TextStyle(
          fontSize: 20,
          color: Colors.black
        ),),
      ),
      body:Center(
        child: Padding(
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
                    textEditingController: _nameControlle,
                    hint: 'Name',
                    validetor: (v) {
                      if (v.toString().isEmpty) return 'Enter valid name';
                    },
                  ),
                  SizedBox(height: 15,),
                  DefaultTextField(
                    textEditingController: _nameOwnerControlle,
                    hint: 'Owner Name',
                    validetor: (v) {
                      if (v.toString().isEmpty) return 'Enter valid name';
                    },
                  ),
                  SizedBox(height: 15,),
                  DefaultTextField(
                    textEditingController: _addressControlle,
                    hint: 'Address',
                    validetor: (v) {
                      if (v.toString().isEmpty) return 'Enter valid address';
                    },
                  ),
                  SizedBox(height: 15,),
                  GestureDetector(
                    onTap: ()=>selectTime(context,_timeOpiningControlle),
                    child: DefaultTextField(
                      enabled: false,
                      validetor: (v) {},
                      textEditingController: _timeOpiningControlle,
                      sufix: Icon(Icons.keyboard_arrow_down),
                      hint: 'Time Of Opining',
                    ),
                  ),
                  SizedBox(height: 15,),
                  GestureDetector(
                    onTap: ()=>selectTime(context,_timeClosingControlle),
                    child: DefaultTextField(
                      enabled: false,
                      validetor: (v) {},
                      textEditingController: _timeClosingControlle,
                      sufix: Icon(Icons.keyboard_arrow_down),
                      hint: 'Time Of Closing',
                    ),
                  ),
                  SizedBox(height: 30,),
                 loading? Center(child: CircularProgressIndicator(color: KbtnColor,),): Row(
                    children: [
                      Flexible(
                        child: DefaultButton(
                          text: 'Cancel',
                          function: (){
                            clear();
                          },
                        ),
                      ),
                      Flexible(
                        child: DefaultButton(
                          text: 'Add',
                          function: (){
                            _addGarage();
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
      ),
    );
  }

  File? image;

  _addGarage()async{
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
            .child('garages Images')
            .child(user!.uid +_nameControlle.value.text+ '.jpg');
        await ref.putFile(image!);
        final url = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('garages')
            .doc()
            .set({
          'ownerId': FirebaseAuth.instance.currentUser!.uid,
          'name': _nameControlle.text,
          'ownerName': _nameOwnerControlle.text,
          'imageUrl': url,
          'address': _addressControlle.text,
          'createdAt': Timestamp.now(),
          'timeOpining':_timeOpiningControlle.text,
          'timeClosing':_timeClosingControlle.text,
        });
        clear();
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

  clear(){
    _timeClosingControlle.clear();
    _timeOpiningControlle.clear();
    _addressControlle.clear();
    _nameOwnerControlle.clear();
    _nameControlle.clear();
    setState(() {
      image=null;
    });
  }
  TimeOfDay time = TimeOfDay.now();
  TimeOfDay pikedTime = TimeOfDay.now();
  Future selectTime(BuildContext ctx,TextEditingController textEditingController) async {
    pikedTime = (await showTimePicker(
      context: ctx,
      initialTime: time,
    ))!;

    if(pikedTime!=null)
      setState(() {
        time=pikedTime;
        textEditingController.text='${time.hour}:${time.minute}  ${time.period.index==0?'AM':"PM"}';
      });
  }
}
