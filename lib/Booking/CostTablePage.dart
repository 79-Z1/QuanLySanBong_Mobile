import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quanlysanbong/Firebase/Connect_Firebase.dart';
import 'package:quanlysanbong/Firebase/JoinTable.dart';

class FireBaseCostTable extends StatelessWidget {
  String? maSan;
  FireBaseCostTable(
      {Key? key,
        required this.maSan,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        builder: (context) => PageCostTable(
          maSan: maSan,
        ),
        errorMessage: "Lỗi kết nối với firebase!",
        connectingMessage: "Vui lòng đợi kết nối!"
    );
  }
}
class PageCostTable extends StatefulWidget {
  String? maSan;
  PageCostTable({Key? key, required this.maSan}) : super(key: key);

  @override
  State<PageCostTable> createState() => _PageCostTableState();
}

class _PageCostTableState extends State<PageCostTable> {
  String? maSan;
  final NumberFormat usCurrency = NumberFormat('#,##0', 'en_US');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 60,),
            Text("Bảng giá sân",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
      body:Column(
        children: [
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Giờ",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Giá theo giờ",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Expanded(
            child: StreamBuilder(
              stream: JoinTable.BangGiaSanFromMaSan(maSan!),
              builder: (context, snapshot) {
                if(snapshot.hasError) {
                  print("Lỗi nè");
                  print(snapshot.error);
                  return const Center(
                    child: Text("Lỗi dữ liệu Firebase",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else if(!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }else {
                  var list = snapshot.data!;
                  return ListView.separated(
                    itemBuilder: (context, index) =>
                        Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("${list[index]['Gio']}",
                                style: TextStyle(
                                  fontSize: 25,

                                ),
                              ),
                              Text("${usCurrency.format(int.parse(list[index]['GiaTheoGio']))} vnđ",
                                style: TextStyle(
                                  fontSize: 25,

                                ),
                              ),
                            ],
                          ),
                        ),
                    separatorBuilder: (context, index) => Divider(thickness: 2),
                    itemCount: list.length,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    maSan = widget.maSan;
  }
}
