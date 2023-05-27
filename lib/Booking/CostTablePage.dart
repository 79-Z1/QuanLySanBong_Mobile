import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bảng giá sân"),
      ),
      body:StreamBuilder(
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
                    child: Row(
                      children: [
                        Text("${list[index]['Gio']}"),
                        Text("${list[index]['GiaTheoGio']}"),
                      ],
                    ),
                  ),
              separatorBuilder: (context, index) => Divider(thickness: 2),
              itemCount: list.length,
            );
          }
        },
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
