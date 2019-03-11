import './src/dispatcher.dart';
import './src/model.dart';

export './src/action.dart';
export './src/builder.dart';
export './src/model.dart';
export './src/provider.dart';

class Eva {
  List<EvaModel> _models = [];

  // 初始化并携带一个model
  Eva.createWithModel(EvaModel model) {
    addModel(model);
  }

  // 初始化并携带一组model
  Eva.createWithModels(List<EvaModel> models) {
    addModels(models);
  }

  // 添加单个model
  addModel(EvaModel model) {
    _checkModelExist(model);
    this._models.add(model);
  }

  // 添加一组model
  addModels(List<EvaModel> models) {
    models.forEach((model) => _checkModelExist(model));
    this._models.addAll(models);
  }

  // 根据命名获取model
  EvaModel getModel(String namespace) {
    for (var i = 0; i < _models.length; i++) {
      if (_models[i].namespace == namespace) {
        return _models[i];
      }
    }
    return null;
  }

  /// 验证model是否存在
  /// 
  _checkModelExist(EvaModel model) {
    // TODO:
  }

  /// 清除model
  /// 
  removeModel(String namespace) {
    EvaModel _model = getModel(namespace);
    _models.remove(_model); // TODO: 验证是否正常
    if (_model != null) {
      _model.clear();
    }
  }

  // 清除所有model
  clearModel() {
    // TODO:
  }

  /// 获取dispatcher
  /// 
  EvaDispatcher get dispatcher => EvaDispatcher(this._models);
}
