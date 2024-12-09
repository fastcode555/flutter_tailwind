import 'dart:math' as math;

import 'package:example/super_markdown/core/services/expression_parser.dart';
import 'package:get/get.dart';

class MathCalculatorService extends GetxService {
  // 变量存储
  final Map<String, double> _variables = {};
  
  // 计算历史
  final RxList<String> history = <String>[].obs;
  
  // 支持的函数
  final Map<String, double Function(double)> _functions = {
    // 基本三角函数
    'sin': math.sin,
    'cos': math.cos,
    'tan': math.tan,
    'asin': math.asin,
    'acos': math.acos,
    'atan': math.atan,
    
    // 双曲函数
    'sinh': (x) => (math.exp(x) - math.exp(-x)) / 2,
    'cosh': (x) => (math.exp(x) + math.exp(-x)) / 2,
    'tanh': (x) => (math.exp(x) - math.exp(-x)) / (math.exp(x) + math.exp(-x)),
    
    // 反双曲函数
    'asinh': (x) => math.log(x + math.sqrt(x * x + 1)),
    'acosh': (x) => math.log(x + math.sqrt(x * x - 1)),
    'atanh': (x) => 0.5 * math.log((1 + x) / (1 - x)),
    
    // 指数和对数
    'exp': math.exp,
    'log': math.log,
    'log10': (x) => math.log(x) / math.ln10,
    'log2': (x) => math.log(x) / math.ln2,
    
    // 幂运算和根
    'sqrt': math.sqrt,
    'cbrt': (x) => math.pow(x, 1/3).toDouble(),
    'pow2': (x) => x * x,
    'pow3': (x) => x * x * x,
    
    // 取整和绝对值
    'abs': (x) => x.abs(),
    'ceil': (x) => x.ceil().toDouble(),
    'floor': (x) => x.floor().toDouble(),
    'round': (x) => x.round().toDouble(),
    'trunc': (x) => x.truncate().toDouble(),
    
    // 角度转换
    'rad': (x) => x * math.pi / 180, // 度转弧度
    'deg': (x) => x * 180 / math.pi, // 弧度转度
  };

  // 单位转换配置
  final Map<String, Map<String, double>> _unitConversions = {
    'length': {
      'mm': 0.001,
      'cm': 0.01,
      'm': 1,
      'km': 1000,
      'in': 0.0254,
      'ft': 0.3048,
      'yd': 0.9144,
      'mi': 1609.344,
    },
    'area': {
      'mm2': 0.000001,
      'cm2': 0.0001,
      'm2': 1,
      'km2': 1000000,
      'ha': 10000,
      'acre': 4046.86,
      'sqft': 0.092903,
      'sqyd': 0.836127,
    },
    'volume': {
      'ml': 0.001,
      'l': 1,
      'm3': 1000,
      'gal': 3.78541,
      'qt': 0.946353,
      'pt': 0.473176,
      'cup': 0.236588,
      'floz': 0.0295735,
    },
    'weight': {
      'mg': 0.001,
      'g': 1,
      'kg': 1000,
      'oz': 28.3495,
      'lb': 453.592,
      't': 1000000,
    },
    'time': {
      'ms': 0.001,
      's': 1,
      'min': 60,
      'h': 3600,
      'day': 86400,
      'week': 604800,
      'month': 2592000,
      'year': 31536000,
    },
    'speed': {
      'mps': 1,
      'kph': 0.277778,
      'mph': 0.44704,
      'knot': 0.514444,
    },
    'pressure': {
      'pa': 1,
      'kpa': 1000,
      'bar': 100000,
      'psi': 6894.76,
      'atm': 101325,
    },
    'energy': {
      'j': 1,
      'kj': 1000,
      'cal': 4.184,
      'kcal': 4184,
      'wh': 3600,
      'kwh': 3600000,
    },
    'temperature': {
      'c': 1,
      // 'f': (x) => (x - 32) * 5/9,
      // 'k': (x) => x - 273.15,
    },
  };

  // 计算表达式
  String? calculate(String expression) {
    try {
      // 移除所有空格
      expression = expression.replaceAll(' ', '');

      // 处理变量定义
      if (expression.contains(':=')) {
        return _handleVariableDefinition(expression);
      }

      // 处理单位转换
      if (expression.contains('->')) {
        return _handleUnitConversion(expression);
      }
      
      // 检查是否是数学表达式
      if (!expression.contains('=')) {
        return null;
      }

      // 分割表达式和等号
      final parts = expression.split('=');
      if (parts.length != 2 || parts[1].isNotEmpty) {
        return null;
      }

      final expr = parts[0];
      
      // 解析表达式
      final result = ExpressionParser.evaluate(expr);
      if (result == null) return null;

      // 格式化结果
      final formattedResult = _formatNumber(result);
      final resultText = '$expr = $formattedResult';
      
      // 添加到历史记录
      history.insert(0, resultText);
      if (history.length > 100) {
        history.removeLast();
      }
      
      // 保存结果到变量
      _variables['ans'] = result;
      
      return resultText;
    } catch (e) {
      return null;
    }
  }

  // 处理变量定义
  String? _handleVariableDefinition(String expression) {
    final parts = expression.split(':=');
    if (parts.length != 2) return null;

    final varName = parts[0].trim();
    final expr = parts[1];
    
    final value = _evaluateExpression(expr);
    if (value == null) return null;

    _variables[varName] = value;
    return '$varName := ${_formatNumber(value)}';
  }

