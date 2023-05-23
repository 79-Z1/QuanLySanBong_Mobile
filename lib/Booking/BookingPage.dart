import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quanlysanbong/Firebase/Connect_Firebase.dart';

class FireBaseBooking extends StatelessWidget {
  const FireBaseBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        builder: (context) => PageBooking(),
        errorMessage: "Lỗi kết nối với firebase!",
        connectingMessage: "Vui lòng đợi kết nối!"
    );
  }
}



class PageBooking extends StatefulWidget {
  const PageBooking({Key? key}) : super(key: key);

  @override
  State<PageBooking> createState() => _PageBookingState();
}

class _PageBookingState extends State<PageBooking> {
  TextEditingController txtDateInput = TextEditingController();

  @override
  void initState() {
    txtDateInput.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đặt sân"),
      ),
      body: Column(
        children: [
          Container(
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      height:150,
                      width: 250,
                      child: TextField(
                        controller: txtDateInput, //editing controller of this TextField
                        decoration: InputDecoration(
                            icon: Icon(Icons.calendar_today), //icon of text field
                            labelText: "Ngày đặt" //label text of field
                        ),
                        readOnly: true,  //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context, initialDate: DateTime.now(),
                              firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101)
                          );

                          if(pickedDate != null ){
                            print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              txtDateInput.text = formattedDate; //set output date to TextField value.
                            });
                          }else{
                            print("Date is not selected");
                          }
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
