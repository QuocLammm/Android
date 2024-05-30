import 'package:btl/bai_tap_lon/firebase/model.dart';
import 'package:btl/bai_tap_lon/home/page_setting.dart';
import 'package:flutter/material.dart';

class AddNewAddressPage extends StatefulWidget {
  @override
  _AddNewAddressPageState createState() => _AddNewAddressPageState();
}

class _AddNewAddressPageState extends State<AddNewAddressPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  bool isDefaultAddress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm địa chỉ mới'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Họ và tên',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Số điện thoại',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Địa chỉ',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _noteController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Lưu ý',
                  hintText: 'Nhập lưu ý...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Đặt làm địa chỉ mặc định'),
                  Switch(
                    value: isDefaultAddress,
                    onChanged: (value) {
                      setState(() {
                        isDefaultAddress = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () async {
                  // Tạo một đối tượng Address từ các thông tin nhập vào
                  Address newAddress = Address(
                    // Không cần thiết lập ID, Firebase sẽ tự động tạo ra một ID duy nhất
                    name: _nameController.text,
                    phone: _phoneController.text,
                    address: _addressController.text,
                    note: _noteController.text,
                    isDefault: isDefaultAddress,
                  );

                  // Thêm địa chỉ mới vào Firebase
                  await Address.addAddress(newAddress);

                  // Đóng trang và hiển thị thông báo Snackbar
                  // Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()), // Chuyển sang trang SettingPage
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Địa chỉ mới đã được thêm'),
                    ),
                  );
                },
                child: Text(
                  'Lưu địa chỉ',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
