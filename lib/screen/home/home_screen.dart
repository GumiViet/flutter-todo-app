import 'package:flutter/material.dart';
import 'package:flutter_to_do/base/base_screen.dart';
import 'package:flutter_to_do/di/di.dart';
import 'package:flutter_to_do/models/model/to_do_model.dart';
import 'package:flutter_to_do/resources/colors.dart';
import 'package:flutter_to_do/resources/langs.dart';
import 'package:flutter_to_do/resources/styles.dart';
import 'package:flutter_to_do/screen/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';

@page
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreen<HomeScreen> {
  HomeViewModel viewModel = byInject<HomeViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.getListTodo();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<HomeViewModel>(builder: (context, viewModel, child) {
        return baseScaffold(
            myTitle: AppLangs.text_title_home,
            myBody: GestureDetector(
              onTap: () => viewModel.addTodo(),
              child: viewModel.listTodo.isNotEmpty
                  ? _itemListTodo(viewModel.listTodo)
                  : _itemNoValue(),
            ));
      }),
    );
  }

  Widget _itemNoValue() {
    return Container(
      child: Center(
        child: Text(
          getString(AppLangs.text_no_data),
          style: AppStyles().grayBold(20),
        ),
      ),
    );
  }

  Widget _itemListTodo(List<TodoModel> list) {
    return ListView.builder(
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return _itemDetailTodo(list[index]);
        });
  }

  Widget _itemDetailTodo(TodoModel item) {
    return Row(
      children: [
        Text("${item.id}"),
        Text(item.name),
        Text("${item.value}"),
      ],
    );
  }
}
