import 'package:btl/bai_tap_lon/widget/wrapper_data.dart';
import 'package:flutter/material.dart';

class MyGruopRadio extends StatefulWidget {
  List<String> lables;
  StringWrapper groupizo;
  bool? isHorri;


  MyGruopRadio({ required this.lables,  required this.groupizo,
    this.isHorri = true, super.key});
  //const MyGruopRadio({super.key});


  @override
  State<MyGruopRadio> createState() => _MyGruopRadioState();
}

class _MyGruopRadioState extends State<MyGruopRadio> {
  @override
  Widget build(BuildContext context) {
    if(widget.isHorri == true)
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _buildListRadio(),
      );
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildListRadio(),
      );
  }

  _buildListRadio(){
    return widget.lables.map(
            (lable) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio(
                value: lable,
                groupValue: widget.groupizo.value,
                onChanged: (value){
                  setState(() {
                    widget.groupizo.value = value;
                  });
                }
            ),
            Text(lable),
          ],
        )
    ).toList();
  }
}
