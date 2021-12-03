
import 'dart:io';

import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/widget/default_text_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AllGarageDetailes extends StatefulWidget {
  final String garageID;
  final String name;

  AllGarageDetailes({Key? key,required this.garageID,required this.name}) : super(key: key);

  @override
  _AllGarageDetailesState createState() => _AllGarageDetailesState();
}

class _AllGarageDetailesState extends State<AllGarageDetailes> {
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
                  return  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: 230,
                              child: Padding(
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
                            ),
                            DefaultTextField(
                              enabled:edit ,
                              textEditingController: null,
                              hint: docs['name'],
                              validetor: (v) {
                              },
                            ),
                            SizedBox(height: 15,),
                            DefaultTextField(
                              enabled:edit ,
                              textEditingController: null,
                              hint: docs['ownerName'],
                              validetor: (v) {
                              },
                            ),
                            SizedBox(height: 15,),
                            DefaultTextField(
                              enabled:edit ,
                              textEditingController: null,
                              hint: docs['address'],
                              validetor: (v) {
                              },
                            ),
                            SizedBox(height: 15,),
                            GestureDetector(
                              onTap:(){},
                              child: DefaultTextField(
                                enabled: false,
                                validetor: (v) {},
                                textEditingController: null,
                                sufix: Icon(Icons.keyboard_arrow_down),
                                hint: docs['timeOpining'],
                              ),
                            ),
                            SizedBox(height: 15,),
                            GestureDetector(
                              onTap:(){},
                              child: DefaultTextField(
                                enabled: false,
                                validetor: (v) {},
                                textEditingController: null,
                                sufix: Icon(Icons.keyboard_arrow_down),
                                hint: docs['timeClosing'],
                              ),
                            ),
                            SizedBox(height: 30,),
                          ],
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
}
