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

    final loginButton = Padding(
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
            action(vm);
            Provider.of<LoginViewModel>(context, listen: false).doLogin(
                codeController.text, passController.text);
          }

//          Navigator.pushReplacement(
//            context,
//            MaterialPageRoute(builder: (context) => EmployeeView()),
//          );
        },
        padding: EdgeInsets.all(12),
        color: AppProperties.navylogo,
        child: Text(AppLocalizations.of(context).translate("sign"),
            style: TextStyle(color: Colors.white)),
      ),
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

    final form = Form(
      key: formKey,
      child: Center(
        child: ListView(
          children: <Widget>[
            logo,
            SizedBox(height: 32.0),
            Visibility(
              visible: _isLoading,
                child: CupertinoActivityIndicator()),
            SizedBox(height: 32.0),

            code,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 16.0),
            loginButton,
            changePassword
          ],
        ),
      ),
    );


    return Scaffold(
        key: _scaffFoledKey,
        backgroundColor: Colors.white,
        body: form

    );
  }

  void showInSnackBar(String value) {
    _scaffFoledKey.currentState.showSnackBar(
        new SnackBar(content: new Text(value)));
  }

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

  void action(LoginViewModel vs) {
    switch (vs.loadingStatus) {
      case LoadingStatus.searching:
        setState(() {
           _isLoading=true;
        });
        break;
      case LoadingStatus.completed:
        print("complete call");
        break;
      case LoadingStatus.error:
        setState(() {
          _isLoading=false;
        });
        showInSnackBar("حدث خطأ ما تحقق منن الانترنت وحاول مره أخر'");
        break;
      case LoadingStatus.empty:
        print("empty");
        break;
    }
  }


}
