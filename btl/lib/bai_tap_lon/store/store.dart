import 'package:flutter/material.dart';

class StoreIntroductionPage extends StatelessWidget {
  const StoreIntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cửa hàng'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Welcome to Our Store!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'asset/images/store.jpg',
                  height: 200,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Giới thiệu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Cửa hàng của chúng tôi cung cấp nhiều loại nước uống và bánh ngọt để đáp ứng nhu cầu của bạn'
                    'Chúng tôi cam kết mang đến cho khách hàng những sản phẩm và dịch vụ có chất lượng tốt nhất. '
                    'Nhiệm vụ của chúng tôi là làm cho trải nghiệm mua sắm của bạn trở nên thú vị và thuận tiện nhất có thể.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Email: LPT@store.com\nPhone: (+84) 815597300\nAddress: 24-25 Nguyễn Đình Chiểu, p.Vĩnh Phước, tp.Nha Trang, Khánh Hòa',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}