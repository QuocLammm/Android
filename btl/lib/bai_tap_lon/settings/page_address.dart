import 'package:btl/bai_tap_lon/firebase/model.dart';
import 'package:flutter/material.dart';
import 'package:btl/bai_tap_lon/settings/create_address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:btl/bai_tap_lon/settings/update_address.dart'; // Import trang UpdateAddress

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
  void loadAddresses() {
    Address.getAllAddresses().listen((addressList) {
      setState(() {
        addresses = addressList;
      });

      // Log để kiểm tra dữ liệu đã được tải thành công hay không
      print('Loaded addresses: $addresses');
    }).onError((e) {
      print('Error loading addresses: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã xảy ra lỗi khi tải danh sách địa chỉ'),
        ),
      );
    });
  }

  void saveAddress(Address address) async {
    try {
      // Thêm địa chỉ mới vào Firestore và nhận về ID của tài liệu được thêm
      DocumentReference docRef = await Address.addAddress(address);
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

  void deleteAddress(String id) async {
    try {
      await Address.deleteAddress(id);
      setState(() {
        addresses.removeWhere((address) => address.id == id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Địa chỉ đã được xóa'),
        ),
      );
    } catch (e) {
      print('Error deleting address: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã xảy ra lỗi khi xóa địa chỉ $e'),
        ),
      );
    }
  }

  void confirmDeleteAddress(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận xóa'),
          content: Text('Bạn có chắc chắn muốn xóa địa chỉ này không?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
                deleteAddress(id); // Thực hiện xóa địa chỉ
              },
              child: Text('Xóa'),
            ),
          ],
        );
      },
    );
  }

  void editAddress(Address address) async {
    try {
      await Address.updateAddress(address);
      setState(() {
        int index = addresses.indexWhere((a) => a.id == address.id);
        if (index != -1) {
          addresses[index] = address;
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Địa chỉ đã được cập nhật'),
        ),
      );
    } catch (e) {
      print('Error updating address: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã xảy ra lỗi khi cập nhật địa chỉ $e'),
        ),
      );
    }
  }
    //
  void updateDefaultAddress(Address newAddress) async {
    // Tìm địa chỉ mặc định hiện tại
    Address? currentDefaultAddress;
    for (var addr in addresses) {
      if (addr.isDefault ?? false) {
        currentDefaultAddress = addr;
        break;
      }
    }

    // Nếu có địa chỉ mặc định hiện tại và địa chỉ mới không phải là địa chỉ mặc định hiện tại
    if (currentDefaultAddress != null && currentDefaultAddress.id != newAddress.id) {
      // Hủy bỏ trạng thái mặc định của địa chỉ mặc định hiện tại
      currentDefaultAddress.isDefault = false;
      await Address.updateAddress(currentDefaultAddress);
    }

    // Thực hiện việc đặt địa chỉ mới hoặc mới cập nhật thành địa chỉ mặc định
    newAddress.isDefault = true;
    await Address.updateAddress(newAddress);

    // Cập nhật danh sách địa chỉ và hiển thị thông báo
    setState(() {
      int index = addresses.indexWhere((a) => a.id == newAddress.id);
      if (index != -1) {
        addresses[index] = newAddress;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Địa chỉ đã được cập nhật'),
      ),
    );
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
                      return Slidable(
                        key: ValueKey(address.id),
                        endActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          extentRatio: 0.5,
                          children: [
                            SlidableAction(
                              onPressed: (context) async {
                                Address? updatedAddress = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateAddress(address: address),
                                  ),
                                );
                                if (updatedAddress != null) {
                                  editAddress(updatedAddress);
                                }
                              },
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Chỉnh sửa',
                            ),
                            SlidableAction(
                              onPressed: (context) => confirmDeleteAddress(address.id),
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Xóa',
                            ),
                          ],
                        ),
                        child: AddressWidget(address: address),
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
                    Address? newAddress = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddNewAddressPage()),
                    );
                    if (newAddress != null) {
                      saveAddress(newAddress); // Save the new address to Firestore
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
              if (address.isDefault ?? false) // Kiểm tra nếu là địa chỉ mặc định
                Text(
                  'Mặc định',
                  style: TextStyle(color: Colors.green, fontSize: 13), // Màu xanh, font size nhỏ
                ),
            ],
          ),
        ),
        Divider(height: 1, thickness: 1),
      ],
    );
  }
}

