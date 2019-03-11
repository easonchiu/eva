import 'package:flutter/material.dart';

import './dispatcher.dart';
import '../eva.dart';

class EvaProvider extends InheritedWidget {
  final Eva store;
  final Widget child;

  /// 初始化
  EvaProvider({Key key, this.store, this.child}) : super(key: key, child: child);

  /// 获取dispatcher
  /// 获取到的dispatcher可以调用其dispatch方法
  /// EvaDispatcher dispatcher = EvaProvider.dispatcher(context);
  /// dispatcher.dispatch(
  ///   type: ['namespace', 'effect'],
  ///   payload: 'hello',
  /// );
  /// 
  static EvaDispatcher dispatcher(BuildContext context) {
    EvaProvider provider = (context.inheritFromWidgetOfExactType(EvaProvider) as EvaProvider);
    return provider.store.dispatcher;
  }

  /// 根据namespace获取相应的model
  /// EvaModel model = EvaProvider.model('namespace');
  /// 
  static EvaModel model(BuildContext context, String namespace) {
    EvaProvider provider = (context.inheritFromWidgetOfExactType(EvaProvider) as EvaProvider);
    return provider.store.getModel(namespace);
  }

  @override
  bool updateShouldNotify(EvaProvider oldWidget) {
    return true;
  }
}
