import 'package:employeeattendance/Utils/AppLocalization.dart';
import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/View/AdminView.dart';
import 'package:employeeattendance/View/EmployeeView.dart';
import 'package:employeeattendance/ViewModels/LoginViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
static String tag = 'login-page';
@override
_LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<Login> {
  var vm;
  var formKey = GlobalKey<FormState>();
  var _scaffFoledKey = GlobalKey<ScaffoldState>();
  bool _isLoading;
  TextEditingController codeController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<LoginViewModel>(context);
    _isLoading=false;
    final logo = Container(
      margin: EdgeInsets.only(top: 48),
      child: Image.asset("assets/images/logo.jpg"),

    );

    final code = Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        controller: codeController,
        keyboardType: TextInputType.number,
        autofocus: false,
        validator: (String value) {
          if (value.isEmpty) {
            return "من فضلك إملأ كل الحقول";
          }
        },
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context).translate("code"),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );

    final password = Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: TextFormField(
          autofocus: false,
          obscureText: true,
          controller: passController,
          keyboardType: TextInputType.number,
          validator: (String value) {
            if (value.isEmpty) {
              return "من فضلك إملأ كل الحقول";
            }
          },
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).translate("pass"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0)),
          ),
        )

    );

    final changePassword = FlatButton(
      child: Text(
        AppLocalizations.of(context).translate("changePassword"),
        style: TextStyle(color: AppProperties.lightnavylogo,
            fontWeight: FontWeight.w700,
            fontSize: 16,
            decoration: TextDecoration.underline),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminView()),
        );
      },
    );


    Widget loginBtn(BuildContext context,LoginViewModel model){
     return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () {
            if (formKey.currentState.validate()) {
              print("passed validation");
              print(codeController.text);
              print(passController.text);
              Provider.of<LoginViewModel>(context, listen: false).doLogin(
                  codeController.text, passController.text);

             }
            },
          padding: EdgeInsets.all(12),
          color: AppProperties.navylogo,
          child: Text(AppLocalizations.of(context).translate("sign"),
              style: TextStyle(color: Colors.white)),
        ),
      );
    }


    Widget form(BuildContext context,LoginViewModel model){
      return   Stack(children: <Widget>[
        Form(
        key: formKey,
        child: Center(
          child: ListView(
            children: <Widget>[
              logo,
              SizedBox(height: 32.0),
              code,
              SizedBox(height: 8.0),
              password,
              Visibility(
                visible: error(model),
                child:Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(model.error,
                      style:
                      TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Cairo",color: Colors.red),)),
              ),
              SizedBox(height: 16.0),
              loginBtn(context, model),
            ],
          ),
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

      ],);

    }

    return Consumer<LoginViewModel>(
      builder: (context, model, child){

        WidgetsBinding.instance.addPostFrameCallback((_){
          // Add Your Code here.
          if(model.loadingStatus==LoadingStatus.completed){
            model.loadingStatus=LoadingStatus.empty;
            if(model.user_type=="admin"){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AdminView()),
              );
            }
            else{
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => EmployeeView()),
              );
            }
            //clear value
          }
        });
        return Scaffold(
          key: _scaffFoledKey,
          body: form(context, model),
        );
      }
      // Build the expensive widget here.
    );

//    return Scaffold(
//        key: _scaffFoledKey,
//        backgroundColor: Colors.white,
//        body: form
//
//    );

//    return Consumer<LoginViewModel>(
//      builder: (context, model, child) {
//            return Scaffold(
//        key: _scaffFoledKey,
//        backgroundColor: Colors.white,
//        body: formnew(context,model)
//            );
//            },
//    );
  }

  bool isVisable(LoginViewModel vs) {
    bool v=false;

    if(vs.loadingStatus==LoadingStatus.searching){
      print("seracho");
      v=true;

    }
    else if(vs.loadingStatus==LoadingStatus.completed){
      print("complete call");
      v=false;
    }

    else if (vs.loadingStatus==LoadingStatus.error){
      //showInSnackBar("حدث خطأ ما تحقق منن الانترنت وحاول مره أخر'");
    }

    else if(vs.loadingStatus==LoadingStatus.empty){
      print("empty");
    }
    return v;

  }

  error(LoginViewModel vs) {
    bool v=false;
    if (vs.loadingStatus==LoadingStatus.error){
      v=true;
    }
    return v;
  }

  Widget showInSnackBar(String value,var key,BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
          return key.currentState.showSnackBar(SnackBar(
            key: key,
              content: new Text(value)));
          }
        );
      }
//
  void showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('حدث خطأ ما تحقق منن الانترنت وحاول مره أخري'),
        action: SnackBarAction(
            label: 'موافق', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }





}
