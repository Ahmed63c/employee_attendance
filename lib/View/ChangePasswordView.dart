import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/Utils/Constant.dart';
import 'package:employeeattendance/Utils/SharedPrefrence.dart';
import 'package:employeeattendance/ViewModels/ChangePasswordViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget{
  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {

  final controller = TextEditingController();
  final controllerPass = TextEditingController();

  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangePasswordViewModel>(
      builder: (context,model,child){


        WidgetsBinding.instance.addPostFrameCallback((_){
          // Add Your Code here.
          if(model.loadingStatus==LoadingStatus.completed){
            controller.clear();
            controllerPass.clear();
            model.loadingStatus=LoadingStatus.empty;
          }
        });
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            title: Text(
              ' تغيير كلمة المرور',
              style: TextStyle(color: Colors.black),
            ),
            elevation: 4,
          ),
          body: Stack
            (children: <Widget>[
            ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16,right: 16,top: 64),
                  child: TextFormField(
                    autofocus: false,
                    obscureText: false,
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "كود العامل",
                      errorText: _validate ? 'لا يمكن ان يكون الحقل فارغا' : null,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16,right: 16,top: 16),
                  child: TextFormField(
                    autofocus: false,
                    obscureText: false,
                    controller: controllerPass,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "رقم المرور ",
                      errorText: _validate ? 'لا يمكن ان يكون الحقل فارغا' : null,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                ),
                Visibility(
                  visible: model.loadingStatus==LoadingStatus.error,
                  child:Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Text(model.error,
                          style:
                          TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Cairo",color: Colors.red),),
                      )),
                ),
                Visibility(
                  visible: model.loadingStatus==LoadingStatus.completed,
                  child:Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child:  Center(
                        child: Text("تم تعديل رقم المرور بنجاح",
                          style:
                          TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Cairo",color: Colors.green),),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0,horizontal: 32),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    onPressed: () {
                      setState(() {
                        controller.text.isEmpty ? _validate = true : _validate = false;
                      });

                      if(!_validate){
                        StorageUtil.getInstance().then((storage){
                          String token=  StorageUtil.getString(Constant.SHARED_USER_TOKEN);
                          Provider.of<ChangePasswordViewModel>(context, listen: false).doChangePassword(
                              token,controller.text,controllerPass.text);
                        });

                      }
                    },
                    padding: EdgeInsets.only(left: 32,right: 32,top: 12,bottom: 12),
                    color:AppProperties.lightnavylogo,
                    child: Text(" تأكيد", style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
            Visibility(
                visible:LoadingStatus.searching==model.loadingStatus,
                child:Stack(children: <Widget>[
                  Container(width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black12,),
                  Align(
                      alignment: Alignment.center,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[ CupertinoActivityIndicator(radius: 16,),Text("تحميل...")])),

                ],))
          ],)
        );
      },
    );

  }
}