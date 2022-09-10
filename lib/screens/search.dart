import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/providers/Main_provider.dart';
import 'package:howru/providers/apiprovider.dart';
import 'package:howru/screens/NoInternet.dart';
import 'package:howru/widgets/SearchTtem.dart';
import 'package:howru/widgets/Sec_searched_widget.dart';
import 'package:howru/widgets/maindrewer.dart';
import 'package:howru/widgets/search.dart';
import 'package:howru/widgets/searched_user.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../helpers/InterNetChecker.dart';

class Search_screen extends StatefulWidget {
  @override
  State<Search_screen> createState() => _Search_screenState();
}

class _Search_screenState extends State<Search_screen> {
  bool hasInternet = true;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: InternetChecker.SearchInternetchecker.onStatusChange,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final appbar = AppBar(
            actions: [
              !hasInternet
                  ? SizedBox()
                  : IconButton(
                      onPressed: (() {
                        showSearch(context: context, delegate: search());
                      }),
                      icon: Icon(Icons.search))
            ],
          );

          if (snapshot.data == InternetConnectionStatus.disconnected) {
            hasInternet = false;
          } else {
            hasInternet = true;
          }
          return Scaffold(
              appBar: appbar,
              body: snapshot.connectionState == ConnectionState.waiting
                  ? Center(child: CircularProgressIndicator())
                  : snapshot.data == InternetConnectionStatus.connected
                      ? SearchItem(appbar)
                      : internet());
        });
  }
}
