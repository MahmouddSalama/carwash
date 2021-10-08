import 'package:carwash/screens/body/order_details/edit_informaition_screen.dart';
import 'package:carwash/screens/body/order_details/order_details_payment.dart';
import 'package:carwash/widget/default_button.dart';
import 'package:carwash/widget/default_text_fields.dart';
import 'package:carwash/widget/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
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
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Logo(),
            DefaultTextField(
              focusNode: _nameNode,
              nextFocusNode: _phoneNode,
              hint: 'user name',
              validetor: (v) {},
              textEditingController: _nameControll,
              textInputType: TextInputType.name,
              lable: 'Name',
            ),
            DefaultTextField(
              focusNode: _phoneNode,
              nextFocusNode: _emailNode,
              hint: '0123456789',
              validetor: (v) {},
              textEditingController: _phoneControll,
              textInputType: TextInputType.name,
              lable: 'Phone',
              textInputAction: TextInputAction.done,
            ),
            DefaultTextField(
              focusNode: _emailNode,
              nextFocusNode: _dayNode,
              hint: 'user@gmail.com',
              validetor: (v) {},
              textEditingController: _emailControll,
              textInputType: TextInputType.name,
              lable: 'Email',
              textInputAction: TextInputAction.done,
            ),
            GestureDetector(
              onTap:()=> pickedDialog(),
              child: DefaultTextField(
                focusNode: _dayNode,
                enabled: false,
                hint: '15/10/2021',
                validetor: (v) {},
                textEditingController: _darControll,
                sufix:Icon(Icons.keyboard_arrow_down),
                lable: 'Day',
              ),
            ),
            GestureDetector(
              onTap: ()=>selectTime(context),
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
            DefaultButton(
              function: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>EditInformationScreen()));
              },
              text: "Next",
            ),
          ],
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
        //_timestamp=Timestamp.fromMicrosecondsSinceEpoch(picked!.microsecondsSinceEpoch,);
      });
    }
  }

  Future selectTime(BuildContext ctx) async {
    pikedTime = (await showTimePicker(
      context: ctx,
      initialTime: time,
    ))!;

    if(pikedTime!=null)
      setState(() {
        time=pikedTime;
        _timeControll.text='${time.hour}:${time.minute}  ${time.period.index==0?'AM':"PM"}';
      });
  }
}
