import 'dart:io';
import 'dart:ui';
import 'package:employeeattendance/Models/EmployeeDetail.dart';
import 'package:employeeattendance/Models/Month.dart';
import 'package:employeeattendance/Utils/AppProperties.dart';
import 'package:employeeattendance/Widget/ImageDialoge.dart';
import 'package:employeeattendance/Widget/imageProfie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';

class EmployeeListMonth extends StatelessWidget {
  List<Month> data;
  String pdftitile = "";
  String absetDates;
  String earlyDates;
  String lateDates;

  EmployeeListMonth(this.data, this.pdftitile);

  @override
  Widget build(BuildContext context) {
    download() async {
      final pdfLib.Document pdf = pdfLib.Document();
      final PdfImage assetImage = await pdfImageFromImageProvider(
        pdf: pdf.document,
        image: const AssetImage('assets/images/logo.jpg'),
      );

      final font = await rootBundle.load("assets/arabic.ttf");
      final ttf = pdfLib.Font.ttf(font);
      final fontBold = await rootBundle.load("assets/arabic.ttf");
      final ttfBold = pdfLib.Font.ttf(fontBold);
      final fontItalic = await rootBundle.load("assets/arabic.ttf");
      final ttfItalic = pdfLib.Font.ttf(fontItalic);
      final fontBoldItalic = await rootBundle.load("assets/arabic.ttf");
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
          theme: theme,
          build: (ctx) => [
            pdfLib.Column(
                crossAxisAlignment: pdfLib.CrossAxisAlignment.start,
                children: [
                  pdfLib.Container(
                      margin: pdfLib.EdgeInsets.only(left: 24,right: 24,top: 24),
                      child: pdfLib.Image(assetImage)),
                  pdfLib.Center(
                    child:pdfLib.Text("شركة شيلد للانشاءات المتخصصة", textDirection: pdfLib.TextDirection.rtl),

                  )
                ]

            ),
            pdfLib.Container(
                margin: pdfLib.EdgeInsets.only(top: 24),
                child:  pdfLib.Center(
                  child: pdfLib.Text(pdftitile, textDirection: pdfLib.TextDirection.rtl),
                )
            )
            ,

            pdfLib.Table.fromTextArray(context: ctx,
                data: <List<String>>[
              <String>[
                ' ايام الساعات الاضافيه',
                ' ايام الانصراف مبكر',
                ' ايام التأخير ',
                ' ايام الغياب ',
                '  مرتب العامل  ',
                'كود العامل ',
                'اسم العامل '
              ],
              ...data.map((item) => [
                getDAtes(item.additionalHoursDates),
                getDAtes(item.earlyLeftDates),
                getDAtes(item.lateDates),
                getDAtes(item.absentDates),
                item.salary.toString()+" ",
                item.code.toString(),
                item.name.toString()
              ])
            ]
            ,defaultColumnWidth:pdfLib.IntrinsicColumnWidth(flex: 24)),
          ],
        ),
      );
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
              color: Colors.blue,
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
                child: data!=null
                    ? ListView.separated(
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
                    itemBuilder: (_, index) => listViewItem(context, index))
                    : Center(
                    child: Text(
                      'لاتوجد بيانات  عن ${pdftitile}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Cairo",
                          color: Colors.red),
                    ))),
          ],
        ));
  }

  Widget listViewItem(BuildContext context, int index) {

    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Text(
                    "اسم العامل :",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: "Cairo"),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 4, right: 4, top: 8),
                    child: Text(
                      data[index].name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          fontFamily: "Cairo"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Text(
                    "كود العامل :",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: "Cairo"),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 4, right: 4, top: 8),
                    child: Text(
                      data[index].code,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          fontFamily: "Cairo"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Text(
                    "المرتب:",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: "Cairo"),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 4, right: 4, top: 8),
                    child: Text(
                      data[index].salary,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          fontFamily: "Cairo"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Text(
                    "الساعات الإضافيه:",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: "Cairo"),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 4, right: 4, top: 8),
                    child: Text(
                      data[index].additionalHoursDates.isEmpty
                          ? "لايوجد"
                          : "يوجد ساعات اضافيه",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          fontFamily: "Cairo"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Text(
                    "ايام الغياب",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.red,
                        fontFamily: "Cairo"),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 4, right: 4, top: 8),
                    child: Text(
                      getDAtes(data[index].absentDates),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          fontFamily: "Cairo"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Text(
                    "ايام التأخير",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.orange,
                        fontFamily: "Cairo"),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 4, right: 4, top: 8),
                    child: Text(
                      getDAtes(data[index].lateDates),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          fontFamily: "Cairo"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Text(
                    "ايام الانصراف مبكر",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.orangeAccent,
                        fontFamily: "Cairo"),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 4, right: 4, top: 8),
                    child: Text(
                      getDAtes(data[index].earlyLeftDates),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          fontFamily: "Cairo"),
                    ),
                  ),
                ),
              ],
            ),

          ],
        )
    );
  }

  bool getVisibility() {
    if (pdftitile =="بيانات الغياب"){
      return false;
    }

    else{
      return true;
    }

  }

  String getDAtes(List<String> dates) {
    String all="";
    String error="لايوجد";
    if(dates.isNotEmpty){
      for(String item  in dates){
        all=all+" "+item+",";
      }
      return all;
    }
    else{
      return error;
    }
  }
}


