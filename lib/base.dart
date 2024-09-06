import 'package:flutter/material.dart';

abstract class BaseConnector {
  showLoading();

  showErrorMessage(String message);

  hideDialog();
}

class BaseViewModel<T extends BaseConnector> extends ChangeNotifier {
  T? connector;
}

abstract class BaseView<S extends StatefulWidget, VM extends BaseViewModel>
    extends State<S> implements BaseConnector {
  late VM viewModel;

  VM initMyViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = initMyViewModel();
  }

  @override
  hideDialog() {
    Navigator.pop(context);
  }

  @override
  showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
      ),
    );
  }

  @override
  showLoading() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
