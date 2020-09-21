
import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:study_deer/res/colours.dart';
import 'package:study_deer/res/gaps.dart';
import 'package:study_deer/res/styles.dart';

import '../../res/colours.dart';
import '../../res/styles.dart';
import 'register_page.dart';


class SMSLoginPage extends StatefulWidget {
  @override
  _SMSLoginPageState createState() => _SMSLoginPageState();
}

class _SMSLoginPageState extends State<SMSLoginPage> {

  final TapGestureRecognizer _registerRecognizer = TapGestureRecognizer();

  bool _smsClickable = true;

  //定义计时变量
  Timer _timer;
  int _countdownTime = 20;

  @override
  void initState() {
    _registerRecognizer.onTap = (){
      // print('_registerRecognizer tap');
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_)=>RegisterPage()
          )
      );
    };
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: _buildBody()
    );
  }

  void startCountdownTimer(){
    const oneSec = const Duration(seconds: 1);

    var callback = (timer){
      setState(() {
        if(_countdownTime < 1){
          _timer?.cancel();
          _smsClickable = true;
          _countdownTime = 20;
          print('恢复成功');


        }else{
          _countdownTime = _countdownTime-1;
          _smsClickable = false;
          print(_countdownTime);
        }
      });
    };
    _timer = Timer.periodic(oneSec, callback);
  }


  _buildBody(){
    return SingleChildScrollView(
      child:Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.centerLeft,
              child: Text(
                '验证码登录',
                style: TextStyles.textBold24,
              ),
            ),
            TextField(
              keyboardType:TextInputType.number,
              decoration: InputDecoration(
                  hintText: '请输入手机号',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colours.app_main,
                          width: 0.5
                      )
                  ),
                  enabledBorder:UnderlineInputBorder(
                      borderSide:  BorderSide(
                          color: Colors.grey.shade300
                      )
                  )

              ),
            ),

            Gaps.vGap16,

            Stack(
              children: [
                TextField(
                  decoration: InputDecoration(
                      hintText: '请输入验证码',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colours.app_main,
                              width: 0.5
                          )
                      ),

                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade300
                          )
                      )
                  ),
                ),

                //获取验证码
                Container(
                  height: 30,
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    disabledColor:Colors.grey,
                    disabledTextColor: Colours.bg_color,
                    textColor: _smsClickable ? Colours.app_main:Colors.white,
                    // color: _smsClickable ? Colours.bg_color : Colours.text_gray,
                    splashColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side:BorderSide(width: 0.5,color: Colours.app_main),
                    ),
                    onPressed: _smsClickable ?
                    (){
                      setState(() {
                        startCountdownTimer();
                      });
                    }:null,

                    child:Text(
                      _smsClickable ? '获取验证码':'$_countdownTime'+' s',
                      style: TextStyle(
                          // color: _smsClickable ? Colours.app_main:Colors.white,
                          fontSize: 12,
                          // backgroundColor:_smsClickable ? Colors.white:Colours.bg_gray_,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Gaps.vGap16,

            Container(
                // padding: EdgeInsets.all(12),
              alignment: Alignment.centerLeft,
                child:
                    RichText(
                        text:TextSpan(
                            children:[
                              TextSpan(text:'提示：未注册账号的手机号，请先',style: TextStyles.textGray14),
                              TextSpan(
                                  text:'注册',
                                  style: TextStyle(color: Colours.app_main),
                                recognizer: _registerRecognizer,
                              ),
                            ]
                        )

                    ),

            ),


            Gaps.vGap16,

            Container(
              height: 44,
              width: double.infinity,
              child: FlatButton(
                  // highlightColor:Colorss.transparent,
                onPressed:(){

                },
                color: Colors.blue,
                child: Text('登录',style: TextStyle(color: Colors.white,fontSize:18),),
              ),
            ),


            GestureDetector(
              onTap: (){
                print('GestureDetector');
              },
              child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(12),
                  child: Text('忘记密码')),
            ),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if(_timer != null){
      _timer.cancel();
    }
    super.dispose();
  }
}
