import 'package:flutter/material.dart';

import './model.dart';

class EvaBuilder<S, V> extends StatelessWidget {
  final Widget Function(BuildContext, V) builder;
  final EvaModel model;
  final V Function(S) value;

  EvaBuilder({
    @required this.builder,
    @required this.model,
    @required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return _EvaBuilder<S, V>(
      builder: builder,
      model: model,
      value: value,
    );
  }
}

class _EvaBuilder<S, V> extends StatefulWidget {
  final EvaModel model;
  final Function value;
  final builder;

  _EvaBuilder({
    Key key,
    this.model,
    this.builder,
    this.value,
  }) : super(key: key);

  _EvaBuilderState createState() => _EvaBuilderState();
}

class _EvaBuilderState extends State<_EvaBuilder> {
  var _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value(widget.model.state);
    widget.model.listen(onData);
  }

  onData(state) {
    var _nVal = widget.value(state);
    if (_nVal != _value) {
      setState(() {
        _value = _nVal;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _value);
  }
}
