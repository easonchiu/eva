import 'dart:async';

import './action.dart';

abstract class EvaBaseModel {}

/// effect方法的结构
typedef Effect = Future Function(EvaAction action, Function(String reduce, [dynamic payload]) put);
/// reduce方法的结构
typedef Reducer<S> = S Function(S state, dynamic payload);

class EvaModel<S> implements EvaBaseModel {
  // 命名空间
  String _namespace;
  // 初始化数据
  S _state;
  // reducers列表
  Map<String, Reducer<S>> _reducers;
  // effects列表
  Map<String, Effect> _effects;
  // 监听器列表（内部使用）
  List<Function(S)> _listeners;
  // stream
  StreamController _streamController;

  EvaModel({
    String namespace,
    S state,
    Map<String, Reducer<S>> reducers,
    Map<String, Effect> effects,
  }) {
    this._namespace = namespace ?? '';
    this._state = state ?? {};
    this._reducers = reducers ?? {};
    this._effects = effects ?? {};
    _listeners = [];
    _streamController = StreamController<S>();
    _streamController.stream.listen(_onStreamData);
  }

  get reducers => _reducers;
  get namespace => _namespace;
  get state => _state;
  get effects => _effects;

  set state(state) {
    _streamController.sink.add(state);
  }

  // 添加model的监听，当state变化时
  listen(Function(S) listener) {
    _listeners.add(listener);
  }

  // 分发到所有监听者
  _onStreamData(data) {
    _state = data;
    _listeners.forEach((listener) {
      listener(data);
    });
  }

  /// 清除model
  /// 
  clear() {
    _reducers.clear();
    _effects.clear();
    _listeners.clear();
    _streamController.close();
  }
  
}
