import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunflower/pages/home/home_controller.dart';
import 'package:sunflower/widgets/bottom_sheet.dart';
import 'package:sunflower/widgets/grid_view_show.dart';
import 'package:sunflower/widgets/list_view_show.dart';

class HomePage extends StatefulWidget {
  final bool isListView;

  const HomePage({required this.isListView});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data = [];
  var list = [];
  late HomeController homeController;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    homeController = HomeController();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: isLoading
              ? Container(
                  child: Center(
                    child: Text("Loading...."),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Column(
                    children: [
                      TextField(
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "Search here...",
                        ),
                        onChanged: (data) => filterData(data),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      widget.isListView
                          ? ListViewShow(list: list , onItemSelected: (item) => ShareBottomSheet.get(context, item),)
                          : GridViewShow(list: list, onItemSelected: (item) => ShareBottomSheet.get(context, item),)
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  fetchData() async {
    isLoading = true;
    setState(() {});

    data = await homeController.getData();
    list.addAll(data);

    isLoading = false;
    setState(() {});
  }

  filterData(value) {
    if (value.toString().isEmpty) {
      list = [];
      list.addAll(data);
    } else {
      list = [];
      list = data.where((i) => i.title.toString().contains(value)).toList();
    }
    setState(() {});
  }
}