  // 处理单位转换
  String? _handleUnitConversion(String expression) {
    final parts = expression.split('->');
    if (parts.length != 2) return null;

    final sourceExpr = parts[0];
    final targetUnit = parts[1].trim();

    // 解析源值和单位
    final sourceMatch = RegExp(r'([\d.]+)([a-zA-Z]+)').firstMatch(sourceExpr);
    if (sourceMatch == null) return null;

    final sourceValue = double.tryParse(sourceMatch.group(1)!);
    final sourceUnit = sourceMatch.group(2)!;
    if (sourceValue == null) return null;

    // 查找单位类型
    String? unitType;
    for (final type in _unitConversions.keys) {
      if (_unitConversions[type]!.containsKey(sourceUnit) &&
          _unitConversions[type]!.containsKey(targetUnit)) {
        unitType = type;
        break;
      }
    }
    if (unitType == null) return null;

    // 转换单位
    final sourceToBase = _unitConversions[unitType]![sourceUnit]!;
    final baseToTarget = 1 / _unitConversions[unitType]![targetUnit]!;
    final result = sourceValue * sourceToBase * baseToTarget;

    return '${_formatNumber(sourceValue)}$sourceUnit = ${_formatNumber(result)}$targetUnit';
  }

  // 计算表达式
  double? _evaluateExpression(String expr) {
    try {
      // 处理函数调用
      final funcMatch = RegExp(r'([a-z]+)\((.*)\)').firstMatch(expr);
      if (funcMatch != null) {
        final funcName = funcMatch.group(1)!;
        final arg = funcMatch.group(2)!;
        
        if (_functions.containsKey(funcName)) {
          final value = _evaluateExpression(arg);
          if (value != null) {
            return _functions[funcName]!(value);
          }
        }
        return null;
      }

      // 处理变量引用
      if (_variables.containsKey(expr)) {
        return _variables[expr];
      }

      // 处理加减
      final addParts = expr.split(RegExp(r'[\+\-]'));
      if (addParts.length > 1) {
        var result = _evaluateExpression(addParts[0]) ?? 0;
        var index = addParts[0].length;
        
        for (var i = 1; i < addParts.length; i++) {
          final op = expr[index];
          final value = _evaluateExpression(addParts[i]) ?? 0;
          
          if (op == '+') {
            result += value;
          } else {
            result -= value;
          }
          
          index += addParts[i].length + 1;
        }
        
        return result;
      }

      // 处理乘除
      final mulParts = expr.split(RegExp(r'[\*\/]'));
      if (mulParts.length > 1) {
        var result = _evaluateExpression(mulParts[0]) ?? 0;
        var index = mulParts[0].length;
        
        for (var i = 1; i < mulParts.length; i++) {
          final op = expr[index];
          final value = _evaluateExpression(mulParts[i]) ?? 0;
          
          if (op == '*') {
            result *= value;
          } else if (value != 0) {
            result /= value;
          }
          
          index += mulParts[i].length + 1;
        }
        
        return result;
      }

      // 处理次方
      final powParts = expr.split('^');
      if (powParts.length > 1) {
        var result = _evaluateExpression(powParts[0]) ?? 0;
        
        for (var i = 1; i < powParts.length; i++) {
          final exponent = _evaluateExpression(powParts[i]) ?? 0;
          result = math.pow(result, exponent).toDouble();
        }
        
        return result;
      }

      // 处理括号
      if (expr.contains('(')) {
        final start = expr.lastIndexOf('(');
        final end = expr.indexOf(')', start);
        if (end != -1) {
          final innerExpr = expr.substring(start + 1, end);
          final innerResult = _evaluateExpression(innerExpr);
          if (innerResult != null) {
            final newExpr = expr.replaceRange(start, end + 1, innerResult.toString());
            return _evaluateExpression(newExpr);
          }
        }
      }

      // 单个数字
      return double.tryParse(expr);
    } catch (e) {
      return null;
    }
  }

  // 清除历史记录
  void clearHistory() {
    history.clear();
  }

  // 清除变量
  void clearVariables() {
    _variables.clear();
  }

  // 获取变量值
  double? getVariable(String name) {
    return _variables[name];
  }

  // 获取所有变量
  Map<String, double> get variables => Map.unmodifiable(_variables);

  // 获取支持的函数列表
  List<String> get supportedFunctions => List.unmodifiable(_functions.keys);

  // 获取支持的单位类型
  Map<String, List<String>> get supportedUnits {
    return Map.fromEntries(
      _unitConversions.entries.map(
        (e) => MapEntry(e.key, List.unmodifiable(e.value.keys)),
      ),
    );
  }

  // 特殊单位转换（非线性转换）
  double _convertSpecialUnit(String type, String fromUnit, String toUnit, double value) {
    if (type == 'temperature') {
      // 先转换到摄氏度
      double celsius;
      switch (fromUnit) {
        case 'c':
          celsius = value;
        case 'f':
          celsius = (value - 32) * 5/9;
        case 'k':
          celsius = value - 273.15;
        default:
          return value;
      }

      // 从摄氏度转换到目标单位
      switch (toUnit) {
        case 'c':
          return celsius;
        case 'f':
          return celsius * 9/5 + 32;
        case 'k':
          return celsius + 273.15;
        default:
          return celsius;
      }
    }
    return value;
  }

  // 格式化数字
  String _formatNumber(double number) {
    if (number.abs() > 1e6 || number.abs() < 1e-6) {
      // 使用科学计数法
      return number.toStringAsExponential(6);
    } else if (number % 1 == 0) {
      // 整数
      return number.toInt().toString();
    } else {
      // 小数，最多保留6位
      return number.toStringAsFixed(6).replaceAll(RegExp(r'\.?0+$'), '');
    }
  }
} 