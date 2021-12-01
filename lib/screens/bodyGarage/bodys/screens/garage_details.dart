import 'dart:io';

import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/widget/default_button.dart';
import 'package:carwash/widget/default_text_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class GarageDetels extends StatefulWidget {
  final String garageID;
  final String name;

   GarageDetels({Key? key,required this.garageID,required this.name}) : super(key: key);

  @override
  _GarageDetelsState createState() => _GarageDetelsState();
}

class _GarageDetelsState extends State<GarageDetels> {
  final _nameControlle = TextEditingController();
  final _nameOwnerControlle = TextEditingController();
  final _timeOpiningControlle = TextEditingController();
  final _timeClosingControlle = TextEditingController();
  final _addressControlle = TextEditingController();
  final _formKey=GlobalKey<FormState>();
  bool loading=false;
  bool edit=false;
   String butText='Edit';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('garages')
                .where('ownerId',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              try {

                final docs = snapshot.data!.docs.firstWhere((element) =>element.id==widget.garageID);
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                else if (snapshot.hasError)
                  return Text("error");
                else if (snapshot.hasData && snapshot.data!.docs.length != 0) {
                  _nameControlle.text=docs['name'];
                  _nameOwnerControlle.text=docs['ownerName'];
                  _addressControlle.text=docs['address'];
                  _timeClosingControlle.text=docs['timeClosing'];
                  _timeOpiningControlle.text=docs['timeOpining'];
                  return  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                      child: SingleChildScrollView(
                        child: Form(
                          key:_formKey ,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (){},
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
                                          child:  ClipRRect(
                                            child: Image.network(
                                             docs['imageUrl'],
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
                                enabled:edit ,
                                textEditingController: _nameControlle,
                                hint: docs['name'],
                                validetor: (v) {
                                },
                              ),
                              SizedBox(height: 15,),
                              DefaultTextField(
                                enabled:edit ,
                                textEditingController: _nameOwnerControlle,
                                hint: docs['ownerName'],
                                validetor: (v) {
                                },
                              ),
                              SizedBox(height: 15,),
                              DefaultTextField(
                                enabled:edit ,
                                textEditingController: _addressControlle,
                                hint: docs['address'],
                                validetor: (v) {
                                },
                              ),
                              SizedBox(height: 15,),
                              GestureDetector(
                                onTap:edit?()=>selectTime(context,_timeOpiningControlle):null,
                                child: DefaultTextField(
                                  enabled: false,
                                  validetor: (v) {},
                                  textEditingController: _timeOpiningControlle,
                                  sufix: Icon(Icons.keyboard_arrow_down),
                                  hint: docs['timeOpining'],
                                ),
                              ),
                              SizedBox(height: 15,),
                              GestureDetector(
                                onTap:edit? ()=>selectTime(context,_timeClosingControlle):null,
                                child: DefaultTextField(
                                  enabled: false,
                                  validetor: (v) {},
                                  textEditingController: _timeClosingControlle,
                                  sufix: Icon(Icons.keyboard_arrow_down),
                                  hint: docs['timeClosing'],
                                ),
                              ),
                              SizedBox(height: 30,),
                              loading? Center(child: CircularProgressIndicator(color: KbtnColor,),):
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: DefaultButton(
                                      color: Colors.redAccent,
                                      fontSize: 13,
                                      text: 'Delete',
                                      function: (){
                                        _delete();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  Flexible(
                                   flex: 3,
                                    child: DefaultButton(
                                      text: butText,
                                      function: (){
                                        setState(() {
                                          butText='Submit';
                                          edit=true;
                                          _edit();
                                        });
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
                } else if (snapshot.data!.docs.length == 0) {
                  return Center(
                    child: Text('no data'),
                  );
                }
              } catch (e) {}
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
  _edit()async{
    String error = '';
    if (_formKey.currentState!.validate()){
      setState(() {
        loading=true;
      });
      try {
        await FirebaseFirestore.instance
            .collection('garages')
            .doc(widget.garageID)
            .update({
          'name': _nameControlle.text,
          'ownerName': _nameOwnerControlle.text,
          'address': _addressControlle.text,
          'timeOpining':_timeOpiningControlle.text,
          'timeClosing':_timeClosingControlle.text,
        });
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
  _delete()async{
    await FirebaseFirestore.instance
        .collection('garages')
        .doc(widget.garageID).delete();
  }
  File? image;
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
