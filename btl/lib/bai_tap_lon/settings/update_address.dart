import 'package:btl/bai_tap_lon/firebase/model.dart';
import 'package:flutter/material.dart';
import 'package:btl/bai_tap_lon/settings/create_address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryAddressPage extends StatefulWidget {
  @override
  _DeliveryAddressPageState createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
  // List to hold addresses
  List<Address> addresses = [];

  @override
  void initState() {
    super.initState();
    loadAddresses();
  }

  // Hàm để tải dữ liệu địa chỉ từ Firestore
  void loadAddresses() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Addresses').get();
      setState(() {
        addresses = querySnapshot.docs
            .map((doc) => Address.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });

      // Log để kiểm tra dữ liệu đã được tải thành công hay không
      print('Loaded addresses: $addresses');
    } catch (e) {
      print('Error loading addresses: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã xảy ra lỗi khi tải danh sách địa chỉ'),
        ),
      );
    }
  }

  void saveAddress(Address address) async {
    try {
      // Thêm địa chỉ mới vào Firestore và nhận về ID của tài liệu được thêm
      DocumentReference docRef = await FirebaseFirestore.instance.collection('Addresses').add(address.toJson());
      // Cập nhật ID của địa chỉ mới trong danh sách địa chỉ local
      address.id = docRef.id;
      // Thêm địa chỉ mới vào danh sách địa chỉ local để hiển thị ngay lập tức
      setState(() {
        addresses.add(address);
      });
      // Hiển thị thông báo Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Địa chỉ mới đã được thêm'),
        ),
      );
    } catch (e) {
      print('Error saving address: $e');
      // Hiển thị thông báo Snackbar nếu có lỗi xảy ra
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã xảy ra lỗi khi thêm địa chỉ mới $e'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Địa chỉ giao hàng',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      Address address = addresses[index];
                      return Column(
                        children: [
                          AddressWidget(address: address),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.red,
                ),
                child: TextButton(
                  onPressed: () async {
                    List<Address>? result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddNewAddressPage()),
                    );

                    if (result != null && result.isNotEmpty) {
                      setState(() {
                        Address newAddress = result.first;
                        saveAddress(newAddress); // Save the new address to Firestore
                        //addresses.add(newAddress);
                        //
                        loadAddresses();


                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: Text(
                      'Thêm địa chỉ mới',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressWidget extends StatelessWidget {
  final Address address;

  const AddressWidget({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                padding: EdgeInsets.all(8),
                child: Icon(Icons.home, color: Colors.white),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(address.name),
                    Text(address.address),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1, thickness: 1),
      ],
    );
  }
}
