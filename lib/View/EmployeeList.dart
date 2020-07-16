import 'dart:io';
import 'package:employeeattendance/Models/EmployeeDetail.dart';
import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/View/EmployeeData.dart';
import 'package:employeeattendance/Widget/ImageDialoge.dart';
import 'package:employeeattendance/Widget/imageProfie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';

class EmployeeList extends StatelessWidget{

  List<Detail> data;

  String pdftitile="";
  EmployeeList(this.data,this.pdftitile);
  @override
  Widget build(BuildContext context) {
    download() async{
      final pdfLib.Document pdf = pdfLib.Document();

      final font = await rootBundle.load("assets/arabic.ttf");
      final ttf = pdfLib.Font.ttf(font);
      final fontBold = await rootBundle.load("assets/arabic.ttf");
      final ttfBold = pdfLib.Font.ttf(fontBold);
      final fontItalic = await rootBundle.load("assets/arabic.ttf");
      final ttfItalic = pdfLib.Font.ttf(fontItalic);
      final fontBoldItalic =
      await rootBundle.load("assets/arabic.ttf");
      final ttfBoldItalic = pdfLib.Font.ttf(fontBoldItalic);

      final pdfLib.ThemeData theme = pdfLib.ThemeData.withFont(
        base: ttf,
        bold: ttfBold,
        italic: ttfItalic,
        boldItalic: ttfBoldItalic,
      );

      pdf.addPage(

        pdfLib.MultiPage(
          pageFormat: PdfPageFormat.a4,
          theme:theme,
          build: (ctx) => [
            pdfLib.Center(
                child: pdfLib.Text(pdftitile,textDirection: pdfLib.TextDirection.rtl),)
            ,pdfLib.Table.fromTextArray(context: ctx,
                data: <List<String>>[<String>['مكان الانصراف','ميعاد الانصراف','مكان الدخول','ميعاد الدخول','الساعات الاضافيه','المرتب','كود العامل','اسم العامل'],
                  ...data.map((item) => [item.leavingLocation.toString(), item.leavingTime.toString(),
                    item.attendingLocation.toString(),item.attendingTime.toString(),
                    item.additionalHours.toString(),item.salary.toString(),item.code.toString()
                  ,item.name.toString()])
            ]),
          ],
        ),
      );

//      final String dir = (await getApplicationDocumentsDirectory()).path;
//      print(dir);
//      final String path = '$dir/employees.pdf';
//      final File file = File(path);
//      await file.writeAsBytes(pdf.save());

      Printing.sharePdf(bytes: pdf.save(), filename: 'my-document.pdf');

    }

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.cloud_download),
              color: Colors.black,
              onPressed: () {
                download();

              },
            ),

          ],
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Text(
            'العمال',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 4,
        ),

      body: Column(
        children: <Widget>[
          Flexible(
              child: ListView.separated(
                  itemCount: data.length,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                        height: 24,
                        indent: 16,
                        endIndent: 16,
                        color: AppProperties.lightnavylogo,
                        thickness: 1,
                      ),
                  itemBuilder: (_, index) =>
                   listViewItem(context,index)
              )
          ),

        ],
      )
    );

  }

  Widget listViewItem(BuildContext context,int index) {
   return
     Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 16),
        child:
        Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 8,right: 8,top: 8),
                      child: Text("اسم العامل :",style:
                      TextStyle(fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "Cairo"),),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 4,right: 4,top: 8),
                        child: Text(data[index].name,overflow: TextOverflow.ellipsis,
                          style:
                        TextStyle(fontWeight: FontWeight.w700,fontSize: 18,fontFamily: "Cairo"),),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 8,right: 8,top: 8),
                      child: Text("كود العامل :",style:
                      TextStyle(fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "Cairo"),),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 4,right: 4,top: 8),
                        child: Text(data[index].code,overflow: TextOverflow.ellipsis,
                          style:
                          TextStyle(fontWeight: FontWeight.w700,fontSize: 18,fontFamily: "Cairo"),),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 8,right: 8,top: 8),
                      child: Text("المرتب:",style:
                      TextStyle(fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "Cairo"),),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 4,right: 4,top: 8),
                        child: Text(data[index].salary,overflow: TextOverflow.ellipsis,
                          style:
                          TextStyle(fontWeight: FontWeight.w700,fontSize: 18,fontFamily: "Cairo"),),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 8,right: 8,top: 8),
                      child: Text("الساعات الإضافيه:",style:
                      TextStyle(fontWeight: FontWeight.w600,fontSize: 16,fontFamily: "Cairo"),),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 4,right: 4,top: 8),
                        child: Text(data[index].additionalHours==null?"":data[index].additionalHours,overflow: TextOverflow.ellipsis,
                          style:
                          TextStyle(fontWeight: FontWeight.w700,fontSize: 18,fontFamily: "Cairo"),),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      child: GestureDetector(
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (_) => ImageDialog(data[index].attendingImg)
                          );
                        },
                      ),
                      maxRadius: 32,
                      backgroundImage:NetworkImage(data[index].attendingImg),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(left: 16,right: 16,top: 4),
                                  child: Text("دخول ",style:
                                  TextStyle(fontWeight: FontWeight.w700,fontSize: 16,fontFamily: "Cairo",color: Colors.green),)),
                              Container(
                                  margin: EdgeInsets.only(left: 8,right: 8,top: 4),
                                  child: Text(data[index].attendingTime,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontFamily: "Cairo"),)),
                            ],
                          ),
                      Container(
                                margin: EdgeInsets.only(left: 16,right: 16,top: 4),
                                child:
                                Text(data[index].attendingLocation,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontFamily: "Cairo",color: AppProperties.navylogo),)),
                      ],),
                    )
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      child: GestureDetector(
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (_) => ImageDialog(data[index].leavingImg)
                          );
                        },
                      ),
                      maxRadius: 32,
                      backgroundImage: NetworkImage(data[index].leavingImg==null ? "":data[index].leavingImg),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(left: 16,right: 16,top: 4),
                                  child: Text("مغادرة ",style:
                                  TextStyle(fontWeight: FontWeight.w700,fontSize: 16,fontFamily: "Cairo",color: Colors.red),)),
                              Container(
                                  margin: EdgeInsets.only(left: 8,right: 8,top: 4),
                                  child: Text(data[index].leavingTime==null?"":data[index].leavingTime,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontFamily: "Cairo"),)),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 16,right: 16,top: 4),
                              child:
                              Text(data[index].leavingLocation==null?"":data[index].leavingLocation,
                                overflow: TextOverflow.ellipsis,
                                style:
                                TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontFamily: "Cairo",color: AppProperties.navylogo),)),
                        ],),
                    )
                  ],
                ),
                SizedBox(height: 4,),

              ],

        )


    );

}


}
