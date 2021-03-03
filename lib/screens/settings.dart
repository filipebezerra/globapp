import 'package:flutter/material.dart';
import '../data/SharedPrefsSettings.dart';
import '../models/font_size.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int settingColor = 0xff1976d2;
  double settingFontSize = 16;
  List<int> colors = [
    0xff455a64,
    0xffffc107,
    0xff673ab7,
    0xfff57c00,
    0xff795548
  ];
  List<FontSize> fontSizes = [
    FontSize('Small', 12),
    FontSize('Medium', 14),
    FontSize('Large', 16),
    FontSize('Extra-Large', 20),
  ];
  SharedPrefsSettings settings;

  @override
  void initState() {
    settings = SharedPrefsSettings();
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        settingFontSize = settings.getFontSize();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Color(settingColor),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Select main Color",
            style: TextStyle(fontSize: settingFontSize),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => setColor(colors[0]),
                child: ColorSquare(colors[0]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[1]),
                child: ColorSquare(colors[1]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[2]),
                child: ColorSquare(colors[2]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[3]),
                child: ColorSquare(colors[3]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[4]),
                child: ColorSquare(colors[4]),
              ),
            ],
          ),
          Text(
            "Choose main font size",
            style: TextStyle(fontSize: settingFontSize),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton<String>(
                value: settingFontSize.toString(),
                elevation: 16,
                items: fontSizes.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value.size.toString(),
                    child: Text(value.name),
                  );
                }).toList(),
                onChanged: (v) => setFontSize(double.tryParse(v)),
              )
            ],
          )
        ],
      ),
    );
  }

  void setColor(int color) {
    settings.setColor(color);
    setState(() {
      settingColor = color;
    });
  }

  void setFontSize(double newFontSize) {
    settings.setFontSize(newFontSize);
    setState(() {
      settingFontSize = newFontSize;
    });
  }
}

class ColorSquare extends StatelessWidget {
  final int colorCode;

  ColorSquare(this.colorCode);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Color(colorCode),
      ),
    );
  }
}
