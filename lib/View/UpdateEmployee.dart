import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/Utils/Constant.dart';
import 'package:employeeattendance/Utils/SharedPrefrence.dart';
import 'package:employeeattendance/ViewModels/UpdateEmployeeViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateEmployee extends StatefulWidget{
  @override
  _UpdateEmployeeState createState() => _UpdateEmployeeState();
}

class _UpdateEmployeeState extends State<UpdateEmployee> {

  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController salaryController = TextEditingController();



  @override
  Widget build(BuildContext context) {
   return Consumer<UpdateEmployeeViewModel>(
        builder: (context, model, child) {
          WidgetsBinding.instance.addPostFrameCallback((_){
            // Add Your Code here.
            if(model.loadingStatus==LoadingStatus.completed){
              nameController.clear();
              codeController.clear();
              salaryController.clear();
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
                'تعديل عامل',
                style: TextStyle(color: Colors.black),
              ),
              elevation: 4,
            ),
            body:
            Stack(
                  children: <Widget>[
                    Form(
                      key: formKey,
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 16,right: 16,top: 32),
                            child: TextFormField(
                              autofocus: false,
                              controller: nameController,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "من فضلك إملأ كل الحقول";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "اسم العامل",
                                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16,right: 16,top: 8),
                            child: TextFormField(
                              autofocus: false,
                              controller: codeController,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "من فضلك إملأ كل الحقول";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "كود العامل",

                                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16,right: 16,top: 8),
                            child: TextFormField(
                              autofocus: false,
                              obscureText: false,
                              controller: salaryController,
                              keyboardType: TextInputType.number,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "من فضلك إملأ كل الحقول";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "  المرتب",
                                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: model.loadingStatus==LoadingStatus.error,
                            child:Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(model.error,
                                  style:
                                  TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Cairo",color: Colors.red),)),
                          ),
                          Visibility(
                            visible: model.loadingStatus==LoadingStatus.completed,
                            child:Container(
                                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                                child: Center(
                                  child: Text("تم تعديل العامل بنجاح",
                                    style:
                                    TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Cairo",color: Colors.green),),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 50.0),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    print("passed validation");

                                    StorageUtil.getInstance().then((storage){
                                      String token=  StorageUtil.getString(Constant.SHARED_USER_TOKEN);
                                      Provider.of<UpdateEmployeeViewModel>(context, listen: false).doUpdateClientDetails(
                                          token,nameController.text
                                          ,codeController.text,salaryController.text);
                                    });

                                  }
                                },
                                padding: EdgeInsets.only(left: 32,right: 32,top: 12,bottom: 12),
                                color:AppProperties.navylogo,
                                child: Text("تعديل  عامل", style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          )
                        ],
                      ),
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

                  ],
                )
          );
        });

  }
}