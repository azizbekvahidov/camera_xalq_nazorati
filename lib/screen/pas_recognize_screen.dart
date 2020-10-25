import 'package:flutter/material.dart';
import '../widget/custom_appBar.dart';
import '../widget/default_button.dart';
import '../widget/default_input.dart';
import '../widget/main_text.dart';
import "camera_page.dart";
import "android_camera.dart";
import 'dart:io';
 
class PasRecognizeScreen extends StatefulWidget {
  static const routeName = "/register-pass-recognize";
  @override
  _PasRecognizeScreenState createState() => _PasRecognizeScreenState();
}
 
class _PasRecognizeScreenState extends State<PasRecognizeScreen> {
  var seriesController = TextEditingController();
  var pnflController = TextEditingController();
  bool _value = false;
 
  void dispose() {
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final PreferredSizeWidget appBar =
        CustomAppBar(title: "Идентификация пользователя");
    return Scaffold(
      backgroundColor: Color(0xffF5F6F9),
      appBar: appBar,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: mediaQuery.size.height - mediaQuery.size.height * 0.12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainText("ПИНФЛ"),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color(0xffF5F6F9),
                        borderRadius: BorderRadius.circular(22.5),
                        border: Border.all(
                          color: Color.fromRGBO(178, 183, 208, 0.5),
                          style: BorderStyle.solid,
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: (mediaQuery.size.width -
                                    mediaQuery.padding.left -
                                    mediaQuery.padding.right) *
                                0.77,
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                TextField(
                                  controller: pnflController,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(top: 0, bottom: 9),
 
                                    border: InputBorder.none,
                                    hintText: "Введите ПИНФЛ",
                                    hintStyle: Theme.of(context).textTheme.display1,
                                  ),
                                ),
                                InkWell(
                                    onTap: () async {
                                      final res = await Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => Platform.isAndroid ? AndroidCameraPage() : CameraScreen())
                                      );
                                      if (res != null) {
                                        setState(() {
                                          pnflController.text = res.personalNumber;
                                          seriesController.text = res.documentNumber;
                                        });
                                      }
                                    },
                                    child: Container(
                                    width: 50,
                                    height: 60,
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(19),
                                        border: Border.all(
                                            color:
                                                Color.fromRGBO(49, 59, 108, 0.5),
                                            style: BorderStyle.solid,
                                            width: 2),
                                      ),
                                      child:Text(
                                        "?",
                                        style: TextStyle(
                                          fontFamily: "Gilroy",
                                          fontSize: 13,
                                          color: Color.fromRGBO(49, 59, 108, 0.5),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    )
                                  ),
                                ),
                              ]
                            ),
                          ),
                        ],
                      ),
                    ),
                    MainText("Серия и номер паспорта"),
                    DefaultInput(
                        "Введите серию и номер паспорта", seriesController),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _value = !_value;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    style: BorderStyle.solid,
                                    color: Theme.of(context).primaryColor),
                                shape: BoxShape.circle,
                                color: _value
                                    ? Theme.of(context).primaryColor
                                    : Colors.transparent),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: _value
                                  ? Icon(
                                      Icons.check,
                                      size: 15.0,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      size: 15.0,
                                      color: Colors.transparent,
                                    ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          width: mediaQuery.size.width * 0.75,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Я согласен на использование моей личной информации",
                                style: TextStyle(
                                  fontFamily: "Gilroy",
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(38),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: !_value
                              ? DefaultButton(
                                  "Продолжить",
                                  () {},
                                  Color(0xffB2B7D0),
                                )
                              : DefaultButton("Продолжить", () {
                                  // sendData().then((value) {
                                  setState(() {
                                    _value = !_value;
                                  });
                                  // });
                                }, Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}