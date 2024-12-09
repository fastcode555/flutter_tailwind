import 'dart:math' as math;

class ExpressionParser {
  // 数学常量
  static const Map<String, double> constants = {
    'pi': math.pi,
    'e': math.e,
    'phi': 1.618033988749895, // 黄金比例
    'gamma': 0.5772156649015329, // 欧拉常数
    'sqrt2': math.sqrt2,
    'ln2': math.ln2,
    'ln10': math.ln10,
    'log2e': math.log2e,
    'log10e': math.log10e,
  };

  // 数学函数
  static final Map<String, double Function(double)> functions = {
    // 三角函数
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
    'log2': (x) => math.log(x) / math.ln2,
    'log10': (x) => math.log(x) / math.ln10,
    
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
    'sign': (x) => x.sign,
    
    // 特殊函数
    'gamma': _gamma,
    'factorial': _factorial,
    'erf': _erf,
  };

  // 解析表达式
  static double? evaluate(String expression) {
    try {
      // 处理科学计数法
      expression = _normalizeScientificNotation(expression);
      
      // 替换常量
      expression = _replaceConstants(expression);
      
      // 处理函数调用
      expression = _handleFunctions(expression);
      
      // 计算表达式
      return _evaluateExpression(expression);
    } catch (e) {
      return null;
    }
  }

  // 处理科学计数法
  static String _normalizeScientificNotation(String expr) {
    return expr.replaceAllMapped(
      RegExp(r'(-?\d+\.?\d*)[eE](-?\d+)'),
      (match) {
        final base = double.parse(match.group(1)!);
        final exp = int.parse(match.group(2)!);
        return (base * math.pow(10, exp)).toString();
      },
    );
  }

  // 替换常量
  static String _replaceConstants(String expr) {
    var result = expr;
    for (final entry in constants.entries) {
      result = result.replaceAll(entry.key, entry.value.toString());
    }
    return result;
  }

  // 处理函数调用
  static String _handleFunctions(String expr) {
    for (final func in functions.keys) {
      final pattern = RegExp('$func\\((.*?)\\)');
      while (expr.contains(pattern)) {
        expr = expr.replaceAllMapped(pattern, (match) {
          final arg = _evaluateExpression(match.group(1)!);
          if (arg == null) throw Exception('Invalid argument');
          final result = functions[func]!(arg);
          return result.toString();
        });
      }
    }
    return expr;
  }

  // 计算表达式
  static double? _evaluateExpression(String expr) {
    // 移除空格
    expr = expr.replaceAll(' ', '');
    
    // 处理括号
    while (expr.contains('(')) {
      final start = expr.lastIndexOf('(');
      final end = expr.indexOf(')', start);
      if (end == -1) return null;
      
      final innerExpr = expr.substring(start + 1, end);
      final innerResult = _evaluateExpression(innerExpr);
      if (innerResult == null) return null;
      
      expr = expr.replaceRange(start, end + 1, innerResult.toString());
    }
    
    // 处理运算符
    return _evaluateOperators(expr);
  }

  // 处理运算符
  static double? _evaluateOperators(String expr) {
    // 处理加减
    final addParts = expr.split(RegExp(r'[\+\-]'));
    if (addParts.length > 1) {
      var result = _evaluateOperators(addParts[0]) ?? 0;
      var index = addParts[0].length;
      
      for (var i = 1; i < addParts.length; i++) {
        final op = expr[index];
        final value = _evaluateOperators(addParts[i]) ?? 0;
        
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
      var result = _evaluateOperators(mulParts[0]) ?? 0;
      var index = mulParts[0].length;
      
      for (var i = 1; i < mulParts.length; i++) {
        final op = expr[index];
        final value = _evaluateOperators(mulParts[i]) ?? 0;
        
        if (op == '*') {
          result *= value;
        } else if (value != 0) {
          result /= value;
        } else {
          return null; // 除以零
        }
        
        index += mulParts[i].length + 1;
      }
      
      return result;
    }

    // 处理幂运算
    final powParts = expr.split('^');
    if (powParts.length > 1) {
      var result = _evaluateOperators(powParts[0]) ?? 0;
      
      for (var i = 1; i < powParts.length; i++) {
        final exponent = _evaluateOperators(powParts[i]) ?? 0;
        result = math.pow(result, exponent).toDouble();
      }
      
      return result;
    }

    // 单个数字
    return double.tryParse(expr);
  }

  // 特殊函数实现
  static double _gamma(double x) {
    // Lanczos approximation
    const g = 7;
    const p = [
      0.99999999999980993,
      676.5203681218851,
      -1259.1392167224028,
      771.32342877765313,
      -176.61502916214059,
      12.507343278686905,
      -0.13857109526572012,
      9.9843695780195716e-6,
      1.5056327351493116e-7,
    ];

    if (x < 0.5) {
      return math.pi / (math.sin(math.pi * x) * _gamma(1 - x));
    }

    x -= 1;
    var a = p[0];
    for (var i = 1; i < g + 2; i++) {
      a += p[i] / (x + i);
    }

    final t = x + g + 0.5;
    return math.sqrt(2 * math.pi) * math.pow(t, x + 0.5) * math.exp(-t) * a;
  }

  static double _factorial(double x) {
    if (x < 0) throw Exception('Factorial of negative number');
    if (x <= 1) return 1;
    return x * _factorial(x - 1);
  }

  static double _erf(double x) {
    // 误差��数近似
    const a1 = 0.254829592;
    const a2 = -0.284496736;
    const a3 = 1.421413741;
    const a4 = -1.453152027;
    const a5 = 1.061405429;
    const p = 0.3275911;

    final sign = x.sign;
    x = x.abs();

    final t = 1.0 / (1.0 + p * x);
    final y = 1.0 - (((((a5 * t + a4) * t) + a3) * t + a2) * t + a1) * t * math.exp(-x * x);

    return sign * y;
  }
} 