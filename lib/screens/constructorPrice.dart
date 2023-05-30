import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:light_shop/components/textOfConstructor.dart';

import '../components/MyDropdown.dart';
import '../components/lightDynamics.dart';

class ConstructorPrice extends StatefulWidget {
  const ConstructorPrice({super.key});

  @override
  State<ConstructorPrice> createState() => _ConstructorPriceState();
}

// нужно
class _ConstructorPriceState extends State<ConstructorPrice> {
  final GlobalKey<_ConstructorPriceState> containerState =
      GlobalKey<_ConstructorPriceState>();
  final TextEditingController _metrEditingController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool? _isChecked;
  final double priceOfMontaj = 3;
  final double priceOfLightDynamic = 3;
  final List<double> priceOfLed = [5.9, 7, 10, 4];
  List<String>? ledType = [''];
  double? _totalPrice;

  @override
  void initState() {
    super.initState();
    _selectedImage = 'assets/images/02.jpeg';
    _metrEditingController.text = '0';
    _isChecked = false;
    _lightDynamicsData = '0';
  }

  String? _selectedImage;
  String? _colorData;
  String? _lightDynamicsData;
  List<double> price = [0, 0, 0, 1];

  List<String> titlePrice = [
    "Бахрома 5.0х0.5 м",
    "LED гирлянда",
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

  // нужно

  void dropdownButtonPress(String value) {
    setState(() {
      ledType!.add(value);
      _colorData = value;
    });
  }

// нужно
  void lightDynaMicsPress(String value) {
    setState(() {
      _lightDynamicsData = value;
    });
  }

  // нужно
  void changePrice(int index) {
    if (_colorData == '1' || _colorData == '2' || _colorData == '3') {
      if (_lightDynamicsData == '0' || _lightDynamicsData == null) {
        setState(() {
          if (_isChecked! == true) {
            price[index] =
                priceOfLed[index] * int.parse(_metrEditingController.text) +
                    (priceOfMontaj * int.parse(_metrEditingController.text));
          } else {
            price[index] =
                priceOfLed[index] * int.parse(_metrEditingController.text);
          }
        });
        // цена * метр + цена монтажа для каждого метра + цвет динамики
      } else if (_lightDynamicsData == '1') {
        setState(() {
          if (_isChecked! == true) {
            price[index] =
                priceOfLed[index] * int.parse(_metrEditingController.text) +
                    (priceOfMontaj +
                        int.parse(_metrEditingController.text) +
                        priceOfLightDynamic *
                            int.parse(_metrEditingController.text));
          } else {
            price[index] = priceOfLed[index] *
                    int.parse(_metrEditingController.text) +
                priceOfLightDynamic * int.parse(_metrEditingController.text);
          }
        });
      }
    }

    setState(() {
      _totalPrice = price[0] + price[1] + price[2] + price[3];
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference productCollection = firestore.collection('orders');

// нужно
    Future<Future<DocumentReference<Object?>>> addData() async {
      return productCollection.add({
        "name": _nameController.text,
        "phone_number": _phoneController.text,
        "total_price": _totalPrice,
        "total_metr": _metrEditingController.text,
        "is_need_install": _isChecked,
        "is_light_dynamic": _lightDynamicsData,
        'Led_Type': ledType,
      }).whenComplete(() => showBottomSheet(
            context: context,
            builder: (context) {
              return Center(
                child: Container(
                  child: Column(children: [
                    Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 50),
                    MyCustomText(
                        text:
                            'Спасибо за ваше доверия в скором времени с вами свяжутся наши менеджеры. Ожидайте.',
                        isBigText: true),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          containerState.currentState?.dispose();
                          Navigator.pop(context);
                        });
                      },
                      child: Text('Закрыть'),
                    ),
                  ]),
                ),
              );
            },
          ));
      // .then((value) => print('product added'))
      // .catchError((error) => print('failed to add product:$error'));
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Рассчет стоимости',
          ),
          const SizedBox(height: 20),
          const Text(
            'Купить подсветку для фасада дома. Расчет стоимости онлайн',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),

          // начало рассчет метров
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    const Text('Введите периметр вашей крыши:'),
                    const SizedBox(width: 10),
                    TextField(
                      controller: _metrEditingController,
                      maxLength: 3,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      decoration: InputDecoration(
                        constraints:
                            const BoxConstraints(maxHeight: 30, maxWidth: 80),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      const Text('Мне нужен монтаж'),
                      Checkbox(
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ), // виджет записывание метров

          // начало флекс элементы картинки и информации о покупке гирлянд
          Padding(
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
                            MyCustomText(
                                text: 'Светодинамика', isBigText: true),
                            MyCustomText(text: 'Стоимость', isBigText: true),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            SizedBox(
                              width: 70,
                              child: GestureDetector(
                                onTap: () {
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
                        const SizedBox(height: 50),
                        Row(
                          children: [
                            SizedBox(
                              width: 70,
                              child: GestureDetector(
                                onTap: () {
                                  changeImage(1);
                                },
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: MyCustomText(
                                      text: titlePrice[1], isBigText: false),
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
                              child: Text('${price[1]}'),
                              onPressed: () {
                                changePrice(1);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        Row(
                          children: [
                            SizedBox(
                              width: 70,
                              child: GestureDetector(
                                onTap: () {
                                  changeImage(2);
                                },
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: MyCustomText(
                                      text: titlePrice[2], isBigText: false),
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
                              child: Text('${price[2]}'),
                              onPressed: () {
                                changePrice(2);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        Row(
                          children: [
                            SizedBox(
                              width: 70,
                              child: GestureDetector(
                                onTap: () {
                                  changeImage(3);
                                },
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: MyCustomText(
                                      text: titlePrice[3], isBigText: false),
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
                              child: Text('${price[3]}'),
                              onPressed: () {
                                changePrice(3);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyCustomText(
                                text: 'Итоговая стоимость:', isBigText: true),
                            const SizedBox(width: 20),
                            Text("$_totalPrice BYN"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // конеч флекс элементы картинки и информации о покупке гирлянд
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 250,
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    constraints: BoxConstraints(maxHeight: 40),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    labelText: 'Имя',
                    hintText: 'Имя',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: _phoneController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  decoration: const InputDecoration(
                    constraints: BoxConstraints(maxHeight: 40),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    labelText: 'номер телефона',
                    hintText: '375259412499',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: addData,
                    child: const Text('отправить'),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
