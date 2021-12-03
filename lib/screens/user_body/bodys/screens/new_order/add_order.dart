
import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/widget/default_button.dart';
import 'package:carwash/widget/default_text_fields.dart';
import 'package:carwash/widget/logo_image.dart';
import 'package:carwash/widget/visa_felid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class AddOrder extends StatefulWidget {
  final String garageId;
  final String gatageName;

   AddOrder({Key? key,required this.garageId,required this.gatageName}) : super(key: key);

  @override
  _AddOrderState createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  DateTime? picked;

  TimeOfDay time = TimeOfDay.now();

  TimeOfDay pikedTime = TimeOfDay.now();

  var _nameControll = TextEditingController();

  var _phoneControll = TextEditingController();

  var _emailControll = TextEditingController();

  var _darControll = TextEditingController();

  var _timeControll = TextEditingController();

  FocusNode _nameNode = FocusNode();

  FocusNode _emailNode = FocusNode();

  FocusNode _phoneNode = FocusNode();

  FocusNode _dayNode = FocusNode();

  FocusNode _timeNode = FocusNode();

  var _cardNumControl = TextEditingController();
  var _fNameControl = TextEditingController();
  var _lNameControl = TextEditingController();
  var _monthControl = TextEditingController();
  var _yearControl = TextEditingController();
  final _formKey =GlobalKey<FormState>();
  final _formKeyp =GlobalKey<FormState>();
  List carsType = [
    'jeep',
    'Toyota',
    'Marcedes',
    'Sozoky',
  ];

  int payment= 1;
