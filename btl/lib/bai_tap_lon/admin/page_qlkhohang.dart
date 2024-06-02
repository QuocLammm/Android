import 'package:btl/bai_tap_lon/admin/page_qlsanpham.dart';
import 'package:btl/bai_tap_lon/firebase/model.dart';
import 'package:flutter/material.dart';

class PageQuanLyKhoHang extends StatelessWidget {
  List imgName = ['Cà phê','Trà giải nhiệt','Bánh ngọt','Nước ép'];
  List imgList =['hinh-anh-ly-ca-phe.jpg','tdao.png','banh_ngot.png','ep.png'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kho hàng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: (MediaQuery.of(context).size.height-50-25)/(4*240),
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  List<dynamic> products;
                  switch (index) {
                    case 0:
                      products = await DrinkSnapshot.getAllOnce();
                      break;
                    case 1:
                      products = await DrinkTeaSnapshot.getAllOnce();
                      break;
                    case 2:
                      products = await CakeSnapshot.getAllOnce();
                      break;
                    case 3:
                      products = await JuiceSnapshot.getAllOnce();
                      break;
                    default:
                      products = [];
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageQLySanPham(products: products),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset("asset/images/${imgList[index]}",height: 120,),
                      ),
                      SizedBox(height: 10,),
                      Text(imgName[index],style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.6)
                      ),)
                    ],
                  ),
                ),
              );
            },),
      ),
    );
  }
}
