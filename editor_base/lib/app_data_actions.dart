// Cada acció ha d'implementar les funcions undo i redo
import 'dart:ui';

import 'app_data.dart';
import 'util_shape.dart';

abstract class Action {
  void undo();
  void redo();
}

// Gestiona la llista d'accions per poder desfer i refer
class ActionManager {
  List<Action> actions = [];
  int currentIndex = -1;

  void register(Action action) {
    // Elimina les accions que estan després de l'índex actual
    if (currentIndex < actions.length - 1) {
      actions = actions.sublist(0, currentIndex + 1);
    }
    actions.add(action);
    currentIndex++;
    action.redo();
  }

  void undo() {
    if (currentIndex >= 0) {
      actions[currentIndex].undo();
      currentIndex--;
    }
  }

  void redo() {
    if (currentIndex < actions.length - 1) {
      currentIndex++;
      actions[currentIndex].redo();
    }
  }
}

class ActionSetDocWidth implements Action {
  final double previousValue;
  final double newValue;
  final AppData appData;

  ActionSetDocWidth(this.appData, this.previousValue, this.newValue);

  _action(double value) {
    appData.docSize = Size(value, appData.docSize.height);
    appData.forceNotifyListeners();
  }

  @override
  void undo() {
    _action(previousValue);
  }

  @override
  void redo() {
    _action(newValue);
  }
}

class ActionSetDocHeight implements Action {
  final double previousValue;
  final double newValue;
  final AppData appData;

  ActionSetDocHeight(this.appData, this.previousValue, this.newValue);

  _action(double value) {
    appData.docSize = Size(appData.docSize.width, value);
    appData.forceNotifyListeners();
  }

  @override
  void undo() {
    _action(previousValue);
  }

  @override
  void redo() {
    _action(newValue);
  }
}

class ActionAddNewShape implements Action {
  final AppData appData;
  final Shape newShape;

  ActionAddNewShape(this.appData, this.newShape);

  @override
  void undo() {
    if (appData.shapesList.indexOf(newShape) == appData.shapeSelected)
      appData.shapeSelected = -1;
    appData.shapesList.remove(newShape);
    appData.forceNotifyListeners();
  }

  @override
  void redo() {
    appData.shapesList.add(newShape);
    appData.forceNotifyListeners();
  }
}

class ActionsAddBackground implements Action {
  final AppData appData;
  final Color previousColor;
  final Color actualColor;

  ActionsAddBackground(this.appData, this.actualColor, this.previousColor);

  @override
  void redo() {
    appData.valueColorNotifier.value = actualColor;
    appData.forceNotifyListeners();
  }

  @override
  void undo() {
    appData.valueColorNotifier.value = previousColor;
    appData.forceNotifyListeners();
  }
}

class ActionsEditShape implements Action {
  final AppData appData;
  final Color previousColor;
  final int previousStroke;
  final Shape shape;

  ActionsEditShape(
      this.appData, this.previousColor, this.previousStroke, this.shape);

  @override
  void redo() {
    int auxStroke = 
  }

  @override
  void undo() {}
}
