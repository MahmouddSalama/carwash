import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/screens/bodyGarage/bodys/screens/garage_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyGarages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Garages',
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
                final docs = snapshot.data!.docs;
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                else if (snapshot.hasError)
                  return Text("error");
                else if (snapshot.hasData && snapshot.data!.docs.length != 0) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>GarageDetels(
                            garageID: snapshot.data!.docs[index].id,
                            name: snapshot.data!.docs[index]['name'],
                          )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 10,
                            child: Container(
                              width: size.width,
                              height: size.height * .3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20)),
                                        child: Image.network(
                                          snapshot.data!.docs[index]['imageUrl'],
                                          fit: BoxFit.fill,
                                        )),
                                    width: size.width,
                                    height: size.height * .25,
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['name'],
                                    style:
                                        TextStyle(fontSize: 25, color: KbtnColor),
                                  )
                                ],
                              ),
                            ),
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
}
