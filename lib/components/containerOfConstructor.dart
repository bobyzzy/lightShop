import 'package:flutter/material.dart';
import 'package:light_shop/components/MyDropdown.dart';
import 'package:light_shop/components/lightDynamics.dart';
import 'package:light_shop/components/textOfConstructor.dart';

class ContainerOfConstructor extends StatefulWidget {
  int metr;
  ContainerOfConstructor({super.key, required this.metr});

  @override
  State<ContainerOfConstructor> createState() => _ContainerOfConstructorState();
}

class _ContainerOfConstructorState extends State<ContainerOfConstructor> {
  String? _selectedImage;
  String? _colorData;
  String? _lightDynamicsData;
  List<double> price = [0, 0, 0, 1];

  List<String> titlePrice = [
    "Бахрома 5.0х0.5 м",
    "Ретро гирлянда",
    "Флекс неон",
    "Падающие капли",
  ];

  void changeImage(int index) {
    setState(() {
      if (index == 0) {
        _selectedImage = 'assets/images/baxroma.jpg';
      } else if (index == 1) {
        _selectedImage = 'assets/images/led.jpg';
      } else if (index == 2) {
        _selectedImage = 'assets/images/02.jpeg';
      } else if (index == 3) {
        _selectedImage = 'assets/images/failingDrops.jpg';
      }
    });
  }

  void dropdownButtonPress(String value) {
    setState(() {
      _colorData = value;
    });
  }

  void lightDynaMicsPress(String value) {
    setState(() {
      _lightDynamicsData = value;
    });
  }

  void changePrice(int index) {
    if (_colorData == '1' || _colorData == '2' || _colorData == '3') {
      if (_lightDynamicsData == '0' || _lightDynamicsData == null) {
        setState(() {
          price[0] = 10 * widget.metr + 100;
        });
      } else if (_lightDynamicsData == '1') {
        setState(() {
          price[0] = 10 * 40 + 100;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedImage = 'assets/images/02.jpeg';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // картинка которая справа
          Expanded(
            flex: 1,
            child: Image.asset(
              _selectedImage!,
              height: 500,
              fit: BoxFit.cover,
            ),
          ), // перечень расчетных данных
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyCustomText(text: 'Гирлянда', isBigText: true),
                      MyCustomText(text: 'Цвет', isBigText: true),
                      MyCustomText(text: 'Светодинамика', isBigText: true),
                      MyCustomText(text: 'Стоимость', isBigText: true),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 70,
                        child: GestureDetector(
                          onTap: () {
                            print(_colorData);
                            changeImage(0);
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: MyCustomText(
                                text: titlePrice[0], isBigText: false),
                          ),
                        ),
                      ),
                      const SizedBox(width: 70),
                      MyDropdown(callBack: (selectedValue) {
                        dropdownButtonPress(selectedValue);
                      }),
                      const SizedBox(width: 50),
                      LightDynamic(
                        callBack: (selectedValue) {
                          lightDynaMicsPress(selectedValue);
                        },
                      ),
                      const SizedBox(width: 100),
                      ElevatedButton(
                        child: Text('${price[0]}'),
                        onPressed: () {
                          changePrice(0);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
