import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/Utils/Constant.dart';
import 'package:employeeattendance/Utils/SharedPrefrence.dart';
import 'package:employeeattendance/ViewModels/AddEmployeeViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEmployee extends StatefulWidget{
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {

  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  String SelectedText="عامل";



  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return
       Consumer<AddEmployeeViewModel>(
      builder: (context, model, child) {

        WidgetsBinding.instance.addPostFrameCallback((_){
          // Add Your Code here.
          if(model.loadingStatus==LoadingStatus.completed){
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
             'اضف عامل',
             style: TextStyle(color: Colors.black),
           ),
           elevation: 4,
         ),
         body: Form(
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
                   keyboardType: TextInputType.number,
                   validator: (String value) {
                     if (value.isEmpty) {
                       return "من فضلك إملأ كل الحقول";
                     }
                   },
                   controller: passController,
                   decoration: InputDecoration(
                     hintText: " رقم المرور",
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
               Center(
                 child: Padding(
                   padding: EdgeInsets.only(left: 32,right: 32,top: 8),
                   child: DropdownButton<String>(
                     hint: Text(SelectedText),
                     items: <String>['عامل', 'مشرف'].map((String value) {
                       return  DropdownMenuItem<String>(
                         value: value,
                         child: new Text(value),
                       );
                     }).toList(),
                     onChanged: (String value) {
                       setState(() {
                         this.SelectedText=value;
                       });
                     },
                   ),
                 ),
               ),
               Visibility(
                 visible:LoadingStatus.searching==model.loadingStatus,
                 child: Center(child: CupertinoActivityIndicator()),
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
                     margin: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                     child: Center(
                       child: Text("تم تسجيل العامل بنجاح",
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
                           String type=SelectedText=="عامل"?"worker":"admin";
                           Provider.of<AddEmployeeViewModel>(context, listen: false).doCreateUser(token,nameController.text
                           ,codeController.text,passController.text,type,salaryController.text);
                         });

                       }
                     },
                     padding: EdgeInsets.only(left: 32,right: 32,top: 12,bottom: 12),
                     color:AppProperties.navylogo,
                     child: Text("اضف عامل", style: TextStyle(color: Colors.white)),
                   ),
                 ),
               )
             ],
           ),
         ),
       );

      });
  }
}