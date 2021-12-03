import 'package:carwash/consts/const_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('orders')
                .where('userID',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (ctx, index) {
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
                                  docs[index]['garageName'],
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    buildColumn(text1: 'Day : ', text2: docs[index]['day']),
                                    buildColumn(text1: 'time : ', text2: docs[index]['time']),
                                    buildColumn(text1: 'price : ', text2: docs[index]['totalPrise'].toString() +
                                        ' LE'),
                                    buildColumn(text1: 'Way of payment : ', text2:docs[index]['methodPayment']),
                                    buildColumn(text1: 'Accept : ', text2:docs[index]['accept'].toString()),
                                    TextButton(onPressed: ()async{
                                      await FirebaseFirestore.instance.collection('orders').doc(docs[index].id).delete();
                                    }, child: Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.red),
                                    )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
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

  Column buildColumn({text1,text2}) {
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
