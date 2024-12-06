import 'package:example/facebook/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class FacebookProductComparePage extends StatelessWidget {
  final List<Product> products;

  const FacebookProductComparePage({
    required this.products,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '商品对比'.text.f20.bold.mk,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('商品信息')),
            DataColumn(label: Text('商品1')),
            DataColumn(label: Text('商品2')),
          ],
          rows: [
            _buildDataRow('商品图片', products.map((p) => p.imageUrl.image.s80.rounded8.mk).toList()),
            _buildDataRow('商品名称', products.map((p) => p.name.text.f14.mk).toList()),
            _buildDataRow('价格', products.map((p) => '¥${p.price}'.text.blue.f14.bold.mk).toList()),
            _buildDataRow('商品状态', products.map((p) => p.condition.text.f14.mk).toList()),
            _buildDataRow('所在地', products.map((p) => p.location.text.f14.mk).toList()),
            _buildDataRow('卖家', products.map((p) => p.sellerName.text.f14.mk).toList()),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow(String label, List<Widget> cells) {
    return DataRow(
      cells: [
        DataCell(label.text.grey600.f14.mk),
        ...cells.map(DataCell.new),
      ],
    );
  }
}
