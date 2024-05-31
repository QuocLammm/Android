import 'package:flutter/material.dart';
import 'package:btl/bai_tap_lon/firebase/model.dart';

class UpdateAddress extends StatefulWidget {
  final Address address;

  const UpdateAddress({Key? key, required this.address}) : super(key: key);

  @override
  _UpdateAddressState createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _noteController;
  late bool isDefaultAddress;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.address.name);
    _phoneController = TextEditingController(text: widget.address.phone);
    _addressController = TextEditingController(text: widget.address.address);
    _noteController = TextEditingController(text: widget.address.note);
    isDefaultAddress = widget.address.isDefault?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cập nhật địa chỉ'),
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
                  Address updatedAddress = Address(
                    id: widget.address.id,
                    name: _nameController.text,
                    phone: _phoneController.text,
                    address: _addressController.text,
                    note: _noteController.text,
                    isDefault: isDefaultAddress,
                  );

                  // Thực hiện cập nhật địa chỉ trong Firebase
                  await Address.updateAddress(updatedAddress);

                  // Đóng trang và hiển thị thông báo Snackbar
                  Navigator.pop(context, updatedAddress);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Địa chỉ đã được cập nhật'),
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

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}
