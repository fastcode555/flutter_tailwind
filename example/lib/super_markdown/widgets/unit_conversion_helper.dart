import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class UnitConversionHelper extends StatelessWidget {
  final String fromUnit;
  final String toUnit;
  final VoidCallback onClose;

  const UnitConversionHelper({
    required this.fromUnit, required this.toUnit, required this.onClose, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return container.white.rounded8.p16.cardShadow.child(
      column.crossStart.children([
        // 标题栏
        row.spaceBetween.children([
          '单位转换帮助'.text.f16.bold.mk,
          IconButton(
            icon: Icons.close.icon.grey600.s20.mk,
            onPressed: onClose,
          ),
        ]),
        
        h16,
        
        // 转换公式
        _buildConversionFormula(),
        
        h16,
        
        // 常用转换示例
        _buildExamples(),
      ]),
    );
  }

  Widget _buildConversionFormula() {
    final formula = _getConversionFormula();
    if (formula == null) return const SizedBox();

    return container.grey100.rounded8.p12.child(
      column.crossStart.children([
        '转换公式:'.text.grey600.f14.mk,
        h8,
        formula.text.f16.mk,
      ]),
    );
  }

  Widget _buildExamples() {
    final examples = _getExamples();
    if (examples.isEmpty) return const SizedBox();

    return column.crossStart.children([
      '示例:'.text.grey600.f14.mk,
      h8,
      ...examples.map((example) => container.p8.child(
        example.text.f14.mk,
      )),
    ]);
  }

  String? _getConversionFormula() {
    final formulas = {
      // 温度转换
      'c->f': '°F = °C × 9/5 + 32',
      'f->c': '°C = (°F - 32) × 5/9',
      'c->k': 'K = °C + 273.15',
      'k->c': '°C = K - 273.15',
      'f->k': 'K = (°F + 459.67) × 5/9',
      'k->f': '°F = K × 9/5 - 459.67',
      
      // 长度转换
      'km->m': '1 km = 1000 m',
      'm->cm': '1 m = 100 cm',
      'cm->mm': '1 cm = 10 mm',
      'mi->km': '1 mi = 1.60934 km',
      'ft->m': '1 ft = 0.3048 m',
      'in->cm': '1 in = 2.54 cm',
      'yd->m': '1 yd = 0.9144 m',
      
      // 重量转换
      'kg->g': '1 kg = 1000 g',
      'g->mg': '1 g = 1000 mg',
      'lb->kg': '1 lb = 0.453592 kg',
      'oz->g': '1 oz = 28.3495 g',
      't->kg': '1 t = 1000 kg',
      
      // 面积转换
      'km2->m2': '1 km² = 1,000,000 m²',
      'm2->cm2': '1 m² = 10,000 cm²',
      'ha->m2': '1 ha = 10,000 m²',
      'acre->m2': '1 acre = 4046.86 m²',
      'sqft->m2': '1 ft² = 0.092903 m²',
      
      // 体积转换
      'm3->l': '1 m³ = 1000 L',
      'l->ml': '1 L = 1000 mL',
      'gal->l': '1 gal = 3.78541 L',
      'qt->l': '1 qt = 0.946353 L',
      'pt->l': '1 pt = 0.473176 L',
      
      // 速度转换
      'kph->mps': '1 km/h = 0.277778 m/s',
      'mph->kph': '1 mph = 1.60934 km/h',
      'knot->kph': '1 knot = 1.852 km/h',
      
      // 压力转换
      'bar->pa': '1 bar = 100,000 Pa',
      'psi->pa': '1 psi = 6894.76 Pa',
      'atm->pa': '1 atm = 101,325 Pa',
      
      // 能量转换
      'kj->j': '1 kJ = 1000 J',
      'kcal->j': '1 kcal = 4184 J',
      'kwh->j': '1 kWh = 3,600,000 J',
    };
    return formulas['$fromUnit->$toUnit'];
  }

  List<String> _getExamples() {
    final examples = {
      // 温度转换示例
      'c->f': [
        '0°C = 32°F (水的冰点)',
        '100°C = 212°F (水的沸点)',
        '37°C = 98.6°F (人体正常体温)',
        '-40°C = -40°F (两个温标的交点)',
      ],
      'c->k': [
        '0°C = 273.15K (水的冰点)',
        '100°C = 373.15K (水的沸点)',
        '-273.15°C = 0K (绝对零度)',
      ],
      
      // 长度转换示例
      'km->m': [
        '1 km = 1000 m',
        '0.5 km = 500 m',
        '2.5 km = 2500 m',
        '42.195 km = 42195 m (马拉松距离)',
      ],
      'mi->km': [
        '1 mi = 1.60934 km',
        '26.2 mi = 42.195 km (马拉松距离)',
        '100 mi = 160.934 km',
      ],
      
      // 重量转换示例
      'kg->g': [
        '1 kg = 1000 g',
        '0.5 kg = 500 g',
        '2.5 kg = 2500 g',
        '0.1 kg = 100 g',
      ],
      'lb->kg': [
        '1 lb = 0.453592 kg',
        '2.2 lb ≈ 1 kg',
        '100 lb = 45.3592 kg',
      ],
      
      // 更多示例...
    };
    return examples['$fromUnit->$toUnit'] ?? [];
  }

  // 获取单位类型
  String? _getUnitType() {
    final unitTypes = {
      'c': '温度', 'f': '温度', 'k': '温度',
      'km': '长度', 'm': '长度', 'cm': '长度', 'mm': '长度',
      'mi': '长度', 'ft': '长度', 'in': '长度', 'yd': '长度',
      'kg': '重量', 'g': '重量', 'mg': '重量',
      'lb': '重量', 'oz': '重量', 't': '重量',
      // ... 更多单位类型
    };
    return unitTypes[fromUnit];
  }
} 