bool loading =false;
  String dropdownValue = 'jeep';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameControll.dispose();
    _phoneControll.dispose();
    _emailControll.dispose();
    _darControll.dispose();
    _timeControll.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Order',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Logo(h: 100,),
              //user data
              Center(child: Text(widget.gatageName,style: TextStyle(
                  color: KbtnColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),)),
              DefaultTextField(
                focusNode: _nameNode,
                nextFocusNode: _phoneNode,
                hint: 'user name',
                validetor: (v) {
                  if(v.toString().isEmpty)
                    return 'Enter valid name';
                },
                textEditingController: _nameControll,
                textInputType: TextInputType.name,
                lable: 'Name',
              ),
              DefaultTextField(
                focusNode: _phoneNode,
                nextFocusNode: _emailNode,
                hint: '0123456789',
                validetor: (v) {
                  if(v.toString().length!=11)
                    return 'Enter valid phone number';
                },
                textEditingController: _phoneControll,
                textInputType: TextInputType.phone,
                lable: 'Phone',
                textInputAction: TextInputAction.done,
              ),
              DefaultTextField(
                focusNode: _emailNode,
                nextFocusNode: _dayNode,
                hint: 'user@gmail.com',
                validetor: (v) {
                  if(v.toString().isEmpty)
                    return 'Enter valid email';
                },
                textEditingController: _emailControll,
                textInputType: TextInputType.emailAddress,
                lable: 'Email',
                textInputAction: TextInputAction.done,
              ),
              GestureDetector(
                onTap: () => pickedDialog(),
                child: DefaultTextField(
                  focusNode: _dayNode,
                  enabled: false,
                  hint: '15/10/2021',
                  validetor: (v) {},
                  textEditingController: _darControll,
                  sufix: Icon(Icons.keyboard_arrow_down),
                  lable: 'Day',
                ),
              ),
              GestureDetector(
                onTap: () => selectTime(context),
                child: DefaultTextField(
                  enabled: false,
                  hint: '5:00 Pm',
                  validetor: (v) {},
                  textEditingController: _timeControll,
                  sufix: Icon(Icons.keyboard_arrow_down),
                  lable: 'Time',
                ),
              ),
              SizedBox(height: 30),
              // washer data
              Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                width: size.width,
                height: size.height * .55,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: SingleChildScrollView(
                    child:Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Car Type',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 130,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Kblack,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                style: TextStyle(
                                    color: KtextColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                                icon: Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  size: 30,
                                  color: Kblack,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: carsType.map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildPadding(text: 'IN',num: '10 SR',size: size),
                            SizedBox(width: 10,),
                            buildPadding(text: 'OUT',num: '10 SR',size: size),
                            SizedBox(width: 10,),
                            buildPadding(text: 'ALL',num: '10 SR',size: size),
                          ],
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Serveses',
                            style: TextStyle(
                              fontSize: 22,
                              color: KbtnColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        buildRow(text: 'Towel', num: "10 RS",),
                        buildRow(text: 'Spray', num: "10 RS",),
                        buildRow(text: 'Soap', num: "10 RS",),
                        buildRow(text: 'Total price', color: KbtnColor, num: '30 RS'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
              // payment method
               Center(child: Text("Way of Payment",style: TextStyle(
                 color: KbtnColor,
                 fontWeight: FontWeight.bold
               ),)),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateColor.resolveWith((states) => Colors.blue),
                        value: 0,
                        groupValue: payment,
                        onChanged: ( v){
                          setState(() {
                            payment=int.parse(v.toString());
                          });
                        },
                      ),
                      Text('online',style: TextStyle(
                          color: KtextColor,
                          fontSize: 25
                      ),),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateColor.resolveWith((states) => Colors.blue),
                        value: 1,
                        groupValue: payment,
                        onChanged: (v){
                          setState(() {
                            payment=int.parse(v.toString());
                          });
                        },
                      ),
                      Text('offline',style: TextStyle(
                          color: KtextColor,
                          fontSize: 25
                      ),),
                    ],
                  ),
                ],
              ),
               if(payment==0)
                 Form(
                   key: _formKeyp,
                   child: Padding(
                     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                     child: Container(
                       width: size.width,
                       height: size.height * .55,
                       decoration: BoxDecoration(
                         color: Colors.blue.shade50,
                         borderRadius: BorderRadius.circular(25),
                       ),
                       child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                         child: SingleChildScrollView(
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Align(
                                 alignment: Alignment.center,
                                 child: Text(
                                   'Payment',
                                   style: TextStyle(
                                       color: KtextColor,
                                       fontSize: 20,
                                       fontWeight: FontWeight.bold),
                                 ),
                               ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   buildContainer(size, 'assets/image/visa.png'),
                                   SizedBox(width: 10),
                                   buildContainer(size, 'assets/image/mater.png'),
                                   SizedBox(width: 10),
                                   buildContainer(size, 'assets/image/amirecan.png'),
                                 ],
                               ),
                               SizedBox(height: 10),
                               VisaField(
                                 lable: 'Card Number',
                                 textEditingController: _cardNumControl,
                               ),
                               Text(
                                 'Expiry date',
                                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                               ),
                               Row(
                                 crossAxisAlignment: CrossAxisAlignment.end,
                                 children: [
                                   Flexible(
                                     child: VisaField(
                                       hint: 'month*',
                                       textEditingController: _monthControl,
                                     ),
                                   ),
                                   SizedBox(width: 10,),
                                   Text('/',style: TextStyle(fontSize: 30),),
                                   SizedBox(width: 10,),
                                   Flexible(
                                     child: VisaField(
                                       hint: 'year*',
                                       textEditingController: _yearControl,
                                     ),
                                   ),
                                 ],
                               ),
                               VisaField(
                                 textInputType: TextInputType.name,
                                 lable: 'Card holder\'s first name',
                                 textEditingController: _fNameControl,
                               ),
                               VisaField(
                                 textInputType: TextInputType.name,
                                 lable: 'Card holder\'s first name',
                                 textEditingController: _lNameControl,
                               ),
                             ],
                           ),
                         ),
                       ),
                     ),
                   ),
                 ),
              loading?Center(child: CircularProgressIndicator(),) :DefaultButton(
                function: () {
                  _submit();
                },
                text: "Next",
              ),
            ],
          ),
        ),
      ),
    );
  }

  _submit()async{
    if(_formKey.currentState!.validate()){
      setState(() {
        loading=true;
      });

        var ar = await FirebaseFirestore.instance
            .collection('garages').doc(widget.garageId)
            .get();
        await FirebaseFirestore.instance
            .collection('orders')
            .doc()
            .set({
          'userID':FirebaseAuth.instance.currentUser!.uid,
          'userName':_nameControll.text,
          'phoneNumber':_phoneControll.text,
          'email':_emailControll.text,
          'day':_darControll.text,
          'time':_timeControll.text,
          'carType':dropdownValue,
          'totalPrise':30,
          'methodPayment':payment==0?'onLine':'offLine',
          'garageOwner':ar['ownerId'],
          'garageName':ar['name'],
          'accept':false,
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('done')));
        });
        setState(() {
          loading=false;
        });
      }
  }

  Widget buildContainer(Size size, String image) {
    return Flexible(
      child: Container(
        width: 150,
        height: 100,
        child: Image.asset(
          image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  pickedDialog() async {
    picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 7)),
    );
    if (picked != null) {
      setState(() {
        _darControll.text = '${picked!.year}-${picked!.month}-${picked!.day}';
      });
    }
  }

  Future selectTime(BuildContext ctx) async {
    pikedTime = (await showTimePicker(
      context: ctx,
      initialTime: time,
    ))!;

    if (pikedTime != null)
      setState(() {
        time = pikedTime;
        _timeControll.text =
            '${time.hour}:${time.minute}  ${time.period.index == 0 ? 'AM' : "PM"}';
      });
  }

  Widget buildPadding({text,num,required Size size}) {
    return Container(
      width:100 ,
      height: 100,
      decoration: BoxDecoration(
        color: Kwhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Kblack.withOpacity(.5), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text.toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Divider(
              color: KtextColor,
              thickness: 1.5,
            ),
            Text(
              num.toString(),
              style: TextStyle(
                  color: KbtnColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildRow({text, color = Kwhite, num,}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          Container(
            alignment: Alignment.center,
            width: 130,
            height: 40,
            decoration: BoxDecoration(
                color: color,
                border: Border.all(
                  color: Kblack,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(15)),
            child: Text(
              num.toString(),
              style: TextStyle(
                  color: color == KbtnColor ? Kwhite : KbtnColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
