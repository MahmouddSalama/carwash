import 'package:carwash/consts/const_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class UserCars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Cars",style: TextStyle(
          color: Kblack
        ),),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('cars').where("ownerId",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                        padding: const EdgeInsets.all(5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 10,
                          child: Padding(
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
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20)),
                                        child: Image.network(
                                          docs[index]['imageUrl'],
                                          fit: BoxFit.fill,
                                        )),
                                    width: size.width,
                                    height: size.height * .25,
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
                                        buildColumn(text1: 'Car name : ', text2: docs[index]['carName']),
                                        buildColumn(text1: 'Car Number : ', text2: docs[index]['carNumber']),
                                        buildColumn(text1: 'Model : ', text2: docs[index]['model']),
                                        TextButton(onPressed: ()async{
                                          await FirebaseFirestore.instance.collection('cars').doc(docs[index].id).delete();
                                        }, child: Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
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
