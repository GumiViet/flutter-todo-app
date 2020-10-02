import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do/base/base_screen.dart';
import 'package:flutter_to_do/dependency_injection/dependency_injection.dart';
import 'package:flutter_to_do/models/model/to_do_model.dart';
import 'package:flutter_to_do/resources/colors.dart';
import 'package:flutter_to_do/resources/constants.dart';
import 'package:flutter_to_do/resources/langs.dart';
import 'package:flutter_to_do/resources/styles.dart';
import 'package:flutter_to_do/screen/home/home_view_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
            myBody: viewModel.listTodo.isNotEmpty
                ? _itemListTodo(viewModel.listTodo)
                : _itemNoValue(),
            floatButton: _floatButton());
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
    return SingleChildScrollView(
      child: Container(
        width: getWidthPercen(100),
        child: DataTable(
          columns: [
            _itemColumn(AppLangs.text_id),
            _itemColumn(AppLangs.text_name),
            _itemColumn(AppLangs.text_value),
            _itemColumn(AppLangs.text_deleted),
          ],
          rows: _getListRow(list),
          showCheckboxColumn: false,
          headingTextStyle: AppStyles().grayBold(13),
          columnSpacing: 40,
        ),
      ),
    );
  }

  _itemColumn(String title) => DataColumn(
      label: Text(title.isNotEmpty ? getString(title).toUpperCase() : ""));

  _getListRow(List<TodoModel> list) => list
      .map((e) => DataRow(onSelectChanged: (val) => _showDialog(e), cells: [
            DataCell(
              Text("${e.id}"),
              showEditIcon: true,
              onTap: () => _gotoAndGetAction(e),
            ),
            DataCell(Text(e.name)),
            DataCell(Text("${e.value}")),
            DataCell(
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppColors.mainColor,
                ),
                onPressed: () {
                  _deleteTodo(e);
                },
              ),
            )
          ]))
      .toList();

  Widget _floatButton() {
    int id = viewModel.listTodo.length != 0
        ? viewModel.listTodo[viewModel.listTodo.length - 1].id + 1
        : 1;
    return FloatingActionButton(
      child: Icon(
        Icons.add_circle,
        color: AppColors.white,
        size: 50,
      ),
      onPressed: () => _gotoAndGetAction(TodoModel(id: id)),
      // onPressed: () => viewModel.addTodo(),
    );
  }

  _gotoAndGetAction(TodoModel item) async {
    var result = await goToScreen(AppConstants.ROUTE_ADD_ITEM_SCREEN, item);
    if (result != 0) viewModel.getListTodo();
  }

  _deleteTodo(TodoModel item) async {
    var result = await viewModel.deleteTodo(item);
    if (result != 0)
      Fluttertoast.showToast(msg: getString(AppLangs.text_deleted));
  }

  _showDialog(TodoModel item) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => CupertinoAlertDialog(
              title: Text(getString(AppLangs.text_detail_todo)),
              content: Padding(
                padding: const EdgeInsets.all(16),
                child: Text("${item.id} - ${item.name} - ${item.value}"),
              ),
              actions: [
                CupertinoDialogAction(
                  child: Text("OK"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                CupertinoDialogAction(
                  child: Text(getString(AppLangs.text_delete_item)),
                  onPressed: () {
                    _deleteTodo(item);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
