import 'package:btl/bai_tap_lon/settings/page_address.dart';
import 'package:flutter/material.dart';


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Nhận thông báo'),
              trailing: NotificationSwitch(),
            ),
            Divider(),
            ListTile(
              title: Text('Thay đổi ngôn ngữ'),
              trailing: LanguageDropdown(),
            ),
            Divider(),
            ListTile(
              title: Text('Địa chỉ giao hàng'),
              trailing: DeliveryAddressButton(),
            ),
            Divider(),
            ListTile(
              title: Center(child: Text('Xóa tài khoản', style: TextStyle(color: Colors.red))),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Xác nhận xóa tài khoản'),
                      content: Text('Bạn có chắc chắn muốn xóa tài khoản không? Hành động này không thể hoàn tác.'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Hủy'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Xóa', style: TextStyle(color: Colors.red)),
                          onPressed: () {
                            // Perform account deletion logic here
                            // For now, just pop the dialog
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Tài khoản đã bị xóa'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationSwitch extends StatefulWidget {
  @override
  _NotificationSwitchState createState() => _NotificationSwitchState();
}

class _NotificationSwitchState extends State<NotificationSwitch> {
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _notificationsEnabled,
      onChanged: (bool value) {
        setState(() {
          _notificationsEnabled = value;
        });
        // Implement logic to enable/disable notifications
      },
    );
  }
}

class LanguageDropdown extends StatefulWidget {
  @override
  _LanguageDropdownState createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String _selectedLanguage = 'Tiếng Việt';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedLanguage,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedLanguage = newValue;
          });
          // Implement logic to change language
        }
      },
      items: <String>['Tiếng Việt', 'English']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class DeliveryAddressButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_forward),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DeliveryAddressPage()),
        );
      },
    );
  }
}


