import 'package:carwash/consts/const_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            try {
              final docs = snapshot.data!.docs;
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              else if (snapshot.hasError)
                return Text("error");
              else if (snapshot.hasData && snapshot.data!.docs.length != 0) {
                DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(
                    docs[0]['createdAt'].microsecondsSinceEpoch);
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: KbackColor,
                        border: Border.all(color: KtextColor, width: 1.5),
                      ),
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              docs[0]['name'],
                              style: TextStyle(
                                fontSize: 18,
                                color: KtextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            height: 40,
                            alignment: Alignment.center,
                          ),
                          Divider(
                              thickness: 2,
                              color: KtextColor.withOpacity(.6)),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                buildColumn(
                                    text1: 'Name : ', text2: docs[0]['name']),
                                buildColumn(
                                    text1: 'Email : ',
                                    text2: docs[0]['email']),
                                buildColumn(
                                    text1: 'Phone Number : ',
                                    text2: docs[0]['phoneNum']),
                                buildColumn(
                                    text1: 'Your Rule : ',
                                    text2: docs[0]['type']),
                                buildColumn(
                                    text1: 'Date Of Join : ',
                                    text2:
                                        "${dateTime.year}-${dateTime.month}-${dateTime.day}"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ));
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
    );
  }

  Column buildColumn({text1, text2}) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              text1,
              style: TextStyle(
                fontSize: 18,
                color: Kblack,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              text2,
              style: TextStyle(
                fontSize: 18,
                color: KtextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Divider(thickness: 1.5, color: KtextColor.withOpacity(.3)),
      ],
    );
  }
}
