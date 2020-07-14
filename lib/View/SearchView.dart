
import 'package:employeeattendance/Utils/AppLocalization.dart';
import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/Utils/Constant.dart';
import 'package:employeeattendance/Utils/SharedPrefrence.dart';
import 'package:employeeattendance/ViewModels/SearchViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  TextEditingController controller = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
            body:
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).translate("search"),
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Cairo"
                          ),
                        ),
                        CloseButton()
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: AppProperties.lightnavylogo, width: 1))),
                    child: TextField(
                      controller: controller,
                      showCursor: true,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText: "ابحث.........",
                          prefixIcon: Icon(Icons.search)
                          ,
                          suffix: FlatButton(
                              onPressed: () {
                                controller.clear();
                              },
                              child: Text(
                                AppLocalizations.of(context).translate("clear"),
                                style: TextStyle(color: Colors.red,fontFamily: "Cairo",fontWeight: FontWeight.w700,fontSize: 16),
                              ))),
                      onSubmitted:(value){
                        StorageUtil.getInstance().then((storage){
                        String token=  StorageUtil.getString(Constant.SHARED_USER_TOKEN);
                          Provider.of<SearchViewModel>(context, listen: false).doSearchClient(value, token);
                        });
                      } ,
                    ),
                  ),

                  Consumer<SearchViewModel>(builder: (context, model,child){
                    return switchWidget(context,model);
                  }),
                ],
              ),
            )
        ),
      ),
    );
  }

  Widget switchWidget(BuildContext context, SearchViewModel model) {
    switch (model.loadingStatus) {
      case LoadingStatus.searching:
        return  Visibility(
          visible: true,
          child: Center(child: CupertinoActivityIndicator()),
        );
      case LoadingStatus.error:
        return Visibility(
          visible: true,
          child:Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(model.error,
                style:
                TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Cairo",color: Colors.red),)),
        );
      case LoadingStatus.completed:
        return Flexible(
            child: Container(
              child: ListView.builder(
                  itemCount: model.searchResults.length,
                  itemBuilder: (_, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListTile(
//                        onTap: ()=>Navigator.of(context).
//                        push(MaterialPageRoute(builder:(_)=>ViewProductPage(product: searchResults[index],))),
                        title: Text("اسم العامل : "+model.searchResults[index].name,style: TextStyle(fontSize: 20,fontFamily: "Cairo",fontWeight: FontWeight.w500)),
                        subtitle: Text("كود العامل : "+model.searchResults[index].code,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      ))),
            ),
          );
      case LoadingStatus.empty:
        return Visibility(
          visible: model.loadingStatus==LoadingStatus.error,
          child:Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(model.error,
                style:
                TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Cairo",color: Colors.red),)),
        );

    }
  }
}