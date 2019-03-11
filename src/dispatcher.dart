import './action.dart';
import './model.dart';

class EvaDispatcher {
  EvaDispatcher(models) {
    this._models = models;
  }

  List<EvaModel> _models;

  // 发送一个dispatch
  dispatch({
    // type格式为[namespace, effect/reducer]
    List<String> type,
    dynamic payload,
  }) async {
    if (type.length != 2 || type[0].isEmpty || type[1].isEmpty) {
      throw 'type error. exp: [namespace, effect/reducer]';
    }

    // 根据namespace找到相应的model
    EvaModel model;

    for (var i = 0; i < _models.length; i++) {
      if (type[0] == _models[i].namespace) {
        model = _models[i];
        break;
      }
    }

    if (model == null) {
      throw 'model "${type[0]}" is not exist.';
    }

    // 优先找effect，根据type的第二个参数
    var effect = model.effects[type[1]];
    if (effect != null) {
      return await effect(EvaAction(type[1], payload), _put(model));
    }

    // 若没找到，再从reducer中找
    var reducer = model.reducers[type[1]];
    if (reducer != null) {
      model.state = reducer(model.state, payload);
      return null;
    }

    // 最终都没找到，报错
    throw 'can not find any effects or reducers.';
  }

  // 内部方法，model中effect调用reducer时使用
  _put(EvaModel model) {
    return (String reduce, [dynamic payload]) {
      var reducer = model.reducers[reduce];
      if (reducer == null) {
        throw 'reducer "$reduce" is not exist.';
      }
      var res = reducer(model.state, payload);
      if (res == null) {
        throw 'reducer must be return a state.';
      }
      model.state = res;
    };
  }
}
